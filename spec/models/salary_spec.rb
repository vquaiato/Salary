require 'spec_helper'

describe Salary do
  fixtures :cities, :states
  context "properties" do
	  it { should have_valid(:amount).when(1000) }
	  it { should have_valid(:amount).when(1000.99) }
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

			before do
				sal
				sal1
			end

			it "two salaries should return one salary with the avarage amount" do
				salaries = Salary.grouped_by_cities

				salaries.size.should be 1
				salaries.first[0].name.should eq "Sampa"
				salaries.first[1].should eq 100
			end

			it "two salaries in two cities should return one salary with the avarage amount to each city" do
				sal2
				sal3

				expected = {city => 100, city2 => 100}

				salaries = Salary.grouped_by_cities
				salaries.should eq expected
			end
		end
	end
end
