require 'spec_helper'

describe State do
  it { should have_valid(:name).when('Rio de Janeiro') }
  it { should_not have_valid(:name).when('') }
  it { should_not have_valid(:name).when(nil) }
end
