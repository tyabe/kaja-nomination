class User < ActiveRecord::Base
  # Fields
  field :name, :screen_name, :image_url, :uid, :provider

  # Validations
  validates_presence_of :name, :screen_name

  def self.create_with_omniauth(auth)
    create! do |user|
      user.uid = auth["uid"]
      user.provider = auth["provider"]

      user.name = auth["info"]["name"]
      user.screen_name = auth["info"]["nickname"]
      user.image_url = auth["info"]["image"]
    end
  end

end
