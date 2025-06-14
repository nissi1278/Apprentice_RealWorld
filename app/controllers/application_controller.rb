class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_user
  private
    # 認証周りのメゾットを定義
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
    def login?
      !!@current_user
    end
end
