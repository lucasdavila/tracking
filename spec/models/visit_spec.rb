require 'rails_helper'

RSpec.describe Visit, type: :model do
  it { is_expected.to belong_to :visitor }

  it { is_expected.to validate_presence_of :visitor_id }
  it { is_expected.to validate_presence_of :url }
  it { is_expected.to validate_presence_of :datetime }
end
