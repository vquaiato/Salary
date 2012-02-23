class HomeController < ApplicationController
	def index
		@states = State.all
		@salario = Salary.new
		@salarios = Salary.all
	end
end
