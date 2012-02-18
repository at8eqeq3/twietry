class OembedController < ApplicationController
  
  # TONS of copypastes
  def endpoint
    # get object that we want an oembed_response from
    # based on url
    # and get its oembed_response
    #media_item = OembedProvider.find_provided_from(params[:url])
    @verse = Verse.find(params[:url].match(/verses\/([0-9a-f]{24})/)[1])
    if @verse
      @users = []
      @verse.lines.each do |line|
        @users << line.user.name
      end
      @users.uniq!
      response = Hash.new
      response[:type]          = "rich"
      response[:version]       = "1.0"
      response[:title]         = "#{@verse.title} @ Twietry"
      response[:provider_name] = "Twietry"
      response[:provider_url]  = "http://#{request.host}"
      response[:width]         = params[:maxwidth] || "300"
      response[:height]        = params[:maxheight] || "400"
      response[:html]          = render_to_string 'verses/simple.html.haml', :layout => false
      
      respond_to do |format|
        format.html { render :json => response } # return json for default
        format.json { render :json => response }
        format.xml  { render :xml  => response.to_xml(:root => "oembed") }
      end
    else
      
    end
  end

end
