class StaticPagesController < ApplicationController
  def home
    return unless current_user
    @user = current_user
    @microposts = @user.microposts.includes(:image_attachment).paginate(page: params[:page], per_page: 10)
    @micropost = @user.microposts.build
  end

  def help; end
end
