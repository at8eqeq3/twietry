class HomeController < ApplicationController
  def index
    @activities = Activity.all.order_by([[:created_at, :desc]]).limit(10)
    @verses_count = Verse.count
    @users = User.order_by([[:rating, :desc]]).limit(15)
    @users_count = User.count
    @lines_count = 0
    # soooo saaaad...
    Verse.all.each do |verse|
      @lines_count += verse.lines.count
    end
  end

  def about
  end

  def support
  end

end
