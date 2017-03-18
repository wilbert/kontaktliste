# Define City model methods, validations and attributes
class City < ApplicationRecord
  belongs_to :state
end
