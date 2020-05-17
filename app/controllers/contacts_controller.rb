class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
      if @contact.save
        redirect_to complite_path
      else
        render 'new'
      end
  end

  private

    def contact_params
      params.require(:contact).permit(:contact, :user_id)
    end
end
