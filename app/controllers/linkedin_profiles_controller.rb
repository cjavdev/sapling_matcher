class LinkedinProfilesController < ApplicationController
  def index
    @profiles = LinkedinProfile.all
  end

  def show
    @profile = LinkedinProfile.find(params[:id])
  end

  def new
  end

  def edit
    @profile = LinkedinProfile.find(params[:id])
  end

  def update
    @profile = LinkedinProfile.find(params[:id])

    if @profile.update(profile_params)
      redirect_to @profile
    else
      render :edit
    end
  end

  def create
    @profile = LinkedinProfile.build_from_url(params[:link])

    if @profile.save
      redirect_to @profile
    else
      render :new
    end
  end
end
