class User
  include Mongoid::Document
  field :uid, :type => String
  field :name, :type => String
  field :userpic, :type => String
  field :twitter, :type => String
  field :token, :type => String
  field :secret, :type => String
  field :last_login_at, :type => DateTime
  field :last_activity_at, :type => DateTime

  has_many :verses
end
