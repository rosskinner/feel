# == Schema Information
#
# Table name: moods
#
#  id          :integer          not null, primary key
#  mood        :string(255)
#  count       :integer
#  location_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Mood < ActiveRecord::Base
  belongs_to :location
end
