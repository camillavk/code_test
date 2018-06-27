require 'rails_helper'

RSpec.describe FormController, type: :controller do
  context '#GET' do
    it 'should respond with an HTTP 200 Status' do
      get :new

      expect(response).to be_successful
    end
  end

  context '#POST' do
    let(:subject) { post :create, xhr: true, params: params }

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
          expect(response).to render_template :create
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

          expect(response).to render_template :unsuccessful
        end
      end
    end

    context 'when the api is down' do
      before do
        stub_request(:post, "http://mic-leads.dev-test.makeiteasy.com/api/v1/create?access_token=21bdb69c4089409e0938a33cff040acd&business_name=test&email=test@example.com&name=Test%20test&pAccName=MicDevtest&pGUID=CFFBF53F-6D89-4B5B-8B36-67A97F18EDEB&pPartner=MicDevtest&telephone_number=09182387463").
          to_return(status: 500, body: "{\"errors\":[\"Can't contact Queue Server. Try again later\"]}")
      end
      let(:params) {
        {
          name: 'Test test',
          business_name: 'test',
          email: 'test@example.com',
          telephone: '09182387463'
        }
      }

      it 'should alert the user that the form cannot be saved' do
        VCR.turned_off do
          subject

          expect(response).to render_template :unsuccessful
        end
      end
    end
  end
end
