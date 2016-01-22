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
    Visit.joins(:visitor).where('visitors.email = ?', @contact.email).uniq :url
  end
end
