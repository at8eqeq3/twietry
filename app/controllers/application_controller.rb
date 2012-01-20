class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :get_motds
  #helper_method :user_signed_in?
  #helper_method :correct_user?

  # finds all active and scheduled MOTDs
  def get_motds
    @motds = Motd.where(:is_active => true) # TODO complex query for scheduled items
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
