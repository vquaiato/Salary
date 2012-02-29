class City < ActiveRecord::Base
  validates_presence_of :name, :state
  belongs_to :state
  has_many :salaries
  def average
    self.salaries.average(:amount) || 0.0
  end

  def self.by_state(state)
	City.find_all_by_state_id(state.id)	
  end
end
