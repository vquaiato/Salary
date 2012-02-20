require 'spec_helper'

describe City do
  fixtures :states
  it { should have_valid(:name).when('Rio de Janeiro') }
  it { should_not have_valid(:name).when('') }
  it { should_not have_valid(:name).when(nil) }

  it { should have_valid(:state).when(states(:rio_de_janeiro)) }
  it { should_not have_valid(:state).when(nil) }
end
