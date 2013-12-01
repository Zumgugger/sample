class MicropostsController < ApplicationController
  
  before_action :authenticate
  before_action :authorized_user, :only => :destroy
  
  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      redirect_to root_path, :flash => { :success => "Micropost created!"}
    else
      render 'pages/home'
    end
  end
  
  def destroy
    @micropost.destroy
    redirect_to root_path, :flash => { :success => "Micropost deleted" }
  end
  
  private
  
  def authenticate
    deny_access unless signed_in?
  end
  
  def authorized_user
    @micropost = Micropost.find(params[:id])
    redirect_to root_path unless (current_user == @micropost.user)
  end
  
end