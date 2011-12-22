class VersesController < ApplicationController

  def index
  	@all_verses = Verse.all
  end
  
  def show
    @verse = Verse.find(params[:id])
  end
  
  def simple
    @verse = Verse.find(params[:id])
    if @verse.is_finished
      @users = []
      @verse.lines.each do |line|
        @users << line.user.name
      end
      @users.uniq!
      render :layout => false
    else
      redirect_to :action => :show, :id => params[:id]
    end
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
