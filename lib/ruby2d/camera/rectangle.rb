# frozen_string_literal: true

module Ruby2D
  module Camera
    # Wraps existing variables as well as adding new methods
    # so that it can be handled by the Camera Module
    module Rectange < Ruby2D::Rectangle
      # Rectangles are part of the exception where
      # their x and y variables need to be reset
      # when wrapped
      #def self.extended(obj)
      #  obj.instance_exec do
      #    @x = 0
      #    @y = 0
      #  end
      #end
      # Recalculates real coordiantes
      # Use after changing variables
      def redraw
        angle = Camera.angle * (Math::PI / 180)
        half_width = Window.width * 0.5
        half_height = Window.height * 0.5
        temp_x1 = (((x + x1 - Camera.x) * Math.cos(angle)) - ((y + y1 - Camera.y) * Math.sin(angle))) * Camera.zoom + half_width
        temp_y1 = (((x + x1 - Camera.x) * Math.sin(angle)) + ((y + y1 - Camera.y) * Math.cos(angle))) * Camera.zoom + half_height
        temp_x2 = (((x + x2 - Camera.x) * Math.cos(angle)) - ((y + y2 - Camera.y) * Math.sin(angle))) * Camera.zoom + half_width
        temp_y2 = (((x + x2 - Camera.x) * Math.sin(angle)) + ((y + y2 - Camera.y) * Math.cos(angle))) * Camera.zoom + half_height
        temp_x3 = (((x + x3 - Camera.x) * Math.cos(angle)) - ((y + y3 - Camera.y) * Math.sin(angle))) * Camera.zoom + half_width
        temp_y3 = (((x + x3 - Camera.x) * Math.sin(angle)) + ((y + y3 - Camera.y) * Math.cos(angle))) * Camera.zoom + half_height
        temp_x4 = (((x + x4 - Camera.x) * Math.cos(angle)) - ((y + y4 - Camera.y) * Math.sin(angle))) * Camera.zoom + half_width
        temp_y4 = (((x + x4 - Camera.x) * Math.sin(angle)) + ((y + y4 - Camera.y) * Math.cos(angle))) * Camera.zoom + half_height
      end

      def initialize(opts= {})
        super(otps)
        Ruby2D::Camera << self
        self.remove
      end
      #Methods for moving the shape
      def x
        @x ||= 0
      end

      def x=(x)
        @x = x
      end

      def y
        @y ||= 0
      end

      def y=(y)
        @y = y
      end

    end
  end
end
