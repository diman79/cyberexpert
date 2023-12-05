from django.forms import Textarea, TextInput
from django.core.exceptions import ValidationError
from django import forms
from .models import *


class UtilitaForm(forms.ModelForm):
    rubrika = forms.ModelMultipleChoiceField(queryset=Rubrika.objects.all(), widget=forms.CheckboxSelectMultiple,
                                             required=True,
                                             label='Рубрики',
                                             label_suffix=':',
                                             help_text='Укажите рубрики, к которым Вы хотите добавить утилиту!')

    description = forms.CharField(label='Описание', label_suffix=':',widget=Textarea(attrs={'placeholder': 'Опишите утилиту',
                                                         'rows': 20, 'cols': 35, }))

    moderated = forms.BooleanField(required=True, label='Пройдена модерация', label_suffix=':')

    file = forms.FileField(required=True,  label='Файл', label_suffix=':', help_text='Выберите файл < 100 Мб')

    error_css_class = 'error_field'
    required_css_class = 'required_field'

    class Meta:
        model = Utilita
        fields = ('title', 'description', 'rubrika', 'file', 'moderated', )
        labels = {'title': '', 'description': '', 'content': '', 'rubrika': '', 'kartinka': ''}
        widgets = {'title': TextInput(attrs={'placeholder': 'Введите название утилиты'}),
                   'description': Textarea(attrs={
                       'placeholder': 'Опишите описание утилиты',
                       'rows': 20,
                       'cols': 35}),
                   }

        help_texts = {'description': 'Описание не должно быть пустым'}

        def clean_preview(self):
            preview_data = self.cleaned_data['description']
            if len(preview_data) > 200:
                raise ValidationError('Слишком длинное описание! Сократите до 200 символов')

            preview_data = self.cleaned_data['content']
            if len(preview_data) > 1000:
                raise ValidationError('Слишком длинное содержание статьи! Сократите до 1000 символов')

            return preview_data


class UtilitaFormCreate(forms.ModelForm):
    rubrika = forms.ModelMultipleChoiceField(queryset=Rubrika.objects.all(), widget=forms.CheckboxSelectMultiple,
                                             required=True,
                                             label='Рубрики',
                                             label_suffix=':',
                                             help_text='Укажите рубрики, к которым Вы хотите добавить утилиту!')

    description = forms.CharField(label='Описание', label_suffix=':',widget=Textarea(attrs={'placeholder': 'Опишите утилиту',
                                                         'rows': 20, 'cols': 35, }))

    file = forms.FileField(required=True,  label='Файл', label_suffix=':', help_text='Выберите файл < 100 Мб')

    error_css_class = 'error_field'
    required_css_class = 'required_field'

    class Meta:
        model = Utilita
        fields = ('title', 'description', 'rubrika', 'file', )
        labels = {'title': '', 'description': '', 'content': '', 'rubrika': '', 'kartinka': ''}
        widgets = {'title': TextInput(attrs={'placeholder': 'Введите название утилиты'}),
                   'description': Textarea(attrs={
                       'placeholder': 'Опишите описание утилиты',
                       'rows': 20,
                       'cols': 35}),
                   }
        exclude = ('ban_author', 'moderated', )
        help_texts = {'description': 'Описание не должно быть пустым'}

        def clean_preview(self):
            preview_data = self.cleaned_data['description']
            if len(preview_data) > 200:
                raise ValidationError('Слишком длинное описание! Сократите до 200 символов')

            preview_data = self.cleaned_data['content']
            if len(preview_data) > 1000:
                raise ValidationError('Слишком длинное содержание статьи! Сократите до 1000 символов')

            return preview_data


class FilterOrderBySearchForm(forms.Form):
    CHOICES = (
        ('count_downloads', 'Сортировка по возрастанию скачиваний'),
        ('-count_downloads', 'Сортировка по убыванию скачиваний'),
        ('title', 'Сортировка по названию по возрастанию'),
        ('-title', 'Сортировка по названию по убыванию'),
    )

    field_order = ['rub', 'search', ]

    order = forms.ChoiceField(label='Порядок сортировки', label_suffix=':', choices=CHOICES, initial=CHOICES[0],
                              widget=forms.Select(attrs={'onchange': 'submit();'}))

    CHOICES2 = []

    for elem in Rubrika.objects.all():
        CHOICES2.append((elem.naim, 'Рубрика: ' + elem.naim))

    rub = forms.ChoiceField(label='Рубрика', label_suffix=':',choices=CHOICES2, required=True, initial='',
                            widget=forms.Select(attrs={'onchange': 'submit();',
                                                       'rows': '100'}))

    search = forms.CharField(label='Поиск', label_suffix=':', required=True,
                             widget=forms.TextInput(attrs={'onchange': 'submit();',
                                                           'placeholder': 'Поиск ...',
                                                           'rows': 20,
                                                           'cols': 20}))





