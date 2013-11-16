class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def new
    @title = "Sign up"
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    User.create(user_params)
  end




private
    def set_user
      @actor = Actor.find(params[:id])
    end #set_actor
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :encrypted_password)
    end
    
end