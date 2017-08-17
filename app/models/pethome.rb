class Pethome < ApplicationRecord
  belongs_to :user
  has_many :pets
  has_many :bookings
  has_many :pethome_reviews, through: :bookings

  def self.search(search)
    where("address LIKE ?", "%#{search}%")
  end

end
