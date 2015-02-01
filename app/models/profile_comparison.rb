class ProfileComparison
  attr_reader :profile1, :profile2

  def initialize(profile1, profile2)
    @profile1 = profile1
    @profile2 = profile2
  end

  def common_school?
    (profile1.schools.pluck(:name) & profile2.schools.pluck(:name)).any?
  end

  def common_location?
    profile1.location == profile2.location
  end

  def common_company?
    (profile1.companies.pluck(:company) & profile2.companies.pluck(:company)).any?
  end
end
