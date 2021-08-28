class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [ :edit, :update, :destroy]

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books= Book.all
      @user = current_user
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
		@books = Book.all
		@book_comment = BookComment.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def edit
   @book = Book.find(params[:id])
   if @book.user == current_user
      render "edit"
   else
      redirect_to books_path
   end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] ='successfully updated book!'
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] ='successfully delete book!'
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    if current_user != @user
      redirect_to books_path
    end
  end
end
