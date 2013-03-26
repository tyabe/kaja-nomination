class Archive < ActiveRecord::Base
  # Fields
  field :name
  field :note, as: :text

  # Validations
  validates_presence_of :name
  validates_format_of   :name, with: /[a-z0-9-_]/

  # Referenced
  has_many :nominees

end
