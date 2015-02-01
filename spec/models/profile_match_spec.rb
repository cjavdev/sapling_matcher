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

require 'rails_helper'

RSpec.describe ProfileMatch, :type => :model do
  it { should belong_to(:advisor_profile) }
  it { should belong_to(:potential_client_profile) }
end
