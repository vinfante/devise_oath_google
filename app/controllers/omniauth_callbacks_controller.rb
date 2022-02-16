# class OmniauthCallbacksController < ApplicationController
class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # replace with your authenticate method
  # skip_before_action :authenticate_user!, :raise => false

  def google_oauth2
    auth = request.env["omniauth.auth"]
    puts auth
    # user = User.where(provider: auth["provider"], uid: auth["uid"])
    #         .first_or_initialize(email: auth["info"]["email"])

    user = User.where(uid: auth["uid"])
            .first_or_initialize(email: auth["info"]["email"])
    user.first_name ||= auth["info"]["first_name"]
    user.last_name ||= auth["info"]["last_name"]
    user.image ||= auth["info"]["image"]
    user.uid ||= auth["uid"]
    user.skip_password_validation = true
    user.save!

    # session_db = Session.where(user: user).first_or_initialize(token: auth['extra']['id_token'])
    session_db = Session.where(user: user).first
    p session_db
    if session_db.nil?
      p '-----------------------session empty'
      session_db = Session.new
    end
    session_db.token = auth['extra']['id_token']
    session_db.user = user
    session_db.save

    # user.remember_me = true
    sign_in(:user, user)

    session[:user_name] = "#{user.first_name} #{user.last_name}"
    session[:user_email] = user.email
    session[:user_image] = user.image


    redirect_to after_sign_in_path_for(user)
  end

  # def failure

  # end
end
