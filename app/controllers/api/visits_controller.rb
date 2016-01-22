class Api::VisitsController < Api::ApiController
  def create
    @visit = Visit.new permited_params
    @visit.visitor = current_visitor

    if @visit.save
      render json: @visit.to_json, status: 201
    else
      render json: { errors: @visit.errors }.to_json, status: 400
    end
  end

  protected

  def permited_params
    params.permit :url, :datetime
  end

  def current_visitor
    create_visitor if current_session_id.blank? || super.blank?
    super
  end

  def create_visitor
    Visitor.create! session_id: set_session_id
  end

  def set_session_id
    cookies.permanent[:session_id] = random_session_id
  end

  def random_session_id
    SecureRandom.hex 32
  end
end
