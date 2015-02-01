class ProfileMatchesController < ApplicationController
  def index
    @profile = LinkedinProfile.find(params[:linkedin_profile_id])
    send_data @profile.matches_csv
  end

  def create
    @profile = LinkedinProfile.find(params[:linkedin_profile_id])
    @matcher = Matcher.new(@profile)
    @matcher.create_matches
    redirect_to @profile
  end
end
