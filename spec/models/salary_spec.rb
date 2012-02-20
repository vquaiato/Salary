require 'spec_helper'

describe Salary do
  fixtures :cities, :states
  it { should have_valid(:amount).when(1000) }
  it { should have_valid(:amount).when(1000.99) }
  it { should_not have_valid(:amount).when('') }
  it { should_not have_valid(:amount).when(nil) }
  it { should_not have_valid(:amount).when('salary') }
  it { should have_valid(:city).when(cities(:rio_de_janeiro)) }
  it { should_not have_valid(:city).when(nil) }
end
