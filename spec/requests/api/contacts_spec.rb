require 'rails_helper'

RSpec.describe 'Api::Contacts', type: :request do
  describe 'POST /contacts' do
    let(:data) { { email: 'foo@bar.com', message: 'test message' } }
    let(:last_contact) { Contact.last }

    it 'creates a contact' do
      expect { post api_contacts_path, data }.to change(Contact, :count).by(1)
      expect(response).to have_http_status 201
      expect(response.content_type).to eq 'application/json'
      expect(response.body).to eq last_contact.to_json
    end

    context 'With visited pages' do
      before do
        cookies['session_id'] = 'foo_session_id'
      end

      let!(:visitor) { Visitor.create! session_id: 'foo_session_id' }
      let(:data) { { email: 'baz@bar.com', message: 'test message' } }

      it "assigns the contact's email to the current visitor" do
        post api_contacts_path, data
        expect(visitor.reload.email).to eq data[:email]
      end
    end

    context 'when there is a validation error' do
      let(:expected_errors) { { 'email' => ["can't be blank"] } }

      it 'returns the errors messages' do
        post api_contacts_path

        expect(response).to have_http_status 400
        expect(response_json['errors']).to include expected_errors
      end
    end
  end
end
