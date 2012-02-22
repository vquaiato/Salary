require 'spec_helper'

describe State do
  it { should have_valid(:name).when('Rio de Janeiro') }
  it { should_not have_valid(:name).when('') }
  it { should_not have_valid(:name).when(nil) }

  describe "filtering cities" do
    context "state that has cities" do
      let(:state){State.create!(name: "Sampa")}
      let(:city){City.create!(name:"Sampa City", state: state)}
      let(:city2){City.create!(name:"Other City", state: state)}
      
      it "should return that cities" do
        state
        city
        city2
        
        cities = state.cities
        cities.should == [city,city2]
      end
    end
    context "state that has no cities" do
      let(:state){State.create!(name: "Sampa")}
      
      it "should not return cities" do
        state
        
        cities = state.cities
        cities.should be_empty
      end
    end
  end
end
