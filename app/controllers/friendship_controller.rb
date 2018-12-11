class FriendshipController < ApplicationController

  def create
    # TODO Add security
    if current_user.add_friend(params[:friend_uid])
      redirect_to dashboard_path
    else
      flash[:error] = 'Not a Valid User'
      redirect_to dashboard_path
    end
  end

end
