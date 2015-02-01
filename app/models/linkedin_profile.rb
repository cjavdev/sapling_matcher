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

class LinkedinProfile < ActiveRecord::Base
  validates :link, uniqueness: true
  validates :client_type, inclusion: { in: ["Advisor", "PotentialClient"] }
  has_many :schools
  has_many :websites
  has_many :companies
  has_many :advisor_profile_matches, class_name: 'ProfileMatch', foreign_key: :potential_client_profile_id
  has_many :potential_client_profile_matches, class_name: 'ProfileMatch', foreign_key: :advisor_profile_id
  has_many :matched_advisors, through: :advisor_profile_matches, source: :advisor_profile
  has_many :matched_potential_clients, through: :potential_client_profile_matches, source: :potential_client_profile
  accepts_nested_attributes_for :schools
  accepts_nested_attributes_for :companies
  accepts_nested_attributes_for :websites

  def matches
    if client_type == "Advisor"
      potential_client_profile_matches
    else
      advisor_profile_matches
    end
  end

  def self.build_from_link(link, client_type)
    profile = LinkedinProfile.new(link: link, client_type: client_type)
    profile.fetch
    profile
  end

  def name
    "#{ first_name } #{ last_name }"
  end

  def fetch
    set_fields
    set_schools
    set_websites
    set_companies
    self.save!
  end

  private

  def scraped_profile
    @_scraped_profile ||= Linkedin::Profile.get_profile(link)
  end

  def set_schools
    self.schools = []
    update(schools_attributes: scraped_profile.education)
  end

  def set_companies
    self.companies = []
    cos = current_companies + past_companies
    cos = cos.map { |c| c.delete(:type); c }
    update(companies_attributes: cos)
  end

  def set_websites
    self.websites = []
    sites = scraped_profile.websites.map do |site|
      { name: site }
    end
    update(websites_attributes: sites)
  end

  def past_companies
    scraped_profile.past_companies.map do |c|
      c.merge(current: false)
    end
  end

  def current_companies
    scraped_profile.current_companies.map do |c|
      c.merge(current: true)
    end
  end

  def set_fields
    self.first_name = scraped_profile.first_name
    self.last_name = scraped_profile.last_name
    self.summary = scraped_profile.summary
    self.page = scraped_profile.page
    self.picture = scraped_profile.picture
    self.title = scraped_profile.title
    self.industry = scraped_profile.industry
    self.linkedin_url = scraped_profile.linkedin_url
    self.location = scraped_profile.location
    self.country = scraped_profile.country
  end
end
