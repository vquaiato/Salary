require 'spec_helper'

describe Salary do
  fixtures :cities, :states
  context "properties" do
	  it { should have_valid(:amount).when(1000) }
	  it { should have_valid(:amount).when(1000.99) }
    it { should have_valid(:amount).when("1.000,99") }
    it { should have_valid(:amount).when("R$ 1.000,99") }
	  it { should_not have_valid(:amount).when('') }
	  it { should_not have_valid(:amount).when(nil) }
	  it { should_not have_valid(:amount).when('salary') }
	  it { should have_valid(:city).when(cities(:rio_de_janeiro)) }
	  it { should_not have_valid(:city).when(nil) }
	end

	context "salary groupment" do
		context "salaries in a city" do
			let(:state){State.create!(name:"Sampa State")}
			let(:city){City.create!(name: "Sampa", state: state)}
			let(:city2){City.create!(name: "Sampa2", state: state)}

			let(:sal){Salary.create! amount: 100, city: city}
			let(:sal1){Salary.create! amount: 100, city: city}
			let(:sal2){Salary.create! amount: 100, city: city2}
			let(:sal3){Salary.create! amount: 100, city: city2}

			it "two salaries should return one salary with the avarage amount" do
				sal
				sal1
				salaries = Salary.grouped_by_cities

				expected = {city => 100}

				salaries.should eq expected
			end

			it "four salaries should return one salary with the avarage amount" do
				Salary.create! amount: "100,35", city: city
				Salary.create! amount: "130,00", city: city
				Salary.create! amount: 475, city: city
				Salary.create! amount: "1.321,77", city: city

				salaries = Salary.grouped_by_cities

				expected = {city => 506.78}

				salaries.should eq expected
			end

			it "two salaries in two cities should return one salary with the avarage amount to each city" do
				sal
				sal1
				sal2
				sal3

				expected = {city => 100, city2 => 100}

				salaries = Salary.grouped_by_cities
				salaries.should eq expected
			end
		end
	end
end
