class User
  include Mongoid::Document
  include Mongo::Voter
  field :uid, :type => String
  field :name, :type => String
  field :userpic, :type => String
  field :twitter, :type => String
  field :token, :type => String
  field :secret, :type => String
  field :last_login_at, :type => DateTime
  field :last_activity_at, :type => DateTime
  field :rating, :type => Integer
  field :lines_count, :type => Integer
  has_many :verses
  has_many :activities
end
