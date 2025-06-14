class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_user, :require_login, :logged_in?

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
  end

  private
    # 認証周りのメゾットを定義
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
      !!current_user
    end
    
    def require_login
      unless logged_in?
        flash[:alert] = "ログインまたはユーザ登録を行なってください。"
        redirect_to new_session_path
      end
    end
end
