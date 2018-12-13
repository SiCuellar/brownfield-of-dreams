class InviteController < ApplicationController
  def new
  end

  def create
    @facade = InviteFacade.new(params[:github], current_user)

    if @facade.prospect_email.nil?
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
      render :new
    else
      FriendshipMailer.friend(@facade).deliver_now

      flash[:notice] = "Successfully sent invite!"
      redirect_to dashboard_path
    end
  end
end
