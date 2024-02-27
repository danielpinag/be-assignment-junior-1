# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up).merge(mobile_number: registration_params[:mobile_number], name: registration_params[:name])
  end

  def registration_params
    params.require(:user).permit(:name, :mobile_number)
  end
end
