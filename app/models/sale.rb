class Sale < ActiveRecord::Base
  belongs_to :product
  before_save :populate_guid
  validates :guid, uniqueness: true

  private

  def populate_guid
    if new_record?
      while !valid? || self.guid.nil?
        self.guid = SecureRandom.random_number(1_000_000_000).to_s(36)
      end
    end
  end

end
