from datetime import datetime


def global_context(request):
    return {'CURRENT_YEAR': datetime.now().year}