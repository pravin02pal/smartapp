class Room < ActiveRecord::Base
  validates :rnumber, presence: true
  validates :rent, presence: true
  validates :rtype, presence: true
end
