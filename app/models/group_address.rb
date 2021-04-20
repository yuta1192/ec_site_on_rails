class GroupAddress < ApplicationRecord
  # GroupがGroupAddressを持っている。
  # GroupAddressは複数のAddressを持っている。
  # group_idを所有している
  # address_idを所有している

  belongs_to :address
  belongs_to :group
end
