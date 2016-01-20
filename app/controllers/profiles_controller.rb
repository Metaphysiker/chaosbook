class ProfilesController < ApplicationController
  before_action :find_user

  def show
    @mychapters = Chapter.where(user_id: @user.id)
    @mybooks = Book.where(user_id: @user.id)
    @myprofile = Profile.find_by_user_id(@user.id)
  end

  def new
    @profile = Profile.new
  end

  def create

  end

  def edit

  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

end
