class UsersController < ApplicationController
  before_action :user_signed_in?
  before_action :admin_user, only: :destroy
  def show
    @user = User.find_by(id: params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 10)
    if @user.nil?
      redirect_to users_path, alert: "User not found"
    end
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_path, status: :see_other
  end

  def following
    @title = 'Following'
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow', status: :unprocessable_entity
 end

 def followers
    @title = 'Followers'
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow', status: :unprocessable_entity
 end

  private

  def admin_user
    redirect_to(root_path, status: :see_other) unless current_user.admin?
  end
end
