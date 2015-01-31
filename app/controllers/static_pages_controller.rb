class StaticPagesController < ApplicationController
  def root
    @advisors = Advisor.all
  end
end
