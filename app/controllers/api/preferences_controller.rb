# frozen_string_literal: true

module Api
  class PreferencesController < BaseController
    before_action :set_user
    before_action :set_preference

    def show
      render json: PreferenceSerializer.new(@preference)
    end

    def update
      if @preference.update(preference_params)
        render json: PreferenceSerializer.new(@preference)
      else
        render_validation_errors @preference
      end
    end

    private

    def set_user
      @user = User.find_by!(qrcode: params[:user_qrcode])
    end

    def set_preference
      @preference = @user.preferences.find_by!(platform: platform)
    end

    def preference_params
      params.require(:preference).permit(:note_speed, :se_volume)
    end
  end
end
