class User < ActiveRecord::Base
  has_many :spots
  # validates :phone_number, :length => {:is => 10}, on: :update
  # validates :phone_number, :numericality => {:only_integer => true}, on: :update

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.first_name = auth.info.first_name
      user.email = auth.info.email
      user.image = auth.info.image
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

end
