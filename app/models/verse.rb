class Verse
  include Mongoid::Document
  include Mongo::Voteable
  field :title, :type => String
  field :idea, :type => String
  validates_presence_of :title, :idea
  field :is_finished, :type => Boolean, :default => false
  
  attr_protected :is_finished
  
  after_create :track_creation
  after_update :refine_update_action
  
  
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
  
  voteable self, :up => +1, :down => -1
  
  protected
  def track_creation
    self.activities.create(:user => self.user, :action => "create")
  end
  
  def refine_update_action
    logger.warn "in after_update callback"
    if self.is_finished
      logger.warn "-in finalization"
      self.activities.create(:action => "finalize")
    else
      logger.warn "-in line addition"
      self.activities.create(:user => self.user, :action => "add_line")
    end
  end
end

