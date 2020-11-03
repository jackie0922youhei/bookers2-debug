class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.build(book_id: params[:book_id])
    favorite.save
    @book = Book.find(params[:book_id])
    @favoriteCounts = Favorite.where(book_id: params[:book_id])
  end

  def destroy
    favorite = Favorite.find_by(book_id: params[:book_id], user_id: current_user.id)
    favorite.destroy
    @book = Book.find(params[:book_id])
    @favoriteCounts = Favorite.where(book_id: params[:book_id])
  end
end
