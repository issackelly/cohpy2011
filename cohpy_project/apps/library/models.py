from django.conf import settings
from django.contrib.auth.models import User
from django.db import models
from django.db.models import permalink
from easy_thumbnails.fields import ThumbnailerImageField
import datetime

class Book(models.Model):
    """Listing of books"""
    title = models.CharField(max_length=255)
    author = models.CharField(max_length=255)
    prefix = models.CharField(max_length=20, blank=True)
    subtitle = models.CharField(blank=True, max_length=255)
    slug = models.SlugField(unique=True)
    isbn = models.CharField(max_length=14, blank=True)
    pages = models.PositiveSmallIntegerField(blank=True, null=True, default=0)
    publisher = models.ForeignKey("Publisher", blank=True, null=True)
    published = models.DateField(blank=True, null=True)
    cover = ThumbnailerImageField(
        upload_to='book_covers',
        resize_source=dict(size=(800, 1600)),
    )
    description = models.TextField(blank=True)
    created = models.DateTimeField(auto_now_add=True)
    modified = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'books'
        ordering = ('title',)

    def __unicode__(self):
        return '%s' % self.full_title

    @property
    def full_title(self):
        if self.prefix:
            return '%s %s' % (self.prefix, self.title)
        else:
            return '%s' % self.title

    @permalink
    def get_absolute_url(self):
        return ('book_detail', None, { 'slug': self.slug })
    
    @property
    def is_out(self):
        if self.checkout_set.filter(date_returned__isnull=True).count():
            return True
        return False

    def out_to(self):
        """
        This is not a very safe method. your data could get screwed up, or you could 
        call this method when no user has checked this out.  Just an example of 
        something stupid you can do with class methods
        """
        return self.checkout_set.get(date_returned__isnull=True)

    @property
    def amazon_url(self):
        if self.isbn:
            try:
                return 'http://www.amazon.com/dp/%s/?%s' % (self.isbn, settings.AMAZON_AFFILIATE_EXTENTION)
            except:
                return 'http://www.amazon.com/dp/%s/' % self.isbn
        return ''


class Publisher(models.Model):
    """Publisher"""
    title = models.CharField(max_length=100)
    prefix = models.CharField(max_length=20, blank=True)
    slug = models.SlugField(unique=True)
    website = models.URLField(blank=True, verify_exists=False)
    logo = ThumbnailerImageField(
        upload_to='publisher_logos',
        resize_source=dict(size=(400, 400)),
    )

    class Meta:
        db_table = 'book_publishers'
        ordering = ('title',)

    def __unicode__(self):
        return '%s' % self.full_title

    @property
    def full_title(self):
        return '%s %s' % (self.prefix, self.title)

    @permalink
    def get_absolute_url(self):
        return ('book_publisher_detail', None, { 'slug':self.slug })

class Checkout(models.Model):
    date = models.DateField(default=datetime.datetime.now())
    user = models.ForeignKey(User)
    date_returned = models.DateField(blank=True, null=True)
    book = models.ForeignKey(Book)

class Review(models.Model):
    CHOICES = (
        (1, 1),
        (2, 2),
        (3, 3),
        (4, 4),
        (5, 5),
    )
    date = models.DateField(auto_now=True)
    user = models.ForeignKey(User)
    book = models.ForeignKey(Book)
    why_did_you_get_this_book = models.TextField(blank=True, null=True)
    did_you_like_it = models.TextField(blank=True, null=True)
    stars = models.IntegerField(choices=CHOICES)
