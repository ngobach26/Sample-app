class UsersController < ApplicationController
  before_action :user_signed_in?
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all;
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path, status: :see_other
  end

end
