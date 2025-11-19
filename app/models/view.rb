class View < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  attribute :parameters, :json, default: {}

end
