class RelationshipsController < ApplicationController
  before_action :set_user, only: [:create]
  before_action :set_relationship, only: [:destroy]

  def create
    if current_user.follow(@user)
      flash[:success] = "You are now following #{@user.name}."
    else
      flash[:alert] = 'Unable to follow user.'
    end
    redirect_to @user
  end

  def destroy
    if current_user.unfollow(@user)
      flash[:success] = "You have unfollowed #{@user.name}."
    else
      flash[:alert] = 'Unable to unfollow user.'
    end
    redirect_to @user, status: :see_other
  end

  private

  def set_user
    @user = User.find(params[:followed_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'User not found.'
    redirect_to root_path
  end

  def set_relationship
    @relationship = Relationship.find(params[:id])
    @user = @relationship.followed
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Relationship not found.'
    redirect_to root_path
  end
end
