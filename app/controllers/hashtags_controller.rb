class HashtagsController < ApplicationController

  def index
    @hashtags = Hashtag.all
    @coef = 1
  end
  
  def show
    @hashtag = Hashtag.find params[:id]
    
  end

end
