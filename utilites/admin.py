# Register your models here.
from django.contrib import admin
from .models import *

from django.contrib import admin


# Register your models here.
@admin.register(Utilita)
class UtilitaAdmin(admin.ModelAdmin):
    list_display = ('title', 'description', 'author', 'count_downloads',)
    search_fields = ('title', 'description', 'author',)

    list_per_page = 5
    actions_on_top = True
    actions_on_bottom = True
    actions_selection_counter = True
    save_on_top = True
