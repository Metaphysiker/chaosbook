class BooksController < ApplicationController
  before_action :find_book, only: [:show]

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.min_length >= @book.max_length
      flash.now[:danger] = "Min_length has to be shorter than max_length"
      render 'new'
    else
      if @book.save
        redirect_to book_path(@book)
      else
        render 'new'
      end
    end
  end


  private

  def book_params
    params.require(:book).permit(:title, :description, :maxnumchapt, :min_length, :max_length)
  end

  def find_book
    @book = Book.find(params[:id])
  end

end
