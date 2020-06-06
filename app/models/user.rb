class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets


  def slug
    username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(slug)
    result = nil
    User.all.each do |user|
      if user.slug == slug
        result = user
      end
    end
    result
  end

end
