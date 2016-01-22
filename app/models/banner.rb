class Banner < ActiveRecord::Base
  self.inheritance_column = false
  enum type: [:home, :child]
end
