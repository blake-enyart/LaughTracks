class Comedian < ActiveRecord::Base
  has_many :specials

  validates_presence_of :name, :age

  def self.average_age
    average(:age).round().to_i
  end
end
