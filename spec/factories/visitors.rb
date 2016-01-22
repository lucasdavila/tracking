FactoryGirl.define do
  factory :visitor do
    sequence :session_id do |n|
      "session_id_#{n}"
    end
  end

end
