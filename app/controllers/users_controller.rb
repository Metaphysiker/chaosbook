class UsersController < ApplicationController

  def show
    @user = User.find_by_username(params[:username])
    @mychapters = Chapter.where(user_id: @user.id)
    @mybooks = Book.where(user_id: @user.id)
  end

  private

  def find_book_to_chapter(i)
    Book.find(i)
  end

end
