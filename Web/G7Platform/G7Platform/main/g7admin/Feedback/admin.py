from django.contrib import admin
from Feedback.models import G7FeedbackModel

# Register your models here.
class G7FeedbackAdmin(admin.ModelAdmin):
    # 设置为pass 代表着这个类只是继承了父类，并没有添加或者重写任何东西，同时意味着django会自动帮你解析G7Feedback中所定义的那些属性
    pass

# 连接模型和G7FeedbackAdmin
admin.site.register(G7FeedbackModel, G7FeedbackAdmin)