require 'spec_helper'

describe City do
  fixtures :states, :cities
  describe "properties" do
    it { should have_valid(:name).when('Rio de Janeiro') }
    it { should_not have_valid(:name).when('') }
    it { should_not have_valid(:name).when(nil) }
    it { should have_valid(:state).when(states(:rio_de_janeiro)) }
    it { should_not have_valid(:state).when(nil) }
  end
  describe "average" do
    let(:rio_de_janeiro) { cities(:rio_de_janeiro) }
    it "should return the average of salaries" do
      Salary.create!(:amount => 5000.00, :city => rio_de_janeiro)
      Salary.create!(:amount => 1000.00, :city => rio_de_janeiro)
      rio_de_janeiro.average.should == 3000.00
    end
    it "should return the zero when there are no salaries" do
      rio_de_janeiro.average.should == 0.0
    end
  end
  describe "filtering cities" do
    context "state that has cities" do
      let(:state){State.create!(name: "Sampa")}
      let(:city){City.create!(name:"Sampa City", state: state)}
      let(:city2){City.create!(name:"Other City", state: state)}
      
      it "should return that cities" do
        state
        city
        city2
        
        cities = City.by_state(state)
        cities.should == [city,city2]
      end
    end
    context "state that has no cities" do
      let(:state){State.create!(name: "Sampa")}
      
      it "should not return cities" do
        state
        
        cities = City.by_state(state)
        cities.should be_empty
      end
    end
  end
end