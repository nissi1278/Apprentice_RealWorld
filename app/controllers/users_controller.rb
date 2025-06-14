class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_new_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザ登録に成功しました。"
      redirect_to articles_path
    else
      flash.now[:alert] = "ユーザ登録に失敗しました。"
      render :new
    end
  end

  private
    def user_new_params
      params.require(:user).permit( :name, :email, :password )
    end
end
