# frozen_string_literal: true

module Api
  class UsersController < BaseController
    protect_from_forgery

    before_action :set_user, except: %i[index create]

    def index
      @users = User.all
      render json: ::Api::UserSerializer.new(@users)
    end

    def show
      render json: ::Api::UserSerializer.new(@user)
    end

    def create
      begin
        @user = User.new(user_params.merge(qrcode: random_number_str(12)))
        @user.save!
      rescue ActiveRecord::RecordNotUnique
        retry
      rescue 
        render_errors @user
      end

      render json: ::Api::UserSerializer.new(@user), status: :created
    end

    def update
      if @user.update(user_params)
        render json: ::Api::UserSerializer.new(@user)
      else
        render_errors @user
      end
    end

    def destroy
      if @user.destroy
        head :no_content
      else
        render_errors @user
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name)
    end
  end
end
