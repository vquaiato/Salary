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
				city = City.create!(name: "Foo", state: State.create!(name: "Bar"))
				Salary.create!(amount: 100, city: city)

				get :index

				expected = {city => 100}

				assigns(:salarios).should eq expected
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