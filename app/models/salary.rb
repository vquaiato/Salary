class Salary < ActiveRecord::Base
  validates_numericality_of :amount, greater_than_or_equal_to: 750, less_than_or_equal_to: 15000
  validates_presence_of :amount, :city
  belongs_to :city

  def self.grouped_by_cities
  	salaries = Salary.average(:amount, order: "1 desc", group: :city)
  end

  def amount= amount
    if amount.is_a? String
      amount = BigDecimal.new(amount.to_money.to_s)
      amount = nil if amount == 0
    end
    write_attribute :amount, amount
  end
end
