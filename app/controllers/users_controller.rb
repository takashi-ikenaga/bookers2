class UsersController < ApplicationController
   before_action :authenticate_user!
   before_action :ensure_correct_user, only: [:edit,:update]

  def create
    @user = User.new(user_params)
    @user.user_id = current_user.id
    @user.save
    redirect_to user_path
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "successfully."
      redirect_to user_path(@user.id)
    else
      flash[:notice] = "error."
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction,:profile_image)
  end

  def ensure_correct_user
      @user = User.find(params[:id])
      unless @user == current_user
        redirect_to user_path(current_user.id)
      end
  end
end
