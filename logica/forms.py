from django.forms import Textarea, TextInput
from django.core.exceptions import ValidationError
from django import forms
from .models import *


class StatyaForm(forms.ModelForm):
    rubrika = forms.ModelChoiceField(queryset=Rubrika.objects.all(), empty_label='Выберите рубрику', required=True,
                                    label='Рубрика', help_text='Укажите рубрику, к которому Вы хотите добавить статью!')

    description = forms.CharField(widget=Textarea(attrs={'placeholder': 'Опишите содержание статьи',
                                                         'rows': 20, 'cols': 35, }), label='')

    error_css_class = 'error_field'
    required_css_class = 'required_field'

    class Meta:
        model = Statya
        fields = ('title', 'description', 'content', 'rubrika', 'kartinka',)
        labels = {'title': '', 'description': '', 'content': '', 'rubrika': '', 'kartinka': ''}
        widgets = {'title': TextInput(attrs={'placeholder': 'Введите название статьи'}),
                   'description': Textarea(attrs={
                       'placeholder': 'Опишите содержание статьи',
                       'rows': 20,
                       'cols': 35}),
                   'content': Textarea(attrs={
                       'placeholder': 'Укажите содержание статьи',
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


class FilterOrderByForm(forms.Form):
    CHOICES = (
        ('count_views', 'По возрастанию просмотров'),
        ('-count_views', 'По убыванию просмотров'),
    )

    field_order = ['rub', 'search', ]

    order = forms.ChoiceField(label='Порядок сортировки', label_suffix=':', choices=CHOICES, initial=CHOICES[0])

    CHOICES2 = []

    for elem in Rubrika.objects.all():
        CHOICES2.append((elem.naim, elem.naim))

    rub = forms.ChoiceField(label='Рубрика', label_suffix=':',choices=CHOICES2, required=True, initial='')

    search = forms.CharField(label='Поиск', label_suffix=':', required=False,
                             widget=TextInput(attrs={'placeholder': 'Введите запрос ...'}))


class FilterRubrikaForm(forms.Form):

    #search = forms.CharField(label='Поиск', label_suffix=':', required=False,
     #                        widget=TextInput(attrs={'placeholder': 'Введите запрос ...'}))

    CHOICES2 = []

    for elem in Rubrika.objects.all():
        CHOICES2.append((elem.naim, elem.naim))

    rub = forms.ChoiceField(label='', choices=CHOICES2, initial=CHOICES2[0])


class SettingForm(forms.Form):
    paginate_by = forms.IntegerField(label='Записей на одной странице', min_value=2, max_value=20, initial=5)