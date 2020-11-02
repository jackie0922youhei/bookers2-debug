class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    if @book_comment.save
      redirect_back(fallback_location: root_path)
    else
      @newbook = Book.new
      @user = current_user
      # @book_comment = BookComment.new
      render "books/show"
    end
  end

  def destroy
    # /books/:book_id/book_comments/:id

    @bookcomment = BookComment.find(params[:id])
    if @bookcomment.user == current_user
       @bookcomment.destroy
       redirect_back(fallback_location: root_path)
    else
       redirect_to books_path
    end
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:body)
  end

end
