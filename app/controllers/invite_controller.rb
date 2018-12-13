class InviteController < ApplicationController
  def new
  end

  def create
    
    flash[:notice] = "Successfully sent invite!"
    redirect_to dashboard_path
  end
end
