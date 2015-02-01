# == Schema Information
#
# Table name: linkedin_profiles
#
#  id           :integer          not null, primary key
#  link         :string           not null
#  advisor      :boolean          default("false")
#  first_name   :string
#  last_name    :string
#  summary      :text
#  page         :text
#  picture      :string
#  title        :string
#  industry     :string
#  linkedin_url :string
#  location     :string
#  country      :string
#  client_type  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :linkedin_profile do
    link "https://www.linkedin.com/pub/cj-avilla/19/772/577"
    sequence :location do |n|
      "place_#{ n }"
    end
    client_type "Advisor"
    first_name "first"
    last_name "last"
  end
end
