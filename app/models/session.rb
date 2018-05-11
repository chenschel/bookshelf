class Session < ApplicationRecord
  belongs_to :user

  before_create do
    self.key = SecureRandom.hex(50)
  end

  serialize :content
end
