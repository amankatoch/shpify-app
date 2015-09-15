# == Schema Information
#
# Table name: stores
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :string
#  shop_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  latitude   :float
#  longitude  :float
#

class Store < ActiveRecord::Base
  belongs_to :shop

  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  validates :name, :address, presence: true, uniqueness: true

  def self.to_csv(options = {})
    desired_column_names = ["id", "name", "address"]
    CSV.generate(options) do |csv|
      csv << desired_column_names
      all.each do |store|
        csv << store.attributes.values_at(*desired_column_names)
      end
    end
  end

  def self.accessible_attributes
    ["name", "address"]
  end
end
