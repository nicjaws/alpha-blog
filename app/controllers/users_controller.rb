class UsersController < ApplicationController
  
  before_action :set_user, only: [:show]
  
  def index
    @users = User.all
  end

  def new

    @user = User.new

  end

  def create

    @user = User.new(user_params)
    @user = User.first

    if @user.save

    flash[:success] = "Welcome to the alpha blog #{@user.username}"

    redirect_to articles_path

    else

    render 'new'

    end

  end
  
  def edit

    @user = User.find(params[:id])

  end

  def update

    @user = User.find(params[:id])

    if @user.update(user_params)

    flash[:success] = "Your account was updated successfully"

    redirect_to articles_path

    else

    render 'edit'

    end

  end
  
  def show 
    
  end 

private

  def set_user
    @user = User.find (params[:id])
  end

  def user_params

  params.require(:user).permit(:username, :email, :password)

  end

end

private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
