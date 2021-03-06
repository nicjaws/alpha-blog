class UsersController < ApplicationController
  
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update] 
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
   # @user = User.first
    if @user.save
      flash[:success] = "Bienvenido a Aduanas #{@user.username}"
      redirect_to articles_path
    else
      render 'new'
    end
  end
  
  def edit
    
  end


  def update
    if @user.update(user_params)
    flash[:success] = "Tu cuenta fue actualizada con exito"
    redirect_to articles_path
    else
    render 'edit'
    end
  end
  
  
  def show 
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end 
  

private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end


  def set_user
    @user = User.find (params[:id])
  end
  
  def require_same_user
    if current_user != @user
      flash[:danger] = "Solo puedes editar tu propia cuenta" 
      redirect_to root_path
    end
  end

 
end
