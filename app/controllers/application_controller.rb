#
# This ApplicationController class maintains the state by storing logged in user id in a session object and this is shared by all the controllers.
#
#
class ApplicationController < ActionController::Base
    protect_from_forgery
    before_filter :authorize
    private
    
    # This method retrieves current logged in user details.
    def current_user
      @curr_user=User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound
      user = User.create
      session[:user_id] = user.id
      @curr_user = user
      user
    end



    protected
    # Validation check before performing validations.
    def authorize
      unless User.find_by_id(session[:user_id])
        redirect_to :log_in, :notice => "Please log in"
      end
      end
end
