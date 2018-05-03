class Author < ApplicationRecord
  def full_name
    [first_name, last_name].compact.join(' ')
  end

  def coordinates
    [rand(50), rand(90)]
  end
end
