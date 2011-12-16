class SessionsController < ApplicationController
  def create
    begin
    uid = auth_hash['uid']
    name = auth_hash['user_info']['name']
    userpic = auth_hash['user_info']['image']
    twitter = auth_hash['user_info']['urls']['Twitter']
    #puts "="*40
    #puts auth_hash['user_info']['urls']['Twitter']
    #puts "-"*40
    #twitter_data = Hash.new
    #twitter_data[:uid] = auth_hash['uid']
    #twitter_data[:name] = auth_hash['user_info']['name']
    #twitter_data[:userpic] = auth_hash['user_info']['image']
    #twitter_data[:twitter] = auth_hash['user_info']['twitter']
    @user = User.find_or_initialize_by(:uid => uid)
    @user.name = name
    @user.userpic = userpic
    @user.twitter = twitter
    @user.save!
    session[:user_id] = @user.uid
    #current_user = @user
    flash[:notice] = t(:'auth.success', :name => @user.name)
    redirect_to root_url
    rescue Exception => e
      render :text => e.message
    end
  end
  
  def fail
    flash[:error] = t(:'auth.error', :message => params[:message])
    redirect_to root_url
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
