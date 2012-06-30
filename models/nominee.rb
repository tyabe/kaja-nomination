class Nominee < ActiveRecord::Base
  # Fields
  field :name,:image_url, :github_id, :twitter_id
  field :description, as: :text

  # Validations
  validates_presence_of :name, :description

end
