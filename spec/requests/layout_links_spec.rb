require 'spec_helper'

describe "LayoutLinks" do
  it "should have a Homepage at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end
  
  it "should have a Contact Page at '/contact'" do 
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end
  
    it "should have an about Page at '/about'" do 
    get '/about'
    response.should have_selector('title', :content => "About")
  end
  
    it "should have a Help Page at '/help'" do 
    get '/help'
    response.should have_selector('title', :content => "Help")
  end
end
