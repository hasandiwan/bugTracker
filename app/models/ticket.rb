class Ticket < ApplicationRecord
  validates :title, presence: true, length: { in: 6..50 }
  validates :priority, presence: true
  validates :status, presence: true
  validates :category, presence: true
  # validates :developers, presence: true
  
  # Belongs to a lead developer (user)
  belongs_to :lead_developer, class_name: "User"
  
  belongs_to :project
  has_many :ticket_assignments
  
  # Has many developers (user) through ticket assignments
  has_many :developers, through: :ticket_assignments, foreign_key: :developer_id, validate: false

  has_many :comments

  has_one :project_manager, through: :project

  def self.tickets_by_priority
    select("tickets.priority, COUNT(tickets.priority) AS tickets_count").group("tickets.priority").order("COUNT(tickets.priority) DESC")
  end

  def self.tickets_by_category
    select("tickets.category, COUNT(tickets.category) AS tickets_count").group("tickets.category").order("COUNT(tickets.category) DESC")
  end

  def self.tickets_by_status
    select("tickets.status, COUNT(tickets.status) AS tickets_count").group("tickets.status").order("COUNT(tickets.status) DESC")
  end
    
end