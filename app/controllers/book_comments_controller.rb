class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.build(book_comment_params)
    @book_comment.book_id = @book.id
    if @book_comment.save
      @comments = @book.book_comments.order(created_at: :desc)
      render :index
      # @book_comments = @book.book_comments.order(created_at: :desc)
      # redirect_back(fallback_location: root_path)
    else
      @newbook = Book.new
      @user = current_user
      # @book_comment = BookComment.new
      render "books/show"
    end
  end

  def destroy
    # /books/:book_id/book_comments/:id
    @book_comment = BookComment.find(params[:id])
    if @book_comment.user == current_user
       @book_comment.destroy
       render :destroy
      # redirect_back(fallback_location: root_path)
    else
       redirect_to books_path
    end
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:body)
  end

end
