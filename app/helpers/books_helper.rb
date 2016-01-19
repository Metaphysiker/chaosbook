module BooksHelper

  def maximum_reached?

    if @book.chapters.count == @book.maxnumchapt
      return true
    end
    return false
  end

  def find_book
    @book = Book.find(params[:id])
  end

  def get_user(i)
    User.find(i)
  end

end
