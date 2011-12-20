class LinesController < ApplicationController

  def create
    verse = Verse.find(params[:verse_id])
    if verse
      #line = verse.lines.create
      #line.data = params[:data]
      #line.user = current_user
      if verse.lines.count > 0 and verse.lines.last.user == current_user
        flash[:error] = t(:'lines.create.not_allowed')
        redirect_to verse_path(verse)
      else
        begin
          verse.lines.create!(:data => params[:data], :user => current_user)
          flash[:success] = t(:'lines.create.success')
        rescue Exception => e
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



end
