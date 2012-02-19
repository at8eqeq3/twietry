module ApplicationHelper
  def identicon_tag id, size = 64
    image_tag identicon_path(size, id), :class => "identicon"
  end
end
