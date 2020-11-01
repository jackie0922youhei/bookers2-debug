class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    if
      comment.save
      redirect_back(fallback_location: root_path)
    else
      @newbook = Book.new
      @user = current_user
      @book_comment = BookComment.new
      render formats: "book/show.html.erb"
    end
  end

  def destroy
    @bookcomment = BookComment.find(params[:book_id])
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
