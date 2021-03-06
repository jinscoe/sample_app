class UsersController < ApplicationController
  
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => [:destroy]
  
  def index
    @users = User.paginate :page => params[:page]
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate :page  => params[:page]
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the sample app"
      redirect_to user_path(@user)
       
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."        
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    
    user = User.find(params[:id]).destroy
    flash[:success] = "User, #{user.name},  Destroyed"
    redirect_to users_path
    
  end
  
  private
  
        
    def correct_user
      
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
      
    end
    
    def admin_user
      user = User.find(params[:id])
      redirect_to(root_path) unless (current_user.admin? && !current_user?(user))
      
    end
    
  
end
