class Recipe < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

  def for_api
    {
      id: id,
      name: name
    }
  end
end
