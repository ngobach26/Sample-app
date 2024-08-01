class MicropostsController < ApplicationController
  before_action :user_signed_in?
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'Micropost created'
      redirect_to root_url
    else
      @microposts = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home', status: :unprocessable_entity
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end
end
