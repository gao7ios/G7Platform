from django.contrib import admin
# Register your models here.
from Application.models import G7Application,G7Project

from django import forms
from django.contrib.admin.widgets import RelatedFieldWidgetWrapper,FilteredSelectMultiple
from django.utils.translation import ugettext_lazy as _
from django.db.models.fields import FieldDoesNotExist
from django.utils import timezone
import uuid,time
from django.db.models import Q

class G7ProjectForm(forms.ModelForm):

    def __init__(self, *args, **kwargs):
        super(G7ProjectForm, self).__init__(*args, **kwargs)
        self.instance.identifier = str(uuid.uuid3(uuid.uuid4(),str(time.time())).hex)

class G7ProjectAdmin(admin.ModelAdmin):

    list_display = ('icon_preview','id','name','modified_at', 'create_at',)
    filter_horizontal = ("applications","members")
    form = G7ProjectForm
    fieldsets = (
        (None, {'fields': ('name', "description","owner","icon")}),
        ('状态', {'fields': ("project_status",)}),
        ('基本信息', {'fields': ("platform","bundleID","project_id","project_type","latest_version","latest_inner_version","latest_build_version")}),
        ('应用产品', {'fields': ("applications","identifier")}),
        ('成员', {'fields': ("members",)}),
    )
    # add_fieldsets is not a standard ModelAdmin attribute. UserAdmin
    # overrides get_fieldsets to use this attribute when creating a user.
    add_fieldsets = (
        (None, {'fields': ('name',"owner","icon")}),
        ('基本信息', {'fields': ("platform","bundleID","project_id","project_type","latest_version","latest_inner_version","latest_build_version")}),
        ('应用产品', {'fields': ('applications',)}),
        ('项目成员', {'fields': ('members',)}),
    )

    readonly_fields = ("identifier",)

    def to_field_allowed(self, request, to_field):
        rv = super(G7ProjectAdmin, self).to_field_allowed(request, to_field)
        if not rv:
            opts = self.model._meta
            try:
                return opts.get_field(to_field)==opts.pk and len(opts.many_to_many)
            except FieldDoesNotExist:
                return False
        return rv


class G7ApplicationForm(forms.ModelForm):

    projects = forms.ModelMultipleChoiceField(
        queryset=G7Project.objects.all(),
        required=False,
        widget=FilteredSelectMultiple(verbose_name=_(u'项目'),is_stacked=False),
        label=_(u"项目")
    )

    class Meta:
        model = G7Application
        fields = '__all__'

    def __init__(self, *args, **kwargs):
        super(G7ApplicationForm, self).__init__(*args, **kwargs)
        self.instance.appid = str(uuid.uuid3(uuid.uuid4(),str(time.time())).hex)

        if self.instance.pk:
            self.fields['projects'].initial = self.instance.projects.all()
            self.fields['projects'].widget = RelatedFieldWidgetWrapper(
                                                FilteredSelectMultiple(_(u'项目'),False),
                                                G7Project._meta.get_field('applications').rel,
                                                admin.site)
            self.fields['projects'].queryset = G7Project.objects.all()

            self.fields["frameworks"].initial = self.instance.frameworks.all()
            self.fields["frameworks"].queryset = G7Application.objects.filter(Q(product_type=1) | Q(product_type=2) | Q(product_type=4))
            self.fields['frameworks'].widget = RelatedFieldWidgetWrapper(
                                                FilteredSelectMultiple(_(u'项目'),False),
                                                G7Application._meta.get_field('frameworks').rel,
                                                admin.site)



    def save(self, commit=True):
        instance = super(G7ApplicationForm, self).save(commit=commit)
        if instance.pk:
            for project in instance.projects.all():
                if project not in self.cleaned_data['projects']:
                    instance.projects.remove(project)
            for project in self.cleaned_data['projects']:
                if project not in instance.projects.all():
                    instance.projects.add(project)
        else:
            self.instance.save()
            for project in self.cleaned_data["projects"]:
                project.applications.add(self.instance)
        if commit:
            instance.save()

        return instance


class G7ApplicationAdmin(admin.ModelAdmin):

    list_display = ('icon_preview','name', 'build_version','modified_at')
    form = G7ApplicationForm
    search_fields = ('name',)
    ordering = ('id',)

    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('name',"frameworks", "inner_version", "icon", "product_type",  "version",'bundleID','projects')}
        )
    )
    
    fieldsets = (
        (_(u"简介"), {'fields': ("name",  "user","product_id", "inner_version", "channel", "product_type", "version", "icon", "build_version")}),
        (_(u"说明"), {'fields': ( "description", )}),
        (_(u"应用包"), {'fields': ("file", "dsymFile", "bundleID", "identifier" ,)}),
        (_(u"使用到的框架"), {"fields":("frameworks",)}),
        (_(u"选择产品"), {'fields': ("projects",)}),
    )


    filter_horizontal = ("frameworks",)
    readonly_fields = ['icon_preview',"identifier", "build_version"]


    # exclude = ("applications",)

admin.site.register(G7Project, G7ProjectAdmin)
admin.site.register(G7Application, G7ApplicationAdmin)
