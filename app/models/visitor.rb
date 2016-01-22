class Visitor < ActiveRecord::Base
  validates :session_id, uniqueness: true

  has_many :visits
end
