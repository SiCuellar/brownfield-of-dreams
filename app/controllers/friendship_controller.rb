class FriendshipController < ApplicationController

  def create
    # TODO Add security
    current_user.add_friend(params[:friend_uid])
    redirect_to dashboard_path
  end

end
