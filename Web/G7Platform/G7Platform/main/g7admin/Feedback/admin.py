from django.contrib import admin
from Feedback.models import G7FeedbackModel

class G7FeedbackAdmin(admin.ModelAdmin):
    pass

admin.site.register(G7FeedbackModel, G7FeedbackAdmin)