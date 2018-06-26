require 'rails_helper'

describe 'form/success.html.erb' do
  it 'should display company information' do
    render template: 'form/success.html.erb'

    expect(rendered).to match(/Your form was successfully submitted!/)
  end
end
