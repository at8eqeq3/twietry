class HomeController < ApplicationController
  def index
    @closed_verses = Verse.where(:is_finished => true)
    @open_verses = Verse.where(:is_finished => false)
  end

  def about
  end

  def support
  end

end
