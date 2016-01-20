class ProfilesController < ApplicationController
  before_action :find_user, only: [:show]
  before_action :authenticate_user!, only: [:edit, :create, :update, :destroy]

  def show
    @mychapters = Chapter.where(user_id: @user.id)
    @mybooks = Book.where(user_id: @user.id)
    @myprofile = Profile.find_by_user_id(@user.id)
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    if @profile.save
      flash.now[:success] = "Your profile got created!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit

  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def profile_params
    params.require(:profile).permit(:about, :interests, :cv)
  end

  def current_user_allowed?
    if current_user.id.nil?
      return false
    elsif @profile.user_id == current_user.id
      return true
    end
  end

end
