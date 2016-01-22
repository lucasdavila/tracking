class Visit < ActiveRecord::Base
  validates :visitor_id, :url, :datetime, presence: true

  belongs_to :visitor
end
