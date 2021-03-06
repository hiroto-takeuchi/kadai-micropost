class MicropostsController < ApplicationController
  before_action :require_user_logged_in 
  before_action :correct_user, only: [:show, :update, :edit, :destroy]
 
  def index
    @microposts = Micropost.all.page(params[:id])
  end 
  
  def show
  end
  
  def new
    @micropost = Micropost.new
  end 
  
  def edit
  end 
  
  def update
    if @micropost.update(micropost_params)
      flash[:success] ='メッセージを更新しました'
      redirect_to @micropost
      
    else
      flash.now[:danger] = 'メッセージは更新されませんでした'
      render :edit
    end
  end 
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    
    if @micropost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @microposts = current_user.feed_microposts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @micropost.destroy
    flash[:danger] = 'メッセージを削除しました。'
    redirect_to root_url
  end
  
  private
  
  def set_micropost
    @micropost = Micropost.find(params[:id])
  end
  
  def micropost_params
    params.require(:micropost).permit(:content, :title)
  end 
  
  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost 
    redirect_to root_url
    end 
  end 
end
