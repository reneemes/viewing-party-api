class UserParty < ApplicationRecord
  belongs_to :party
  belongs_to :user

  validates :is_host, inclusion: { in: [true, false] }
end