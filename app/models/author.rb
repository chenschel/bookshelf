class Author < ApplicationRecord
  def full_name
    [first_name, last_name].compact.join(' ')
  end

  def coordinates
    [rand(50), rand(90)]
  end

  def publication_years
    (1..rand(10)).to_a.map { rand(1900..2000) }.sort
  end
end
