class Comment < ApplicationRecord
  validates :message, presence: true, length: {minimum: 2}
  
  belongs_to :user
  belongs_to :ticket
end