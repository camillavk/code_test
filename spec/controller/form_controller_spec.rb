require 'rails_helper'

RSpec.describe FormController, type: :controller do
  context '#GET' do
    it 'should respond with an HTTP 200 Status' do
      get :new

      expect(response).to be_successful
    end
  end

  context '#POST' do
    let(:subject) { post :create, params: params }

    context 'with correct params' do
      let(:params) {
        {
          name: 'Test test',
          business_name: 'test',
          email: 'test@example.com',
          telephone: '09182387463'
        }
      }

      it 'should respond with an HTTP 200 Status' do
        VCR.use_cassette('successful_create') do
          subject

          expect(response).to be_successful
          expect(response).to render_template :success
        end
      end
    end

    context 'with incorrect params' do
      let(:params) {
        {
          name: 'Test',
          business_name: 'test',
          email: 'test@example.com',
          telephone: '09182387463'
        }
      }

      it 'should alert the user that there was an error' do
        VCR.use_cassette('incorrect_params') do
          subject

          expect(response).to render_template :new
        end
      end

    end
  end
end
