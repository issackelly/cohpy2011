from django.conf import settings
from django.conf.urls.defaults import *
from django.views.generic.simple import redirect_to

from django.contrib import admin
admin.autodiscover()

from pinax.apps.account.openid_consumer import PinaxConsumer


handler500 = "pinax.views.server_error"


urlpatterns = patterns("",
    url(r"^library/", include("library.urls")),
    url(r"^admin/invite_user/$", "pinax.apps.signup_codes.views.admin_invite_user", name="admin_invite_user"),
    url(r"^admin/", include(admin.site.urls)),
    url(r"^account/", include("pinax.apps.account.urls")),
    url(r"^openid/", include(PinaxConsumer().urls)),
    url(r"^meetings/", redirect_to, {"url": "http://www.meetup.com/Central-Ohio-Python-Users-Group/"}),
    url(r"^servee/", include("servee.urls")),
    url(r"^frontendadmin/", include("frontendadmin.urls")),
)


if settings.SERVE_MEDIA:
    urlpatterns += patterns("",
        url(r"", include("staticfiles.urls")),
    )
