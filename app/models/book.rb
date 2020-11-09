class Book < ApplicationRecord
	belongs_to :user

	has_many :favorites, dependent: :destroy

	has_many :book_comments, dependent: :destroy
	
	has_many :notifications, dependent: :destroy

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def self.search(search, word)
		if search == "perfect_match"
			@book = Book.where(title: "#{word}")
		elsif search == "forward_match"
			@book = Book.where("title LIKE?","#{word}%")
		elsif search == "backward_match"
			@book = Book.where("title LIKE?","%#{word}")
		elsif search == "partial_match"
			@book = Book.where("title LIKE?","%#{word}%")
		else
			@book = Book.all
		end
	end
	
	def create_notification_by(current_user)
		notification = current_user.active_notifications.new(
			book_id: id,
			visited_id: user_id,
			action: "favorite"
		)
		notification.save if notification.valid?
	end
	
	def create_notification_comment!(current_user, book_comment_id)
		temp_ids = BookComment.select(:user_id).where(book_id: id).where.not(user_id: current_user.id).distinct
		temp_ids.each do |temp_id|
			save_notification_comment!(current_user, book_comment_id, temp_id['user_id'])
		end
		save_notification_comment!(current_user, book_comment_id, user_id) if temp_ids.blank?
	end
	
	def save_notification_comment!(current_user, book_comment_id, visited_id)
		notification = current_user.active_notifications.new(
			book_id: id,
			book_comment_id: book_comment_id,
			visited_id: visited_id,
			action: 'book_comment'
		)
		if notification.visiter_id == notification.visited_id
			notification.checked = true
		end
		notification.save if notification.valid?
	end

end
