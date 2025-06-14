class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_new_params[:email])
    # ダイジェスト化したパスワードで判定
    if user && user.authenticate(session_new_params[:password])
      session[:user_id] = user.id
      flash[:notice] = "ログインが成功しました。"
      redirect_to articles_path
    else
      flash.now[:alert] = "ログインが失敗しました。"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました。"
    redirect_to articles_path
  end

  private
  def session_new_params
    params.require(:session).permit(:email, :password)
  end
end
