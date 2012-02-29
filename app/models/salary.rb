class Salary < ActiveRecord::Base
  validates_numericality_of :amount
  validates_presence_of :amount, :city
  belongs_to :city

  def self.grouped_by_cities
  	salaries = Salary.average(:amount, order: "1 desc", group: :city)
  end
end
