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
end
