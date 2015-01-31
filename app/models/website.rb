# == Schema Information
#
# Table name: websites
#
#  id                  :integer          not null, primary key
#  name                :string
#  linkedin_profile_id :integer
#

class Website < ActiveRecord::Base
  belongs_to :linkedin_profile
end
