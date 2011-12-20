class VersesController < ApplicationController

  def index
  	@all_verses = Verse.all
  end
  
  def show
    @verse = Verse.find(params[:id])
  end

  def new
    @verse = Verse.new
  end
  
  def create
    @verse = Verse.new params[:verse]
    @verse.user = current_user
    if @verse.save
      flash[:success] = t(:'verses.create.success')
      redirect_to verse_path(@verse)
    else
      flash[:error] = t(:'verses.create.failure')
      render :action => 'new'
    end
  end

end
