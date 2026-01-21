class Entry < ApplicationRecord
  has_one_attached :image

  validates :date, presence: true
  validates :body, presence: true
  validates :image, presence: true, on: :create
  validates :status, inclusion: { in: %w[published draft hidden] }

  scope :chronological, -> { order(date: :desc) }
  scope :published, -> { where(status: "published") }
  scope :draft, -> { where(status: "draft") }
  scope :hidden, -> { where(status: "hidden") }

  def published?
    status == "published"
  end

  def draft?
    status == "draft"
  end

  def hidden?
    status == "hidden"
  end

  def status_badge_color
    case status
    when "published" then "bg-green-100 text-green-800"
    when "draft" then "bg-yellow-100 text-yellow-800"
    when "hidden" then "bg-red-100 text-red-800"
    end
  end
end
