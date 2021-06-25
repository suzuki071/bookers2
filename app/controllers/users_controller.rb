class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit]

  def index
    @users = User.all
    @booknew = Book.new
  end

  def show
    @user = User.find(params[:id])
    @booknew = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
    else
      @book = Book.new
      @books = Book.all
      @booknew = Book.new
      redirect_to user_path(current_user.id)
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render 'edit'
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image_id)
    end

end
