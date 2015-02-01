class Matcher
  attr_reader :profile

  def initialize(profile)
    @profile = profile
  end

  def create_matches
    if profile.client_type == "Advisor"
      create_matches_as_advisor
    else
      create_matches_as_client
    end
  end

  def matches
    matches = []
    all_other_type.each do |other_profile|
      match_count = 0
      comp = ProfileComparison.new(profile, other_profile)
      match_count += 1 if comp.common_school?
      match_count += 1 if comp.common_location?
      match_count += 1 if comp.common_company?
      matches << other_profile if match_count >= 1
    end
    matches
  end

  def all_other_type
    @all_other_type ||=
      LinkedinProfile.where.not(client_type: profile.client_type)
  end

  private

  def create_matches_as_advisor
    matches.each do |match|
      unless ProfileMatch.exists?(advisor_profile: profile, potential_client_profile: match)
        comp = ProfileComparison.new(profile, match)
        ProfileMatch.create(
          advisor_profile: profile,
          potential_client_profile: match,
          school: comp.common_school?,
          location: comp.common_location?,
          company: comp.common_company?
        )
      end
    end
  end

  def create_matches_as_client
    matches.each do |match|
      unless ProfileMatch.exists?(advisor_profile: match, potential_client_profile: profile)
        comp = ProfileComparison.new(profile, match)
        ProfileMatch.create(
          advisor_profile: match,
          potential_client_profile: profile,
          school: comp.common_school?,
          location: comp.common_location?,
          company: comp.common_company?
        )
      end
    end
  end
end
