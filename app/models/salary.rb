class Salary < ActiveRecord::Base
  validates_numericality_of :amount
  validates_presence_of :amount, :city
  belongs_to :city
end
