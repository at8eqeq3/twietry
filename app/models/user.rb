class User
  include Mongoid::Document
  field :uid, :type => String
  field :name, :type => String
  field :userpic, :type => String
  attr_protected :uid, :name, :userpic
  has_many :verses
end
