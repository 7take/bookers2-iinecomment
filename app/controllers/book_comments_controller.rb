class BookCommentsController < ApplicationController
before_action :authenticate_user!

def create
	@book = Book.find(params[:book_id])
	@book_comment = current_user.book_comments.new(book_comment_params)
	@user = current_user

	if @book_comment.save
		redirect_to [@book]
	else
		render 'books/show'
	end
end

	def destroy
		book = Book.find(params[:book_id])
		book_comment = current_user.book_comments.find_by(id: params[:id], book_id: book.id )
		book_comment.destroy
		redirect_to [:book, { id: params[:book_id] }]
	end


private
	def book_comment_params
	params.require(:book_comment).permit(:body).merge(book_id: params[:book_id])
	end
end
