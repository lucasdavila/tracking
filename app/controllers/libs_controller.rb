class LibsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def tracker
    render 'tracker.js'
  end
end
