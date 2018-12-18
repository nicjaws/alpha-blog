class SessionsController < ApplicationController
  
  def new
  
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Has ingresado exitosamente"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Algo fue mal con tu informacion de acceso"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "Te has salido de la sesion"
    redirect_to root_path
  end
  
end

