class UsersController < ApplicationController
  allow_unauthenticated_access

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "User registered successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotUnique
    flash.now[:alert] = "Email already exists. Please use a different email."
    render :new, status: :unprocessable_entity
  end



  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
