require 'rails_helper'

RSpec.feature 'Contacts', type: :feature do
  before do
    create :contact
  end

  let(:contact) { Contact.first }

  scenario 'User Visits the index page' do
    visit contacts_path

    expect(page).to have_text 'Contacts'

    within('table tbody tr') do
      expect(page).to have_link contact.email, href: contact_path(contact)
      expect(page).to have_text contact.message
    end
  end
end
