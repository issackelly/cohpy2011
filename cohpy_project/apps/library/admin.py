from django.contrib import admin
from library.models import Book, Publisher, Checkout, Review

class PublisherAdmin(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('title',)}
admin.site.register(Publisher, PublisherAdmin)


class BookAdmin(admin.ModelAdmin):
    list_display  = ('title', 'pages')
    prepopulated_fields = {'slug': ('title',)}
admin.site.register(Book, BookAdmin)
admin.site.register(Checkout)
admin.site.register(Review)
