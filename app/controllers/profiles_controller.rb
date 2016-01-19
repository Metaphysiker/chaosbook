class ProfilesController < ApplicationController
  before_action :find_user

  def show
    @user = User.find(params[:user_id])
    @mychapters = Chapter.where(user_id: @user.id)
    @mybooks = Book.where(user_id: @user.id)
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

end
