class Nominee < ActiveRecord::Base
  # Fields
  field :name,:image_url, :github_id, :twitter_id
  field :description, as: :text

  # Validations
  validates_presence_of :name, :description

  # Referenced
  has_many :ballots

  class << self

    def search(account, provider=:github)
      search_github(account) if provider.to_sym == :github
    end

    def find_by_account(account)
      t = self.arel_table
      self.where(t[:github_id].eq(account).or(t[:twitter_id].eq(account))).first
    end

    private

    def search_github(account)
      info = Octokit.user(account)
      new do |user|
        user.name = info["name"]
        user.screen_name = account
        user.image_url = info["avatar_url"]

        user.github_id = account
      end
    end

  end

  def account
    github_id || twitter_id
  end

  def find_or_new(user)
    self.ballots.find_by_user_id(user) || self.ballots.new(user: user)
  end

end
