#encoding: UTF-8
class SalariesController < ApplicationController
	respond_to :html, :js
	
	def create
		@salary = Salary.new(params[:salary])
		
		if not gotcha_valid?
			@salary.errors.add "captcha", "incorreto"
		else		
			@salarios = Salary.grouped_by_cities if @salary.save
		end

		respond_with do |format|
			format.js{ render "reload"}
			format.html{ redirect_to root_path}
		end
	end
end