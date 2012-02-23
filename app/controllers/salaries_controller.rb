#encoding: UTF-8
class SalariesController < ApplicationController
	respond_to :html, :js, :json
	
	def create
		@salary = Salary.new(params[:salary])
		
		if @salary.save
			flash[:notice] = "Salário enviado."
		end

		respond_with do |format|
			format.js{ render "reload"}
		end
	end
end