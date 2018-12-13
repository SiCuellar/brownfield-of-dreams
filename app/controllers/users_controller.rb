class UsersController < ApplicationController
  def show
    @facade = DashboardFacade.new(current_user)
  end

  def new
    @user = User.new
  end

  def create
    if params[:user][:password] != params[:user][:password_confirmation]
      flash[:error] = "Passwords do not match"
      redirect_to register_path
    else
      user = User.create(user_params)
      if user.save
        session[:user_id] = user.id
        flash[:alert] = "Logged in as #{user.first_name} #{user.last_name}"
        flash[:notice] = "This account has not yet been activated. Please check your email."

        ConfirmationMailer.valid(current_user).deliver_now

        redirect_to dashboard_path
      else
        flash[:error] = 'Username already exists'
        render :new
      end
    end
  end

  def update
    token = request.env['omniauth.auth']['credentials']['token']
    uid = request.env['omniauth.auth']['uid']
    gusername = request.env['omniauth.auth']['extra']['raw_info']['login']

    current_user.transaction do
      current_user.update!(token: token)
      current_user.update!(uid: uid)
      current_user.update!(gusername: gusername)
    end

    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
