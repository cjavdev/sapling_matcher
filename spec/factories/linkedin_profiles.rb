FactoryGirl.define do
  factory :linkedin_profile do
    sequence :link do |n|
      "https://www.linkedin.com/pub/cj-avilla/19/772/577?x=#{ n }"
    end
    client_type "Advisor"
    first_name "first"
    last_name "last"
  end
end
