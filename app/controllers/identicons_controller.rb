include Magick
class IdenticonsController < ApplicationController
  def show
    bg_color_red    = params[:id][4..5].to_i(16)
    bg_color_green  = params[:id][6..7].to_i(16)
    bg_color_blue   = params[:id][8..9].to_i(16)
    bg_color_alpha  = params[:id][10..11].to_i(16)
    bg_color        = "#" + params[:id][4..11]
    fg_color        = "#" + params[:id][12..19]
    fg_color_red    = params[:id][12..13].to_i(16)
    fg_color_green  = params[:id][14..15].to_i(16)
    fg_color_blue   = params[:id][16..17].to_i(16)
    fg_color_alpha  = params[:id][18..19].to_i(16)
    seed_horizontal = params[:id][20..21].to_i(16).to_s(2)
    seed_vertical   = params[:id][22..23].to_i(16).to_s(2)
    scale_factor    = params[:size].to_i / 8
    
    rvg = RVG.new(params[:size].to_i, params[:size].to_i) do |canvas|
      0.upto 7 do |h|
        0.upto 7 do |v|
          dir = (seed_horizontal[h] == seed_vertical[v]) ? 1 : 0
          oddity = ((h.even? and v.odd?) or (h.odd? and v.even?)) ? 1 : 0
          type = dir.to_i + 2 * oddity.to_i
          if seed_vertical[v] == "1"
            type += 2
            type -= 4 if type > 3
          end
          canvas.g.scale(scale_factor / 2) do |identicon|
            identicon.g.translate(h * 2, v * 2) do |item|
              case type
                when 0 then
                  item.polygon(0,0,1,0,0,1).styles(:fill => bg_color, :stroke => "none")
                  item.polygon(0,2,2,0,2,1,1,2).styles(:fill => bg_color, :stroke => "none")
                  item.polygon(0,1,1,0,2,0,0,2).styles(:fill => fg_color, :stroke => "none")
                  item.polygon(1,2,2,1,2,2).styles(:fill => fg_color, :stroke => "none")
                when 1 then
                  item.polygon(0,2,0,1,1,2).styles(:fill => fg_color, :stroke => "none")
                  item.polygon(0,0,1,0,2,1,2,2).styles(:fill => fg_color, :stroke => "none")
                  item.polygon(0,1,0,0,2,2,1,2).styles(:fill => bg_color, :stroke => "none")
                  item.polygon(1,0,2,0,2,1).styles(:fill => bg_color, :stroke => "none")
                when 2 then
                  item.polygon(0,0,1,0,0,1).styles(:fill => fg_color, :stroke => "none")
                  item.polygon(0,2,2,0,2,1,1,2).styles(:fill => fg_color, :stroke => "none")
                  item.polygon(0,1,1,0,2,0,0,2).styles(:fill => bg_color, :stroke => "none")
                  item.polygon(1,2,2,1,2,2).styles(:fill => bg_color, :stroke => "none")
                when 3 then
                  item.polygon(0,2,0,1,1,2).styles(:fill => bg_color, :stroke => "none")
                  item.polygon(0,0,1,0,2,1,2,2).styles(:fill => bg_color, :stroke => "none")
                  item.polygon(0,1,0,0,2,2,1,2).styles(:fill => fg_color, :stroke => "none")
                  item.polygon(1,0,2,0,2,1).styles(:fill => fg_color, :stroke => "none")
              end
            end
          end
        end
      end
    end
    i = rvg.draw
    i.format = "PNG"
    send_data i.to_blob(), :filename => "#{params[:id]}.png", :disposition => "attachment"
    
  end
end
