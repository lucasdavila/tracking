FactoryGirl.define do
  factory :visit do
    visitor
    url 'http://foo.com/about'
    datetime Time.now
  end
end
