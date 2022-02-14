class User < ApplicationRecord
  attr_accessor :skip_password_validation  # virtual attribute to skip password validation while saving

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         # :omniauthable, omniauth_providers: [:google_oauth2]
         :omniauthable, omniauth_providers: [:oktaoauth]

  protected

  def self.from_omniauth(auth)
    puts auth
    

    user = User.first_or_initialize(email: auth["info"]["email"]) do |user|
    # user = User.find_or_create_by(email: auth['info']['email']) do |user|
      user.skip_password_validation = true
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.email = auth['info']['email']
      user.save!
    end
  end

  def password_required?
    return false if skip_password_validation
    super
  end
end
