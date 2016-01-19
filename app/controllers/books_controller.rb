class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
  end

  def new
    @book = current_user.books.build
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.min_length >= @book.max_length
      flash.now[:danger] = "Min_length has to be shorter than max_length"
      render 'new'
    else
      if @book.save
        flash.now[:success] = "Your Book got created!"
        redirect_to book_path(@book)
      else
        render 'new'
      end
    end
  end

  def edit
    if !current_user_allowed?
      flash[:danger] = "You're not allowed"
      redirect_to root_path
    end
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end

  def destroy
    if !current_user_allowed?
      flash[:danger] = "You're not allowed"
      redirect_to root_path
    else
      @book.destroy
      redirect_to root_path
    end
  end


  private

  def book_params
    params.require(:book).permit(:title, :description, :maxnumchapt, :min_length, :max_length)
  end

  def find_book
    @book = Book.find(params[:id])
  end

  def current_user_allowed?
    if current_user.id.nil?
      return false
    elsif @book.user_id == current_user.id
      return true
    end
  end

  def get_user

  end

end
