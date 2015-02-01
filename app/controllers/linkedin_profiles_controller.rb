class LinkedinProfilesController < ApplicationController
  def index
    @profiles = LinkedinProfile.all
  end

  def show
    @profile = LinkedinProfile.find(params[:id])
    @matches = @profile.matches
  end

  def new
  end

  def edit
    @profile = LinkedinProfile.find(params[:id])
  end

  def update
    @profile = LinkedinProfile.find(params[:id])

    if @profile.update(profile_params)
      @profile.fetch
      redirect_to @profile
    else
      render :edit
    end
  end

  def create
    @profile = LinkedinProfile.build_from_link(
      params[:link],
      params[:client_type]
    )

    if @profile.save
      redirect_to @profile
    else
      render :new
    end
  end

  private

  def profile_params
    {}
  end
end
