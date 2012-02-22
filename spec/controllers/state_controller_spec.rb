require 'spec_helper'

describe StateController do
	describe "filtering cities by state" do
		context "state that has cities" do
			let(:state){State.create!(name: "Sampa")}
      		let(:city){City.create!(name:"Sampa City", state: state)}
      		let(:city2){City.create!(name:"Other City", state: state)}
			
			it "should return the cities" do
				city
				city2

				get :cities, state: state
				assigns(:cities).should eq [city, city2]
			end
		end
		context "state that has no cities" do
			let(:state){State.create!(name: "Sampa")}
			
			it "should return nothing" do
				get :cities, state: state
				assigns(:cities).should eq []
			end
		end
	end
end