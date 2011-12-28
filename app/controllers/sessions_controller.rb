class SessionsController < ApplicationController
  def create
    begin
      uid = auth_hash['uid']
      name = auth_hash['info']['name']
      userpic = auth_hash['info']['image']
      twitter = auth_hash['info']['urls']['Twitter']
      @user = User.find_or_initialize_by(:uid => uid)
      @user.name = name
      @user.userpic = userpic
      @user.twitter = twitter
      @user.last_login_at = Time.now
      @user.last_activity_at = Time.now
      @user.token = auth_hash['credentials']['token']
      @user.secret = auth_hash['credentials']['secret']
      @user.save!
      session[:user_id] = @user.uid
    #current_user = @user
      flash[:success] = t(:'auth.success', :name => @user.name)
      redirect_to request.env['omniauth.origin'] || root_url
    rescue Exception => e
      render :text => e.backtrace
    end
  end
  
  def fail
    flash[:error] = t(:'auth.error', :message => params[:message])
    redirect_to root_url
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = t(:'auth.logged_out')
    redirect_to root_url
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
