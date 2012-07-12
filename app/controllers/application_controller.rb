class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  #helper_method :user_signed_in?
  #helper_method :correct_user?
  def default_url_options(options={})
  logger.debug "default_url_options is passed options: #{options.inspect}\n"
  { :locale => I18n.locale }
  end
  before_filter :set_locale
  def set_locale
  I18n.locale = params[:locale] || I18n.default_locale
  end
  private
    def current_user
      begin
        @current_user ||= User.where(:uid => session[:user_id]).first if session[:user_id]
      rescue Mongoid::Errors::DocumentNotFound
        nil
      end
    end
  
  #  def user_signed_in?
  #    return true if current_user
  #  end

  #  def correct_user?
  #    @user = User.find(params[:id])
  #    unless current_user == @user
  #      redirect_to root_url, :alert => "Access denied."
  #    end
  #  end

    def authenticate_user!
      if !current_user
        flash[:error] = t(:'auth.need_auth')
        redirect_to root_url
      end
    end

end
