class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError do
    redirect_to(request.referer || root_path, alert: "Brak uprawnień.")
  end
end
