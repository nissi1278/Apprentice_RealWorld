class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_new_params)
    if @user.save
      redirect_to "/"
    else
      render :new
    end
  end

  private
    def user_new_params
      params.require(:user).permit(:name,:email,:password)
    end

end
