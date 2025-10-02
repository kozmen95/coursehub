class ApplicationController < ActionController::Base
  include Pundit::Authorization

  after_action :verify_authorized, unless: :skip_pundit?
  after_action :verify_policy_scoped, if: :pundit_index_action?
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_path, alert: "Brak uprawnień do wykonania tej akcji."
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller].start_with?("rails/")
  end

  private

  def pundit_index_action?
    !skip_pundit? && action_name == "index"
  end

  # nadpisanie, żeby Devise nie odpalał verify_policy_scoped
  def verify_policy_scoped
    return if skip_pundit?
    super
  end

    protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
  end
end
