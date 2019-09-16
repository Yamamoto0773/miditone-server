# frozen_string_literal: true

module Api
  class PreferencesController < BaseController
    before_action :set_user

    def show
      render json: PreferenceSerializer.new(@user.preference)
    end

    def update
      if @user.preference.update(preference_params)
        render json: PreferenceSerializer.new(@user.preference)
      else
        render_validation_errors @user.preference
      end
    end

    private

    def set_user
      @user = User.find_by!(qrcode: params[:user_qrcode])
    end

    def preference_params
      params.require(:preference).permit(:note_speed, :se_volume)
    end
  end
end
