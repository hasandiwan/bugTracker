class User < ApplicationRecord

  # has_many :sent_messages, class_name: "Message", foreign_key: :sender_id
  # has_many :received_messages, class_name: "Message", foreign_key: :recipient_id
  # has_many :senders, through: :received_messages, foreign_key: :sender_id
  # has_many :recipients, through: :sent_messages, foreign_key: :recipient_id

  belongs_to :role
  has_many :projects, foreign_key: :project_manager_id
end