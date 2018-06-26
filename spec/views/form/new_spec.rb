require 'rails_helper'

describe 'form/new.html.erb' do
  it 'should display company information' do
    render template: 'form/new.html.erb'

    expect(rendered).to match(/Make it Cheaper/)
  end
end
