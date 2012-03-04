require 'spec_helper'

describe SalariesController do
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
	context "creating a new salary" do
			let(:state){State.create!(name:"Sampa State")}
			let(:city){City.create!(name: "Sampa", state: state)}

		context "with a valid salary" do
			it "should create the salary" do
				post :create, salary:{amount: 1000, city_id: city.id}

				assigns(:salary).amount.should eq 1000
				assigns(:salary).city.should eq city
			end
      it "should create the salary when receive a salary in a js mask" do
				post :create, salary:{amount: "R$ 1.000,00", city_id: city.id}

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
