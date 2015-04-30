class User < ActiveRecord::Base
  validates :email, :presence => {:on => :create}
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true
  validates :phone, presence: true
  validates :address, presence: true
  validates :status, presence: true
  validates_uniqueness_of :email
end
