class Api::ContactsController < Api::ApiController
  def create
    @contact = Contact.new permited_params

    if @contact.save
      assign_email_to_current_visitor
      render json: @contact.to_json, status: 201
    else
      render json: { errors: @contact.errors }.to_json, status: 400
    end
  end

  protected

  def permited_params
    params.permit :email, :message
  end

  def assign_email_to_current_visitor
    return if current_visitor.blank?

    current_visitor.email = @contact.email
    current_visitor.save!
  end
end
