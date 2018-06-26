require 'rails_helper'

RSpec.describe FormController, type: :controller do
  it 'should respond with an HTTP 200 Status' do
    get :new

    expect(response).to be_successful
  end
end
