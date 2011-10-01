class ApplicationController < ActionController::Base
    protect_from_forgery
    before_filter :authorize
    private
    def current_user
      User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound
      user = User.create
      session[:user_id] = user.id
      user
    end

    protected
    def authorize
      unless User.find_by_id(session[:user_id])
        redirect_to :log_in, :notice => "Please log in"
      end
      end
end
