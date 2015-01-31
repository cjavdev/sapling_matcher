# == Schema Information
#
# Table name: websites
#
#  id                  :integer          not null, primary key
#  name                :string
#  linkedin_profile_id :integer
#

require 'rails_helper'

RSpec.describe Website, :type => :model do
  it { should belong_to(:linkedin_profile) }
end
