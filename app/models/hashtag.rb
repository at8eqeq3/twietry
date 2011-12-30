class Hashtag
  include Mongoid::Document
  field :data, :type => String
  validates_presence_of :data
  has_and_belongs_to_many :verses
end
