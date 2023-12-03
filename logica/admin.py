# Register your models here.
from django.contrib import admin
from .models import *


@admin.register(Rubrika)
class RubrikaAdmin(admin.ModelAdmin):
    list_display = ('naim', 'author',)
    list_display_links = ('author',)
    list_editable = ('naim',)
    search_fields = ('naim',)

    list_per_page = 5
    actions_on_top = True
    actions_on_bottom = True
    actions_selection_counter = True
    save_on_top = True
    # filter_horizontal = ('authors', )


@admin.register(Statya)
class StatyaAdmin(admin.ModelAdmin):
    list_display = ('title', 'description', 'data_publication', 'content', 'kartinka', 'count_views', )
    search_fields = ('title', 'author', 'description', )

    list_per_page = 5
    actions_on_top = True
    actions_on_bottom = True
    actions_selection_counter = True
    save_on_top = True


@admin.register(Comment)
class CommentAdmin(admin.ModelAdmin):
    list_display = ('content', 'author_comment', 'date', 'statya', )
    search_fields = ('content', 'author_comment', 'date', 'statya', )

    list_per_page = 5
    actions_on_top = True
    actions_on_bottom = True
    actions_selection_counter = True
    save_on_top = True


@admin.register(Ocenka)
class OcenkaAdmin(admin.ModelAdmin):
    list_display = ('komu', 'author_ocenka', 'bal',)
    search_fields = ('komu', 'author_ocenka', 'bal',)

    list_per_page = 5
    actions_on_top = True
    actions_on_bottom = True
    actions_selection_counter = True
    save_on_top = True

