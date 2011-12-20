class Verse
  include Mongoid::Document
  include Mongo::Voteable
  field :title, :type => String
  field :idea, :type => String
  validates_presence_of :title, :idea
  field :is_finished, :type => Boolean, :default => false
  
  attr_protected :is_finished
  
  
  belongs_to :user
  #belongs_to :language
  embeds_many :lines do 
    def find_good
      where(:votes_point.gt => 0)
    end
  end
  
  voteable self, :up => +1, :down => -1
end

