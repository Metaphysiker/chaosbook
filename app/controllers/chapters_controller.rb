class ChaptersController < ApplicationController
  before_action :find_book

  def index

  end

  def new
    @chapter = Chapter.new
  end

  def create
    @chapter = Chapter.new(chapter_params)
    @chapter.book_id = @book.id
      if maximum_reached?
        flash.now[:danger] = "Book is already finished!"
        redirect_to book_path(@book)
      elsif (@chapter.chaptercontent.length <= @book.min_length) || (@chapter.chaptercontent.length > @book.max_length)
        flash.now[:danger] = "Total amount of characters must be between #{@book.min_length} and #{@book.max_length}"
        render 'new'
      else
        if @chapter.save
          flash[:success] = "Your Book got created!"
          redirect_to book_path(@book)
        else
          render 'new'
        end
      end
  end

  private

  def chapter_params
    params.require(:chapter).permit(:chaptertitle, :chaptercontent, :author)
  end

  def find_book
    @book = Book.find(params[:book_id])
  end

  def maximum_reached?

    if @book.chapters.count == @book.maxnumchapt
      return true
    end
    return false
  end

end
