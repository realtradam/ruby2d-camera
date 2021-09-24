# frozen_string_literal: true

# require_relative "camera/version"
# require_relative "camera/triangle"
require 'ruby2d'
Dir[File.join(__dir__, 'camera', '*.rb')].sort.each { |file| require file }

# Handles rendering objects relative
# to a camera location
module Ruby2D
  module Camera
    class << self
      private

      # Contains all objects that are tracked
      def objects
        @objects ||= []
      end

    end

    def self._sort_by_z
      @sort_by_z = true
    end

    def self._resolve_z_sorting
      objects.sort_by!(&:z) if @sort_by_z
      @sort_by_z = false
    end

    def self.debug_x
      @debug_x ||= 0
    end

    def self.debug_x=(debug_x)
      @debug_x = debug_x
    end

    def self.debug_y
      @debug_y ||= 0
    end

    def self.debug_y=(debug_y)
      @debug_y = debug_y
    end

    # Adding objects so they are
    # tracked by the Camera
    def self.<<(item)
      unless objects.include?(item)
        objects.push(item)
        self._sort_by_z
      end
    end

    def self.remove(item)
      objects.delete(item) if objects.include?(item)
    end

    # Redraw all objects that
    # are tracked by the Camera
    def self._redraw(auto_purge: false)
      self._resolve_z_sorting
      objects.each(&:_draw)
    end

    # Variables changing Camera properties
    def self._x(x)
      @x += x
    end

    def self._y(y)
      @y += y
    end

    def self.x
      @x ||= 0
    end

    def self.x=(x)
      @x = x
    end

    def self.y
      @y ||= 0
    end

    def self.y=(y)
      @y = y
    end

    def self.zoom
      @zoom ||= 1.0
    end

    def self.zoom=(zoom)
      @zoom = zoom
    end

    def self.angle
      @angle ||= 0
    end

    def self.angle=(angle)
      angle %= 360
      @angle = angle
    end

    # Convert screenspace coordinates into worldspace camera ones
    def self.coordinate_to_worldspace(x, y)
      angle = Camera.angle * (Math::PI / 180)
      half_width = Window.width * 0.5
      half_height = Window.height * 0.5

      [(((x - half_width) / zoom) * Math.cos(-angle)) - (((y - half_height) / zoom) * Math.sin(-angle)) + self.x,
       (((x - half_width) / zoom) * Math.sin(-angle)) + (((y - half_height) / zoom) * Math.cos(-angle)) + self.y]
    end

    # Convert worldspace camera coordinates into screenspace ones
    def self.coordinate_to_screenspace(x, y)
      angle = Camera.angle * (Math::PI / 180)
      [(((x - Camera.x) * Math.cos(angle)) - ((y - Camera.y) * Math.sin(angle))) * Camera.zoom + (Window.width * 0.5),
       (((x - Camera.x) * Math.sin(angle)) + ((y - Camera.y) * Math.cos(angle))) * Camera.zoom + (Window.height * 0.5)]
    end
  end
end

module Ruby2D
  class Window
    def update(&aproc)
      @update_proc = (aproc << proc { Ruby2D::Camera._redraw })
      true
    end
  end
end
