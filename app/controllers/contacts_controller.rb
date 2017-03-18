class ContactsController < ApplicationController
  def index
    @search = Contact.search(params[:q])
    @contacts = @search.result
  end
end
