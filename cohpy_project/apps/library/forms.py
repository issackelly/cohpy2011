from django import forms
from django.contrib.auth.models import User
import datetime

from library.models import Book, Checkout, Review

class CheckoutForm(forms.ModelForm):
    user = forms.ModelChoiceField(widget=forms.HiddenInput(), queryset=User.objects.all())
    book = forms.ModelChoiceField(widget=forms.HiddenInput(), queryset=Book.objects.all())
        
    def __init__(self, *args, **kwargs):
        book = kwargs.pop("book", None)
        user = kwargs.pop("user", None)
        if book is None or user is None:
            raise "did not pass book and user in"
        super(CheckoutForm, self).__init__(*args, **kwargs)
        self.fields["book"].initial = book
        self.fields["user"].initial = user
    
    class Meta:
        exclude = ["date", "date_returned",]
        model = Checkout

class ReviewForm(forms.ModelForm):
    user = forms.ModelChoiceField(widget=forms.HiddenInput(), queryset=User.objects.all())
    book = forms.ModelChoiceField(widget=forms.HiddenInput(), queryset=Book.objects.all())
    
    def __init__(self, *args, **kwargs): 
        book = kwargs.pop("book", None)
        user = kwargs.pop("user", None)
        if book is None or user is None:
            raise "did not pass book and user in"
        super(ReviewForm, self).__init__(*args, **kwargs)
        self.fields["book"].initial = book
        self.fields["user"].initial = user
    
    class Meta:
        model = Review