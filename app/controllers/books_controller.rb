class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]

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

  def edit

  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    redirect_to root_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :description, :maxnumchapt, :min_length, :max_length)
  end

  def find_book
    @book = Book.find(params[:id])
  end

end
