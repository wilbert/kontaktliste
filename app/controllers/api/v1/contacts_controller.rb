module Api
  module V1
    # Contats resource actions defintion
    class ContactsController < ApplicationController
      def index
        params[:q] ||= {}

        params[:q][:s] = 'city_state_acronym' if params[:q][:s] == 'nationality'

        @search = Contact.search(params[:q])
        @contacts = @search.result
        @contacts = @contacts.orphans if params[:q][:name_or_email_or_postal_address_cont].blank?

        render json: @contacts, meta: { total: Contact.count }
      end

      def show
        @contact = Contact.find(params[:id])
        render json: @contact
      end

      def update
        @contact = Contact.find(params[:id])

        if @contact.update(contact_params)
          head :no_content
        else
          render json: @contact.errors, status: :unprocessable_entity
        end
      end

      private

      def contact_params
        params.require(:contact).permit(:manager_id, :name)
      end
    end
  end
end
