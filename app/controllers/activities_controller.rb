class ActivitiesController < ApplicationController

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      if @user
        @activities = @user.activities.limit(35).order_by([[:created_at, :desc]])
      else
        redirect_to activities_path
      end
    else
      @activities = Activity.all.limit(35).order_by([[:created_at, :desc]])
    end
  end

end
