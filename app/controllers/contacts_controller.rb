# Describes contacts requests handle
class ContactsController < ApplicationController
  def index
    params[:q] ||= {}
    @search = Contact.search(params[:q])
    @contacts = @search.result
    @contacts = @contacts.orphans if params[:q][:name_or_email_or_postal_address_cont].blank?

    render json: @contacts, meta: { total: Contact.count }
  end

  def show
    @contact = Contact.find(params[:id])
    render json: @contact
  end
end
