class Activity
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :action
  
  belongs_to :user
  belongs_to :trackable, :polymorphic => true
end
