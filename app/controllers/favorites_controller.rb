class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.build(book_id: params[:book_id])
    favorite.save
    redirect_to books_path
    # いいね作成後は、行う前にいた画面に移行せなあかん？
  end

  def destroy
    favorite = Favorite.find_by(book_id: params[:book_id], user_id: current_user.id)
    favorite.destroy
    redirect_to books_path
    # いいね削除後は、行う前にいた画面に移行せなあかん？
  end
end
