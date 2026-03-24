# frozen_string_literal: true

# Lets the signed-in user edit their own account (name, email).
class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]
  before_action :ensure_current_user, only: %i[edit update]
  def edit; end

  def update
    if @user.update(user_params)
      redirect_to edit_user_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: %i[name email_address])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_current_user
    return if @user.id == Current.user.id

    redirect_to root_path
  end
end
