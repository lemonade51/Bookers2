class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit]
  def show
    @users = User.all
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.includes(:books)
    @book = Book.new
    @user = current_user
  end

  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
       redirect_to books_path
    end

     @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "you have updated user successfully."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
end