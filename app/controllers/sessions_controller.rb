class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(session_new_params[:email])
    # ダイジェスト化したパスワードで判定
    if user && user.authenticate(session_new_params[:password])
      session[:user_id] = user.id
      flash.now[:alert] = "ログインに成功しました。"
      redirect_to articles_path
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが間違っています。"
      render :new
    end
  end

  def delete
  end

  private
  def session_new_params
    params.require(:session).permit(:email, :password)
  end
end
