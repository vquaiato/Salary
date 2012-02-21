require 'spec_helper'

describe HomeController do
	context "viewing home to submit a salary" do
		it "should return the list os states" do
			State.create!(name: "Sampa")
			get :index

			assigns(:states).first.name.should eq "Sampa"
		end
		it "should uses a new salary" do
			get :index
			assigns(:salario).should be_new_record
		end
	end
end