# Describes contacts requests handle
class ContactsController < ApplicationController
  def index
    @search = Contact.orphans.search(params[:q])
    @contacts = @search.result
  end
end
