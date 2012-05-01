#encoding: utf-8
require 'spec_helper'

describe Admin::SalariesController do
  include Devise::TestHelpers
  context "no admin signed in" do
    it "can't see the salaries list" do
      get :index
      response.should redirect_to root_path
    end
    
    it "can't destroy any salary" do
      delete :destroy, id: 1
      response.should redirect_to root_path
    end
  end
  
  context "admin signed in" do
    let(:admin){ Admin.create email: "admin@admin.com", password: "123abc", password_confirmation: "123abc" }
    before do
      sign_in admin
    end
    
    it "can see the salaries list" do
      Salary.should_receive(:all).and_return [1, 2, 3]
      get :index
      response.should be_success
      assigns(:salaries).should == [1, 2, 3]
    end
    
    it "can remove a salary" do
      salary = double("Salary")
      salary.should_receive :delete
      Salary.should_receive(:find).with("1").and_return salary
      delete :destroy, id: "1"
      response.should redirect_to admin_salaries_path
    end
    
    it "can't remove a non existing salary" do
      pending
    end
    
  end
end
