# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :user_signed_in?
  before_action :admin_user, only: :destroy
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 8)
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_path, status: :see_other
  end

  private

  def admin_user
    redirect_to(root_path, status: :see_other) unless current_user.admin?
  end
end
