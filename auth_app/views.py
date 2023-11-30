from django.conf import settings
from django.contrib.auth import login
from django.contrib.auth.models import Group
from django.contrib.auth.views import LoginView
from django.shortcuts import redirect
from .forms import LoginForm, RegisterForm
from django.views.generic.edit import CreateView
from datetime import datetime
from .signals import send_login_user_email, account_access

# Create your views here.


class UserLoginView(LoginView):
    authentication_form = LoginForm
    template_name = 'login.html'
    next_page = 'index'

    def form_valid(self, form):
        is_remember = self.request.POST.get('is_remember', 'off')
        if is_remember == 'on':
            self.request.session[settings.REMEMBER_KEY] = datetime.now().isoformat()
            self.request.session.set_expiry(settings.REMEMBER_AGE)
        elif is_remember == 'off':
            self.request.session.set_expiry(0)

        # Отправка email с сообщением о входе в аккаунт
        account_access.send(sender=self.__class__, request=self.request)

        return super(UserLoginView, self).form_valid(form)


class RegisterView(CreateView):
    form_class = RegisterForm
    template_name = 'register.html'

    def form_valid(self, form):
        user = form.save()
        login(self.request, user)
        return redirect('index')
