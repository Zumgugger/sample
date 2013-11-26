require 'spec_helper'

describe "Users" do
  describe "signup" do
    
    describe "failiure" do 
      it "should not make a new user" do 
        lambda do 
          visit signup_path
          fill_in "Name",         :with =>  ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirmation", :with => "" 
          click_button
          response.should render_template('users/new')
          response.should have_selector('div#error_explanation')
        end.should_not change(User, :count) #end lambda
      end #it
    end #describe
      
    describe "success" do 
        
      it "should make a new user" do 
        lambda do 
          visit signup_path
          fill_in "Name",         :with =>  "Test"
          fill_in "Email",        :with => "testemail1@example.com"
          fill_in "Password",     :with => "somepass"
          fill_in "Confirmation", :with => "somepass" 
          click_button
          response.should have_selector("div.flash.success", :content => "Welcome")
          response.should render_template('users/show')
        end.should change(User, :count).by(1) #end lambda
      end #it
    end #describe
  end #signup
  
  describe "signin" do 
    describe "failure" do 
      it "should not sign user in" do 
        visit signin_path
        fill_in :email, :with => ""
        fill_in :password, :with => ""
        click_button
        response.should have_selector('div.flash.error', :content =>  "Invalid")
        response.should render_template('sessions/new')
      end #it
    end #describe
    
    describe "success" do
      it "should sign in and out a user" do
        user = Factory(:user)
        visit signin_path
        fill_in :email, :with => user.email
        fill_in :password, :with => user.password
        click_button
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end #do
    end #describe
  end #describe signin
end
