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

class ProfileMatch < ActiveRecord::Base
  validates :advisor_profile_id, uniqueness: { scope: :potential_client_profile_id }
  belongs_to :advisor_profile, class_name: 'LinkedinProfile'
  belongs_to :potential_client_profile, class_name: 'LinkedinProfile'
end
