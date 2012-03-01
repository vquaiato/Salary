class HomeController < ApplicationController
	def index
		@states = State.all
		@salario = Salary.new
		@salarios = Salary.grouped_by_cities
	end
end
