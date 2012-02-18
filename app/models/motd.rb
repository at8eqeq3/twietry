# there'll be no UI to create such documents. Use console, Luke
class Motd
  include Mongoid::Document
  field :data, :type => String
  field :is_active, :type => String
  field :level, :type => String # should match Bootstrap's classes
  # maybe some time later we'll add some automation
  field :schedule_start, :type => DateTime
  field :schedule_end, :type => DateTime
end
