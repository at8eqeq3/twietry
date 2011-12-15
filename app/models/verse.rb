class Verse
  include Mongoid::Document
  include Mongo::Voteable
  field :title, :type => String
  field :idea, :type => String
  field :is_finished, :type => Boolean
  
  
  belongs_to :user
  #belongs_to :language
  #has_many :lines
  
  voteable self, :up => +1, :down => -1
end
