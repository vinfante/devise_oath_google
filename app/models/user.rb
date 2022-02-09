class User < ApplicationRecord
  attr_accessor :skip_password_validation  # virtual attribute to skip password validation while saving

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2] 

  protected

  def password_required?
    return false if skip_password_validation
    super
  end
end
