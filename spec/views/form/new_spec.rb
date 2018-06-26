require 'rails_helper'

describe 'form/new.html.erb' do
  it 'should display company information' do
    render template: 'form/new.html.erb'

    expect(rendered).to match(/Make it Cheaper/)
  end

  it 'should display form fields' do
    render template: 'form/new.html.erb'

    expect(rendered).to include('Name')
    expect(rendered).to include('Business Name')
    expect(rendered).to include('Email')
    expect(rendered).to include('Telephone')
  end
end
