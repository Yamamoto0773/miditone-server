# frozen_string_literal: true

module Api
  class UsersController < BaseController
    protect_from_forgery

    before_action :set_user, except: %i[index create]

    def index
      @users = User.all
      render json: UserSerializer.new(@users)
    end

    def show
      render json: UserSerializer.new(@user, include: include_list)
    end

    def create
      begin
        @user = User.new(user_params.merge(qrcode: random_number_str(12)))
        @user.save!
      rescue ActiveRecord::RecordNotUnique
        retry
      rescue StandardError
        return render_validation_errors @user
      end

      render json: UserSerializer.new(@user), status: :created
    end

    def update
      if @user.update(user_params)
        render json: UserSerializer.new(@user)
      else
        render_validation_errors @user
      end
    end

    def destroy
      if @user.destroy
        head :no_content
      else
        render_validation_errors @user
      end
    end

    private

    def set_user
      @user = User.find_by!(qrcode: params[:qrcode])
    end

    def user_params
      params.require(:user).permit(:name)
    end

    def include_list
      %i[preference]
    end
  end
end
