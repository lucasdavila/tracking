require 'rails_helper'

RSpec.feature 'Contacts', type: :feature do
  before do
    create :contact
    create :visitor, email: contact.email
    create :visitor, email: contact.email
    create :visit, visitor: visitor
    create :visit, url: 'http://foo.com/contact', visitor: visitor_another_session
    create :visit, visitor: visitor
    create :visit, url: 'http://baz.com/pricing'
  end

  let(:contact) { Contact.first }
  let(:visitor) { Visitor.first }
  let(:visitor_another_session) { Visitor.second }
  let(:first_visit) { Visit.first }
  let(:second_visit) { Visit.second }
  let(:another_visitors_visit) { Visit.last }

  scenario 'User visits the index page' do
    visit contacts_path

    expect(page).to have_text 'Contacts'

    within('table tbody tr') do
      expect(page).to have_link contact.email, href: contact_path(contact)
      expect(page).to have_text contact.message
    end
  end

  scenario 'User visits a contact page' do
    visit contact_path(contact)

    expect(page).to have_text "Contact from #{contact.email}"
    expect(page).to have_text "Message: #{contact.message}"
    expect(page).to have_text "Visited pages:"

    within('table tbody') do
      expect(page).to have_text first_visit.url, count: 1
      expect(page).to have_text first_visit.url
      expect(page).to have_text second_visit.url
      expect(page).to_not have_text another_visitors_visit.url
    end
  end
end
