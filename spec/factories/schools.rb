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

FactoryGirl.define do
  factory :school do
    name "UNR"
  end
end
