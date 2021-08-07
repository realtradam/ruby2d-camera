# frozen_string_literal: true

require_relative "camera/version"
require_relative "camera/triangle"

#Dir[File.join(__dir__, 'camera', '*.rb')].sort.each { |file| require file }

# Handles rendering objects relative
# to a camera location
module Ruby2D
  module Camera
    class <<self

      private
      # Contains all objects that are tracked
      def objects
        @objects ||= []
      end
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
=begin
      case item
      when Triangle
        item.extend Camera::TriangleWrapped
      when Square
        item.extend Camera::SquareWrapped
      when Rectangle
        item.extend Camera::RectangleWrapped
      when Quad
        item.extend Camera::QuadWrapped
      when Line
        item.extend Camera::LineWrapped
      when Circle
        item.extend Camera::CircleWrapped
      when Image
        item.extend Camera::ImageWrapped
      when Sprite
        item.extend Camera::SpriteWrapped
      when Text
        item.extend Camera::TextWrapped
      else
        puts 'Warning: Non-standard Object added to Camera'
        puts '  Object may not behave as expected'
      end
=end
      objects.push(item) unless objects.include?(item)
    end

    def self.remove(item)
      objects.delete(item) if objects.include?(item)
    end

    # Redraw all objects that
    # are tracked by the Camera
    def self.redraw(auto_purge: false)
      #if auto_purge
      #  objects.each do |item|
      #    if item.nil?
      #      puts "Warning: Nil Object detected in Camera"
      #      puts "  Nil Object removed"
      #      objects.delete(obj)
      #    else
      #      item.redraw
      #    end
      #  end
      #else
        objects.each(&:_draw)
      #end
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
  end
end
