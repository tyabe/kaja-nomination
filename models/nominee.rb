class Nominee < ActiveRecord::Base
  # Fields
  field :name,:image_url, :github_id, :twitter_id
  field :description, as: :text

  # Validations
  validates_presence_of :name, :description
  validates_uniqueness_of :github_id,  scope: :archive_id, if: :github_id?
  validates_uniqueness_of :twitter_id, scope: :archive_id, if: :twitter_id?

  # Referenced
  has_many :ballots
  belongs_to :archive

  scope :active, -> { where(archive_id: nil) }

  class << self

    def search(account, provider=:github)
      self.send("search_#{provider}", account)
    end

    def find_by_account(account)
      t = self.arel_table
      account = self.where(t[:github_id].eq(account).or(t[:twitter_id].eq(account))).first
      raise ActiveRecord::RecordNotFound if account.nil?
      account
    end

    private

    def search_twitter(account)
      begin
        info = Twitter::REST::Client.new { |config|
          config.consumer_key        = (ENV['TWITTER_KEY']           || Oauth.twitter.key)
          config.consumer_secret     = (ENV['TWITTER_SECRET']        || Oauth.twitter.secret)
          config.access_token        = (ENV['TWITTER_TOKEN']         || Oauth.twitter.token)
          config.access_token_secret = (ENV['TWITTER_TOKEN_SECRET']  || Oauth.twitter.token_secret)
        }.user(account)

        new do |user|
          user.name = info.name
          user.image_url = info.profile_image_url(:original)

          user.twitter_id = account
        end
      rescue Twitter::Error::NotFound
        nil
      end
    end

    def search_github(account)
      begin
        info = Octokit.user(account)
        new do |user|
          user.name = info["name"]
          user.image_url = info["avatar_url"]

          user.github_id = account
        end
      rescue Octokit::NotFound
        nil
      end
    end

  end

  def account
    [github_id, twitter_id].reject(&:blank?).first
  end

  def find_or_new(user)
    self.ballots.find_by_user_id(user) || self.ballots.new(user: user)
  end

end
