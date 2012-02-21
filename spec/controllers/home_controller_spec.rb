require 'spec_helper'

describe HomeController do
	context "viewing home to submit a salary" do
		it "should return the list os states" do
			State.create!(name: "Sampa")
			get :index

			assigns(:states).first.name.should eq "Sampa"
		end
	end
end