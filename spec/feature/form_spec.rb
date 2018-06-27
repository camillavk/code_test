require 'rails_helper'

describe 'Sign up page', type: :feature do
  it 'will display a basic form to request a call back' do
    visit '/'
    expect(page).to have_field 'name'
    expect(page).to have_field 'business_name'
    expect(page).to have_field 'email'
    expect(page).to have_field 'telephone'
  end

  it 'will successfully send leads to the API on form submission with a thank you message', js: true do
    VCR.use_cassette('successful_signup') do
      visit '/'
      fill_in 'name', with: 'New User'
      fill_in 'business_name', with: 'Business'
      fill_in 'email', with: 'test@example.com'
      fill_in 'telephone', with: '01234567891'
      click_button 'Submit'

      expect(page).to have_content('Your register success')
    end
  end

  context 'validating form fields' do
    it 'will display errors if fields are incorrect', js: true do
      VCR.use_cassette('invalid_fields') do
        visit '/'
        fill_in 'name', with: ''
        fill_in 'business_name', with: ''
        fill_in 'email', with: 'test@example.com'
        fill_in 'telephone', with: '0123'
        click_button 'Submit'

        expect(page).to have_content('Name must contain firstname and lastname')
        expect(page).to have_content('Name is required')
        expect(page).to have_content('Business name is required')
        expect(page).to have_content('Telephone number need 11 numbers (can accept international syntax +44)')
      end
    end
  end
end
