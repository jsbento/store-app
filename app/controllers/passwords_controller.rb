class PasswordsController < ApplicationController
  before_action :redirect_if_authenticated

  def create
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user.present?
      if @user.confirmed?
        @user.send_password_reset_email!
        redirect_to root_path, notice: "If the user exists, we've sent password reset instructions."
      else
        redirect_to new_confirmation_path, alert: "Please confirm your email address first."
      end
    else
      redirect_to new_password_path, alert: "If the user exists, we've sent password reset instructions."
    end
  end

  def edit
    @user = User.find_signed(params[:password_reset_token], purpose: :password_reset)
    if @user.present? && user.unconfirmed?
      redirect_to new_confirmation_path, alert: "Please confirm your email address before resetting your password."
    elsif @user.nil?
      redirect_to new_password_path, alert: "Invalid password reset token."
    end
  end

  def new
  end

  def update
    @user = User.find_signed(params[:password_reset_token], purpose: :password_reset)
    if @user
      if @user.unconfirmed?
        redirect_to new_confirmation_path, alert: "Please confirm your email address before resetting your password."
      elsif @user.update(password_params)
        redirect_to login_path, notice: "Sign in."
      else
        flash.now[:alert] = "Invalid or expired password reset token."
        render :edit, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "Invalid password reset token."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
