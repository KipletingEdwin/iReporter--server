class Report < ApplicationRecord
  belongs_to :user

  validates :title, :description, presence: true
  validates :status, inclusion: { in: %w[draft submitted pending investigating resolved rejected ] }
end
