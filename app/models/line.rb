class Line
  include Mongoid::Document
  include Mongo::Voteable
  
  validates_presence_of :data
  validates_length_of :data, :in => 10..100
  
  field :data, :type => String
  
  before_create :post_to_twitter
  before_save :find_hashtags
  
  after_create :track_creation
  
  embedded_in :verse
  belongs_to :user
  
  voteable self, :up => +1, :down => -1
  
  
  protected
  def post_to_twitter
    # TODO post it!
  end
  
  def find_hashtags
    self.data.gsub /#\w+/ do |match|
      self.verse.hashtags << Hashtag.find_or_create_by(:data => match)
    end
  end
  
  def track_creation
    self.verse.activities.create(:user => self.user, :action => "add_line")
  end
  
end
