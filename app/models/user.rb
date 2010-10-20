class User < ActiveRecord::Base
  has_many :maps
  has_many :states
  has_many :games, :through => :states
  has_one :current_game, :through => :states, :source => :game,
      :conditions => {:ended => nil}
  acts_as_authentic do |config|
    config.validate_email_field = false
    config.validate_login_field = false
    config.validate_password_field = false
  end

  def current_state
    states.find_by_game_id current_game
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
    if token = authenticated_with?(:google)
      @google ||= "" # todo
    end
  end

  def openid
    if token = authenticated_with?(:openid)
      @openid = token
    end
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
      elsif google
        {
          :id     => "unknown",
          :name   => "User",
          :photo  => "/images/icons/google.png",
          :link   => "/images/icons/google.png",
          :title  => "Google"
        }
      elsif openid
        {
          :id     => "unknown",
          :name   => openid["key"],
          :photo  => "/images/icons/google.png",
          :link   => "/images/icons/google.png",
          :title  => "OpenID"
        }
      else
        {
          :id     => "unknown",
          :name   => "User",
          :photo  => "/images/icons/google.png",
          :link   => "/images/icons/google.png",
          :title  => "Unknown"
        }
      end
    end

    @profile
  end

  def to_s
    profile[:name]
  end
end
