# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  place      :string(255)
#  radius     :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Location < ActiveRecord::Base
  belongs_to :user
end
