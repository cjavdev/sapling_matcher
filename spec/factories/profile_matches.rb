# == Schema Information
#
# Table name: profile_matches
#
#  id                          :integer          not null, primary key
#  advisor_profile_id          :integer
#  potential_client_profile_id :integer
#  school                      :boolean          default("false")
#  location                    :boolean          default("false")
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#

FactoryGirl.define do
  factory :profile_match do
    advisor_profile_id 1
potential_client_profile_id 1
school false
location false
  end

end
