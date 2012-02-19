class User
  include Mongoid::Document
  include Mongo::Voter
  field :uid, :type => String
  field :name, :type => String
  field :nickname, :type => String
  field :userpic, :type => String
  field :twitter, :type => String
  field :token, :type => String
  field :secret, :type => String
  field :last_login_at, :type => DateTime
  field :last_activity_at, :type => DateTime
  field :rating, :type => Integer, :default => 0
  index :rating
  field :lines_count, :type => Integer, :default => 0
  has_many :verses
  has_many :activities
  has_and_belongs_to_many :badges
  
  before_save :badge_callbacks
  
  def badge_callbacks
    # BETA USER is for users who registered while in beta
    if ENV['TWIETRY_MODE'] == "beta"
      badge = Badge.first(:conditions => {:handle => "beta_user"})
      self.badges << badge
    end
    # GRAPHOMANIAC is for those who added 50 lines
    if self.lines_count == 50
      badge = Badge.first(:conditions => {:handle => "graphomaniac"})
      self.badges << badge
    end
  end
end
