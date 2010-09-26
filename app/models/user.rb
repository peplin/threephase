class User < ActiveRecord::Base
  has_many :maps
  has_many :regions
  has_many :games, :through => :regions
  acts_as_authentic do |config|
    config.validate_email_field = false
    config.validate_login_field = false
    config.validate_password_field = false
  end

  def facebook
    if token = authenticated_with?(:facebook)
      @facebook ||= JSON.parse(token.get("/me"))
    end
  end
  
  def twitter
    if token = authenticated_with?(:twitter)
      @twitter ||= JSON.parse(token.get("/account/verify_credentials.json").body)
    end
  end

  def google
    @google ||= "" # todo
  end
  
  def profile
    unless @profile
      @profile = if facebook
        {
          :id     => facebook["id"],
          :name   => facebook["name"],
          :photo  => "https://graph.facebook.com/#{facebook["id"]}/picture",
          :link   => facebook["link"],
          :title  => "Facebook"
        }
      elsif twitter
        {
          :id     => twitter["id"],
          :name   => twitter["name"],
          :photo  => twitter["profile_image_url"],
          :link   => "http://twitter.com/#{twitter["screen_name"]}",
          :title  => "Twitter"
        }
      else
        {
          :id     => "unknown",
          :name   => "User",
          :photo  => "/images/icons/google.png",
          :link   => "/images/icons/google.png",
          :title  => "Google"
        }
      end
    end

    @profile
  end

  def to_s
    profile[:name]
  end
end
