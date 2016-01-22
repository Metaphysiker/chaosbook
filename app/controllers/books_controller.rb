class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  def index

    if params[:tag].present?
      @books = Book.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 12)
      @taggy = "Show all books tagged with: " + params[:tag]
    else
      @books = Book.all.reverse_order.paginate(:page => params[:page], :per_page => 12)
      @taggy = "Show all books"
    end

  end

  def openbooks
    @books = Array.new
    if params[:tag].present?
      @booksy = Book.tagged_with(params[:tag])
      @booksy.each do |i|
        if i.frist < DateTime.now
          @books.push(i)
        end
      end
      @taggy = "Show open books tagged with: " + params[:tag]
    else
      @booksy = Book.all.reverse_order
      @booksy.each do |i|
        if i.frist < DateTime.now
          @books.push(i)
        end
      end
      @taggy = "Show all open books"
    end
  end

  def finishedbooks
    @books = Array.new
    @booksy = Book.all
    @booksy.each do |i|
      if i.maxnumchapt == i.chapters.count
        @books.push(i)
      end
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
  end

  def new
    @book = current_user.books.build
  end

  def create
    params[:book][:tag_list] = params[:book][:tag_list].join(',')
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.frist = DateTime.now - 2.years

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
    params[:book][:tag_list] = params[:book][:tag_list].join(',')
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
    params.require(:book).permit(:title, :description, :maxnumchapt, :min_length, :max_length, :tag_list)
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

end
