class ChaptersController < ApplicationController
  before_action :find_book, only: [:show, :new, :edit, :create, :update]
  before_action :find_chapter, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :create, :update, :destroy]

  def index

  end

  def new
    @chapter = Chapter.new
  end

  def create
    @chapter = Chapter.new(chapter_params)
    @chapter.book_id = @book.id
    @chapter.user_id = current_user.id

      if maximum_reached?
        flash.now[:danger] = "Book is already finished!"
        redirect_to book_path(@book)
      elsif (@chapter.chaptercontent.length <= @book.min_length) || (@chapter.chaptercontent.length > @book.max_length)
        flash.now[:danger] = "Total amount of characters must be between #{@book.min_length} and #{@book.max_length}"
        render 'new'
      else
        if @chapter.save
          flash.now[:success] = "Your Chapter got created!"
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
    if @chapter.update(chapter_params)
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
      @chapter.destroy
      redirect_to root_path
    end
  end

  private

  def chapter_params
    params.require(:chapter).permit(:chaptertitle, :chaptercontent, :author)
  end

  def find_book
    @book = Book.find(params[:book_id])
  end

  def find_chapter
    @chapter = Chapter.find(params[:id])
  end

  def maximum_reached?

    if @book.chapters.count == @book.maxnumchapt
      return true
    end
    return false
  end

  def current_user_allowed?
    if current_user.id.nil?
      return false
    elsif (@chapter.user_id == current_user.id) || (@book.user_id == current_user.id)
      return true
    end
  end

end
