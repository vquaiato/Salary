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
				Salary.create!(amount: 1000, city: city)

				get :index

				expected = {city => 1000}

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
		before do
			Gotcha.skip_validation = true
		end
		let(:state){State.create!(name:"Sampa State")}
		let(:city){City.create!(name: "Sampa", state: state)}

		context "with a valid salary" do
			it "should create the salary" do
				post :create, salary:{amount: 1000, city_id: city.id}

				assigns(:salary).persisted?.should be_true
				assigns(:salary).amount.should eq 1000
				assigns(:salary).city.should eq city
			end
			it "should create the salary when receive a salary in a js mask" do
				post :create, salary:{amount: "R$ 1.000,00", city_id: city.id}

				assigns(:salary).persisted?.should be_true
				assigns(:salary).amount.should eq 1000
				assigns(:salary).city.should eq city
			end
			context "and invalid captcha" do
				before do
					Gotcha.skip_validation = false
				end
				it "should not create the salary" do
					post :create, salary:{amount: 1000, city_id: city.id}

					assigns(:salary).persisted?.should be_false
					assigns(:salary).errors[:captcha].should eq ["incorreto"]
					response.should redirect_to root_path
				end
			end
			context "with too high amount" do
				it "should not create with amount higher than 15k as string" do
					post :create, salary:{amount: "R$ 16.000,00", city_id: city.id}

					assigns(:salary).persisted?.should be_false
					response.should redirect_to root_path
				end
				it "should not create with amount higher than 15k" do
					post :create, salary:{amount: 16000, city_id: city.id}

					assigns(:salary).persisted?.should be_false
					response.should redirect_to root_path
				end
			end
		end

		context "with an invalid salary amount" do
			context "with a string amount" do
				it "should not create the salary" do
					post :create, salary:{amount: 'abc', city_id: city.id}

					assigns(:salary).persisted?.should be_false
					response.should redirect_to root_path
				end
			end
			context "with a negative amount" do
				it "should not create the salary" do
					post :create, salary:{amount: -1000, city_id: city.id}

					assigns(:salary).persisted?.should be_false
					response.should redirect_to root_path
				end
			end
			context "with amount lower than 750 amount" do
				it "should not create the salary with 700 amount" do
					post :create, salary:{amount: 700, city_id: city.id}

					assigns(:salary).persisted?.should be_false
					response.should redirect_to root_path
				end
				it "should not create the salary with 1 amount" do
					post :create, salary:{amount: 1, city_id: city.id}

					assigns(:salary).persisted?.should be_false
					response.should redirect_to root_path
				end
			end
		end
	end
end
