class FormController < ApplicationController
  skip_before_action :verify_authenticity_token
  include HTTParty
  include FormHelper

  def new
  end

  def create
    response = HTTParty.post(create_url, query: build_post_data(permitted_params))

    respond_to do |format|
      case response.code
      when 201
        format.js
      else
        format.js { render 'unsuccessful', locals: { errors: build_errors(JSON.parse(response.body)['errors']) } }
      end
    end
  end

  private

  def permitted_params
    params.permit(:name, :business_name, :email, :telephone)
  end
end
