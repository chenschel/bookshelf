class User < ApplicationRecord
  has_secure_password

  has_many :sessions

  def role
    :superadmin if is_superadmin?
  end
end
