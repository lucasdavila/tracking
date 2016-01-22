class Visitor < ActiveRecord::Base
  validates :session_id, uniqueness: true
end
