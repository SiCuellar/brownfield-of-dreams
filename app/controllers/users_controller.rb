class UsersController < ApplicationController
  def show
    @facade = DashboardFacade.new(current_user)
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def update
    token = request.env['omniauth.auth']['credentials']['token']
    uid = request.env['omniauth.auth']['uid']

    current_user.transaction do
      current_user.update!(token: token)
      current_user.update!(uid: uid)
    end
    
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
