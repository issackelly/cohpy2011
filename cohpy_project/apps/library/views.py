from django.contrib.auth.decorators import login_required
from django.http import HttpResponseForbidden
from django.shortcuts import render_to_response, get_object_or_404, redirect
from django.template import RequestContext
import datetime

from library.forms import CheckoutForm, ReviewForm
from library.models import Book, Checkout, Review


@login_required
def review(request, book_pk, review_pk=None):
    book = get_object_or_404(Book, pk=book_pk)
    if review_pk:
        review = get_object_or_404(Review, pk=review_pk)
        if review.user != request.user:
            return HttpResponseForbidden("Hey! Don't do that!")
    else:
        review = None
    form = ReviewForm(request.POST or None, book=book, user=request.user, instance=review)
    
    if form.is_valid():
        # use commit=False to keep making changes to the model
        # after you save the form
        review = form.save(commit=False)
        
        # Force the user, just in case any maliciousness has happened
        # on the level of the form
        review.user = request.user
        
        review.save()
        ##@@ Add a message
        return redirect("book_detail", book.slug)
    
    if request.is_ajax():
        template = "library/_review_form.html"
    else:
        template = "library/review_form.html"
    
    return render_to_response(template, {
        "form": form,
        "book": book,
        "review": review
    }, context_instance=RequestContext(request))


@login_required
def checkout(request, book_pk, checkout_pk=None, checkin=False):
    book = get_object_or_404(Book, pk=book_pk)
    if checkout_pk:
        checkout = get_object_or_404(Checkout, pk=checkout_pk)
        if checkout.user != request.user:
            return HttpResponseForbidden("Hey! Don't do that!")
    else:
        checkout = None
    form = CheckoutForm(request.POST or None, book=book, user=request.user, instance=checkout)
    
    if form.is_valid():
        # use commit=False to keep making changes to the model
        # after you save the form
        checkout = form.save(commit=False)
        
        # Force the user, just in case any maliciousness has happened
        # on the level of the form
        checkout.user = request.user
        
        if checkin in [True, "True", "true", "t", "T", "checkin", "CHECKIN"]:
            checkout.date_returned = datetime.datetime.now()
        
        checkout.save()
        
        ##@@ Add a message        
        return redirect("book_detail", book.slug)
    
    if request.is_ajax():
        template = "library/_checkout_form.html"
    else:
        template = "library/checkout_form.html"
    
    if checkin in [True, "True", "true", "t", "T", "checkin", "CHECKIN"]:
        checkin = "Check In"
    else:
        checkin = "Check Out"
        
    return render_to_response(template, {
        "form": form,
        "book": book,
        "checkout": checkout,
        "checkin": checkin,
    }, context_instance=RequestContext(request))