class VersesController < ApplicationController

  def index
    @verses = Verse.order_by([[:uid, :desc]]).page(params[:page])
  end
  
  def show
    @verse = Verse.find(params[:id])
    @inspiration = Inspiration.all[rand(Inspiration.count)] # so sad :(
    unless @verse
      flash[:error] = t(:'verses.show.notfound')
      redirect_to verses_url
    end
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
  
  def love
    @verse = Verse.find(params[:id])
    if @verse
      current_user.inc(:rating, 1)
      current_user.vote(@verse, :up)
      respond_to do |f|
        f.html {redirect_to(verse_path(@verse))}
        f.js {render :action => "vote"}
      end
    else
      respond_to do |f|
        f.html {redirect_to(verses_path)}
        f.js {render :nothing}
      end
    end
  end
  
  def hate
    @verse = Verse.find(params[:id])
    if @verse
      current_user.vote(@verse, :down)
      current_user.inc(:rating, -1)
      respond_to do |f|
        f.html {redirect_to(verse_path(@verse))}
        f.js {render :action => "vote"}
      end
    else
      respond_to do |f|
        f.html {redirect_to(verses_path)}
        f.js {render :nothing}
      end
    end
  end
end
