# == Schema Information
#
# Table name: schools
#
#  id                  :integer          not null, primary key
#  name                :string
#  description         :string
#  period              :string
#  linkedin_profile_id :integer
#

require 'rails_helper'

RSpec.describe School, :type => :model do
  it { should belong_to(:linkedin_profile) }
end
