class Group < ApplicationRecord
  # elasticsearch
  include GroupSearch::Engine

  has_many :group_addresses
end
