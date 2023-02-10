class UsersController < ApplicationController
  before_action :set_user

  def update
    if @user.update(params.require(:user).permit(permitted_attributes))
      render json: @user
    else
     render json: @user.errors
    end
  end

  private

  def permitted_attributes
    [:full_name] | @user.custom_fields.map { |f| f.multiple_select? ? {f.name => []} : f.name }
  end

  def set_user
    @user = User.find(params[:id])
  end
end
