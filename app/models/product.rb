class Product < ActiveRecord::Base
  belongs_to :user

  has_attached_file :file
  validates_attachment_content_type :file, content_type: [
    "image/jpg",
    "image/jpeg",
    "image/png",
    "image/gif",
    "application/pdf",
    "application/zip"
  ]

  has_many :sales
  validates :price, numericality: { greater_than: 0.49,
                                   message: "must be at least 50 cents" }
end
