class UsersController < ApplicationController
  before_action :authenticate, :except => [:show, :new, :create ]
  before_action :correct_user, :only => [:edit, :update]
  before_action :admin_user,   :only => :destroy
  
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
    @microposts = @user.microposts.paginate(:page => params[:page])
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'   
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end

  def new
    @title = "Sign up"
    @user  = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in(@user)
      @title = @user.name
      redirect_to @user, :flash => { :success => "Welcome to the Sample App!" }
      
    else
           
      @title = "Sign up"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit user"
  end
  
  def update
    if @user.update_attributes(params[:user])
      redirect_to @user , :flash => { :success => "Profile has been updated."}
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    @user.destroy
    redirect_to users_path, :flash => {:success => "User destroyed"}
  end
  
  private 
  
  def authenticate
    deny_access unless signed_in?
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless @user == current_user
  end
  
  def admin_user
    @user = User.find(params[:id])
    redirect_to(root_path) if !current_user.admin? || (current_user == @user)
  end
   
end
