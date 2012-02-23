require 'spec_helper'

describe HomeController do
	context "viewing home to submit a salary" do
		it "should return the list os states" do
			State.create!(name: "Sampa")
			get :index

			assigns(:states).first.name.should eq "Sampa"
		end
		context "when has previous salaries" do
			it "should return the list of salaries" do
				Salary.create!(amount: 100, city: City.create!(name: "Foo", state: State.create!(name: "Bar")))

				get :index

				assigns(:salarios).first.amount.should eq 100
			end
		end
		context "when has no previous salaries" do
			it "should return empty list of salaries" do
				get :index

				assigns(:salarios).should be_empty
			end
		end
		it "should uses a new salary" do
			get :index
			assigns(:salario).should be_new_record
		end
	end
end