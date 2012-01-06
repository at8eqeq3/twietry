class Line
  include Mongoid::Document
  include Mongo::Voteable
  
  validates_presence_of :data
  validates_length_of :data, :in => 10..100
  
  field :data, :type => String
  
  before_create :post_to_twitter
  before_save :find_hashtags
  
  embedded_in :verse
  belongs_to :user
  
  voteable self, :up => +1, :down => -1
  
  def post_to_twitter
    # TODO post it!
  end
  
  def find_hashtags
    self.data.gsub /#\w+/ do |match|
      #ht = Hashtag.find_or_create_by(:data => match)
      self.verse.hashtags << Hashtag.find_or_create_by(:data => match)
      #tag = self.verse.hashtags.where(:data => match).first
      #"<a href=\"/hashtags/#{tag.id}\">#{match}</a>" # fuck `url_for`
    end
    #self.verse.save!
  end
  
end
