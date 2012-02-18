class UsersController < ApplicationController
  def index
    @users = User.order_by([[:rating, :desc]]).page(params[:page])
  end
  def show
    @user = User.find(params[:id])
  end
end
