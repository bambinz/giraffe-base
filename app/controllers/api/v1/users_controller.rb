module Api
  module V1
    class UsersController < ApplicationController
      
      respond_to :json
      before_filter :restrict_access, except: [:get_access_token]

      def get_access_token
        user_session = UserSession.new
        user_session.username = params[:username]
        user_session.password = params[:password]
        if user_session.valid?
          user = User.find_by_username(params[:username])
          if !user.api_key
            user.generate_api_key
            user.save
          end
          render json: user
        else
          render json: user_session.errors, status: 401
        end
      end
      
      def show
        render json: current_user
      end
      
    end
  end
end