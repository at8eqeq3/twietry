class Line
  include Mongoid::Document
  include Mongo::Voteable
  
  validates_presence_of :data
  validates_length_of :data, :minimum => 10
  
  field :data, :type => String
  
  embedded_in :verse
  belongs_to :user
  
end
