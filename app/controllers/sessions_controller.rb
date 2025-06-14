class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(session_new_params)
    if @user
      session[:user_id] = @user.id
      redirect_to articles_path
    else
      render :new , status: :unauthorized
    end
  end

  def delete
  end

  private
  def session_new_params
    params.require(:session).permit(:email, :password)
  end
end
