require 'spec_helper'

describe SalariesController do
	context "creating a new salary" do
			let(:state){State.create!(name:"Sampa State")}
			let(:city){City.create!(name: "Sampa", state: state)}

		context "with a valid salary" do
			it "should create the salary" do
				post :create, salary:{amount: 1000, city_id: city.id}

				assigns(:salary).amount.should eq 1000
				assigns(:salary).city.should eq city
			end
		end

		context "with and invalid salary" do
			context "with invalid amount" do
				it "should not create the salary" do
					post :create, salary:{amount: 'abc', city_id: city.id}	

					assigns(:salary).persisted?.should be_false
					response.should redirect_to root_path
				end
			end
		end
	end
end