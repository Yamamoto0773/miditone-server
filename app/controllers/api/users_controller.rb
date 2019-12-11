# frozen_string_literal: true

module Api
  class UsersController < BaseController
    before_action :set_user, except: %i[index create]

    def index
      @users = paginate(User.order(created_at: :desc))
      @users = @users.includes(:preferences)

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
      rescue ActiveRecord::RecordInvalid
        return render_validation_errors @user
      end

      @user.preferences.create!(platform: :button)
      @user.preferences.create!(platform: :board)

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
      %i[preferences]
    end
  end
end
