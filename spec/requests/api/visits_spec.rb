require 'rails_helper'

RSpec.describe 'Api::Visits', type: :request do
  describe 'POST /visit' do
    let(:data) { { url: 'http://foobar.com/', datetime: Time.now } }
    let(:last_visit) { Visit.last }
    let(:new_visitor) { Visitor.find_by_session_id cookies['session_id'] }

    context 'when it is from a new visitor' do
      before do
        cookies.delete :session_id
      end

      it 'creates a visit and visitor' do
        expect { post api_visits_path, data }.to change(Visit, :count).by(1)
        expect(response).to have_http_status 201
        expect(response.content_type).to eq 'application/json'
        expect(response.body).to eq last_visit.to_json
        expect(response_json['visitor_id']).to eq new_visitor.id
      end
    end

    context 'when it is from a returning visitor' do
      before do
        cookies['session_id'] = 'foo_session_id'
      end

      let!(:returning_visitor) { Visitor.create! session_id: 'foo_session_id' }

      it 'creates a visit to the returning visitor' do
        expect { post api_visits_path, data }.to change(Visit, :count).by(1)
        expect(response).to have_http_status 201
        expect(response.content_type).to eq 'application/json'
        expect(response.body).to eq last_visit.to_json
        expect(response_json['visitor_id']).to eq returning_visitor.id
      end
    end

    context 'when there is a validation error' do
      let(:expected_errors) { { 'url' => ["can't be blank"] } }

      it 'returns the errors messages' do
        post api_visits_path

        expect(response).to have_http_status 400
        expect(response_json['errors']).to include expected_errors
      end
    end
  end
end
