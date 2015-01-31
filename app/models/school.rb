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

class School < ActiveRecord::Base
  belongs_to :linkedin_profile
end
