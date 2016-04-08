from django.contrib import admin
from MyTest.models import MyTestModel
# Register your models here.

class MyTestAdmin(admin.ModelAdmin):
	"""docstring for MyTestAdmin"""
	pass
		
admin.site.register(MyTestModel, MyTestAdmin)		