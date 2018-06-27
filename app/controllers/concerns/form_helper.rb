module FormHelper
  def build_post_data(params)
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

  def build_errors(errors)
    errors.map do |error|
      errors_hash[error.to_sym]
    end
  end

  def errors_hash
    {
      "Field 'name' isn't present": "name_is_required",
      "Field 'name' wrong format, 'name' must be composed with 2 separated words (space between)": "firstname_space_lastname",
      "Field 'name' is blank": "name_is_required",
      "Field 'business_name' is blank": "business_is_required",
      "Field 'telephone_number' wrong format (must contain have valid phone number with 11 numbers. string max 13 chars)": "phone_number_11_numbers",
      "Can't contact Queue Server. Try again later": "internal_error_retry_later"
    }
  end
end
