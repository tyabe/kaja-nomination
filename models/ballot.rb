class Ballot < ActiveRecord::Base
  # Fields
  field :comment, as: :text
  timestamps

  # Validations
  validates_presence_of :comment, :user_id, :nominee_id
  validates_uniqueness_of :user_id, scope: :nominee_id

  # Referenced
  belongs_to :user
  belongs_to :nominee

  # Indexes
  add_index [:user_id, :nominee_id], unique: true, name: 'by_user_nominee'

end
