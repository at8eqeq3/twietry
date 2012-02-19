class Verse
  include Mongoid::Document
  include Mongo::Voteable
  field :title, :type => String
  field :idea, :type => String
  validates_presence_of :title, :idea
  field :is_finished, :type => Boolean, :default => false
  
  attr_protected :is_finished
  
  after_create :track_creation
  
  before_save :badge_callbacks
  
  belongs_to :user
  has_many :activities, :as => :trackable, :dependent => :destroy
  has_and_belongs_to_many :hashtags

  #belongs_to :language
  embeds_many :lines do 
    def find_good
      where(:votes_point.gt => 0)
    end
  end
  
  def is_last? user
    self.lines.count > 0 and self.lines.last.user == user
  end
  
  def full_title
    self.title == "***" ? self.lines.count > 0 ? self.lines.first.data : "* * *" : self.title
  end
  
  voteable self, :up => +1, :down => -1
  
  protected
  def track_creation
    self.activities.create(:user => self.user, :action => "create")
  end
  
  def badge_callbacks
    # IDEA_GENERATOR is for folks who made 20 verses
    if self.user.verses.count == 19
      badge = Badge.first(:conditions => {:handle => "idea_generator"})
      self.user.badges << badge
      self.user.save
    end
  end

end

