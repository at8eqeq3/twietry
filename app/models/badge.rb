class Badge
  include Mongoid::Document
  field :handle, :type => String # need this 'cause :name is localized and :_id is so unpredictable
  field :name, :type => String, :localize => true
  field :description, :type => String, :localize => true
  index :handle, :unique => true
  has_and_belongs_to_many :users
end
