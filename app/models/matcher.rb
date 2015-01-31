class Matcher
  attr_reader :profile

  def initialize(profile)
    @profile = profile
  end

  def match
    all_other_type
  end

  def all_other_type
    @all_other_type ||=
      LinkedinProfile.where.not(client_type: profile.client_type)
  end
end
