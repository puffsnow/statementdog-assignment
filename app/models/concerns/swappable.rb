module Swappable
  extend ActiveSupport::Concern

  included do
    after_create :initialize_position

    def initialize_position
      self.update(position: self.id)
    end

    def move(direction: 'up')
      order_direction = direction == 'up' ? :desc : :asc

      objects = swappable_parent.send("#{self.class.to_s.underscore}s").order(position: order_direction)
      index = objects.find_index(self)

      return if index + 1 >= objects.length

      next_object = objects[index + 1]
      self_original_position = self.position

      self.update(position: next_object.position)
      next_object.update(position: self_original_position)
    end

    def swappable_parent
      raise NotImplementedError, "must implement swappable_parent"
    end
  end
end
