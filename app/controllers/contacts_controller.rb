class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
  end

  def show
    @contact = Contact.find params[:id]
    @visits = visits
  end

  protected

  def visits
    visits = Visit.all.select 'distinct on (visits.url) visits.url, *'
    visits = visits.joins :visitor
    visits = visits.where 'visitors.email = ?', @contact.email
    visits
  end
end
