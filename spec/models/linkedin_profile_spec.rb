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

require 'rails_helper'

vcr_options = { cassette_name: 'linkedin-profiles', record: :new_episodes }

RSpec.describe LinkedinProfile, :type => :model do
  it { should validate_uniqueness_of(:link) }
  it { should validate_inclusion_of(:client_type).in_array(%w(Advisor PotentialClient)) }
  it { should have_many(:schools) }
  it { should have_many(:companies) }
  it { should have_many(:websites) }
  it { should accept_nested_attributes_for(:schools) }
  it { should accept_nested_attributes_for(:companies) }
  it { should accept_nested_attributes_for(:websites) }

  describe '::build_from_link' do
    it 'builds a profile from a link' do
      VCR.use_cassette("cj-profile") do
        profile = LinkedinProfile.build_from_link("https://www.linkedin.com/pub/cj-avilla/19/772/577", "Advisor")
        expect(profile.first_name).to eq("CJ")
      end
    end
  end

  describe '#fetch' do
    it 'updates the profile from linkedin data' do
      VCR.use_cassette("cj-profile") do
        profile = create(:linkedin_profile)
        expect {
          profile.fetch
        }.to change {
          profile.updated_at
        }
      end
    end

    [ :first_name,
      :last_name,
      :summary,
      :page,
      :picture,
      :title,
      :industry,
      :linkedin_url,
      :location,
      :country].each do |column|
      it "Sets the #{ column } when fetching" do
        VCR.use_cassette("cj-profile") do
          profile = create(:linkedin_profile)
          expect {
            profile.fetch
          }.to change {
            profile.send(column)
          }
        end
      end
    end

    it 'Sets the associated schools' do
      VCR.use_cassette("cj-profile") do
        profile = create(:linkedin_profile)
        expect {
          profile.fetch
        }.to change(School, :count).by(1)
        expect(profile.schools.first.name).to eq("University of Nevada")
        expect(profile.schools.first.description).to eq("Bachelor of Science, Computer Science")
        expect(profile.schools.first.period).to eq("2007 – 2012")
      end
    end

    it 'Sets the associated companies' do
      VCR.use_cassette("cj-profile") do
        profile = create(:linkedin_profile)
        expect {
          profile.fetch
        }.to change(Company, :count).by(7)
      end
    end

    it 'Sets the associated websites' do
      VCR.use_cassette("cj-profile") do
        profile = create(:linkedin_profile)
        expect {
          profile.fetch
        }.to change(Website, :count).by(1)
      end
    end
  end
end
