#encoding: UTF-8
class SalariesController < ApplicationController
	respond_to :html, :js
	
	def create
		@salary = Salary.new(params[:salary])
		
		if @salary.save
			flash[:notice] = "Salário enviado."
			@salarios = Salary.all
		end

		respond_with do |format|
			format.js{ render "reload"}
			format.html{ redirect_to root_path}
		end
	end
end