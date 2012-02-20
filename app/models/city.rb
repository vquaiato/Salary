class City < ActiveRecord::Base
  validates_presence_of :name, :state
  belongs_to :state
end
