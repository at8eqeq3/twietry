class HomeController < ApplicationController
  def index
    @closed_verses = Verse.where(:is_finished => true)
    @open_verses = Verse.where(:is_finished => false)
    @activities = Activity.all.order_by([[:created_at, :desc]]).limit(10)
  end

  def about
  end

  def support
  end

end
