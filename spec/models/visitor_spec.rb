require 'rails_helper'

RSpec.describe Visitor, type: :model do
  it { is_expected.to validate_uniqueness_of :session_id }
end
