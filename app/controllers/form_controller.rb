class FormController < ApplicationController
  skip_before_action :verify_authenticity_token
  include HTTParty

  def new
  end

  def create
    response = HTTParty.post(create_url, query: build_post_data)

    case response.code
    when 201
      render :success
    when 400
      render :new, locals: { errors: JSON.parse(response.body)['errors'] }
    end
  end

  private

  def permitted_params
    params.permit(:name, :business_name, :email, :telephone)
  end

  def build_post_data
    {
      'access_token' => access_token,
      'pGUID' => pguid,
      'pAccName' => account_name,
      'pPartner' => partner,
      'name' => permitted_params['name'],
      'business_name' => permitted_params['business_name'],
      'telephone_number' => permitted_params['telephone'],
      'email' => permitted_params['email']
    }
  end

  def access_token
    ENV['LEAD_API_ACCESS_TOKEN']
  end

  def pguid
    ENV['LEAD_API_PGUID']
  end

  def account_name
    ENV['LEAD_API_PACCNAME']
  end

  def partner
    ENV['LEAD_API_PPARTNER']
  end

  def create_url
    ENV['LEAD_API_URI'] + '/api/v1/create'
  end
end
