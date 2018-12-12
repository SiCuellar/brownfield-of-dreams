class EmailValidationController < ApplicationController
  def create
    user = User.find(params[:id])
    user.status == true
    user.save!
    redirect_to(thanks_welcome_path)

  end

  def show
    
  end
end
