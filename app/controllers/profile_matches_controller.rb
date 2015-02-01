class ProfileMatchesController < ApplicationController
  def create
    @profile = LinkedinProfile.find(params[:linkedin_profile_id])
    @matcher = Matcher.new(@profile)
    @matcher.create_matches
    redirect_to @profile
  end
end
