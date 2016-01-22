class Api::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  protected

  def current_visitor
    @current_visitor ||= Visitor.find_by_session_id current_session_id
  end

  def current_session_id
    cookies[:session_id]
  end
end
