class RelationshipsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    user = @user.find(params[:follow_id])
    current_user.follow(user)
    flash[:success] = 'ユーザーをフォローしました。'
    redirect_to user
  end

  def destroy
    user = @user.find(params[:follow_id])
    current_user.unfollow(user)
    flash.now[:success] = 'ユーザのフォローを解除しました。'
    redirect_to user
  end
end
