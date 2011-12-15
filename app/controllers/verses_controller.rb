class VersesController < ApplicationController

  def new
    @verse = Verse.new
  end

end
