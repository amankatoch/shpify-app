# == Schema Information
#
# Table name: maps
#
#  id         :integer          not null, primary key
#  api_key    :string
#  shop_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Map < ActiveRecord::Base
  belongs_to :shop
end
