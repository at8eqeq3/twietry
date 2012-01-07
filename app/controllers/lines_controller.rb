class LinesController < ApplicationController

  before_filter :authenticate_user!, :only => [:create, :love, :hate]

  def create
    verse = Verse.find(params[:verse_id])
    if verse
      #line = verse.lines.create
      #line.data = params[:data]
      #line.user = current_user
      if verse.is_last? current_user
        flash[:error] = t(:'lines.create.not_allowed')
        redirect_to verse_path(verse)
      else
        begin
          verse.lines.create(:data => params[:data], :user => current_user)
          current_user.inc(:lines_count, 1)
          begin
            Twitter.configure do |c|
              c.oauth_token = current_user.token
              c.oauth_token_secret = current_user.secret
              c.consumer_key = ENV['TWIETRY_TWITTER_KEY']
              c.consumer_secret = ENV['TWIETRY_TWITTER_SECRET']
            end
            Twitter.update t(:'lines.create.twitter', :line => params[:data], :url => verse_url(verse))
          rescue Exception => e
            logger.warn e.message
            flash[:error] = t(:'verses.create.twitter_failure')
          end
          #verse.save!
          flash[:success] = t(:'lines.create.success')
        rescue Exception => e
          logger.warn e.message
          flash.delete :success
          flash[:error] = t(:'lines.create.failure')
        end
        redirect_to verse_path(verse)
      end
    else
      flash[:error] = t(:'verses.show.notfound')
      redirect_to verses_path
    end
  end

  def love
    @verse = Verse.find(params[:verse_id])
    if @verse
      @line = @verse.lines.find(params[:id])
      if @line
        @line.user.inc(:rating, 2)
        current_user.vote(@line, :up)
        respond_to do |f|
          f.html {redirect_to(verse_path(@verse))}
          f.js {render :action => "vote"}
        end
      else
        respond_to do |f|
          f.html {redirect_to(verse_path(@verse))}
          f.js {render :nothing}
        end
      end
    else
      respond_to do |f|
        f.html {redirect_to(verses_path)}
        f.js {render :nothing}
      end
    end
  end
  
  def hate
    @verse = Verse.find(params[:verse_id])
    if @verse
      @line = @verse.lines.find(params[:id])
      if @line
        @line.user.inc(:rating, -2)
        current_user.vote(@line, :down)
        respond_to do |f|
          f.html {redirect_to(verse_path(@verse))}
          f.js {render :action => "vote"}
        end
      else
        respond_to do |f|
          f.html {redirect_to(verse_path(@verse))}
          f.js {render :nothing}
        end
      end
    else
      respond_to do |f|
        f.html {redirect_to(verses_path)}
        f.js {render :nothing}
      end
    end
  end


end
