class Book < ActiveRecord::Base
  has_many :chapters
  belongs_to :user

  acts_as_taggable

end
