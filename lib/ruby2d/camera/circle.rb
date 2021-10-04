# frozen_string_literal: true

module Ruby2D
  module Camera
    # Wraps existing variables as well as adding new methods
    # so that it can be handled by the Camera Module
    class Circle < Ruby2D::Circle
      # Recalculates real coordiantes
      # Use after changing variables
      def _draw
        return if @hide

        angle = Camera.angle * (Math::PI / 180)
        self_angle = self.angle * (Math::PI / 180)
        half_width = Window.width * 0.5
        half_height = Window.height * 0.5
        temp_radius = @radius * Camera.zoom
        # rotate the shape
        temp1_x = (x_offset * Math.cos(self_angle)) - (y_offset * Math.sin(self_angle)) + x
        temp1_y = (y_offset * Math.cos(self_angle)) + (x_offset * Math.sin(self_angle)) + y
        # apply the camera modifications
        temp2_x = (((temp1_x - Ruby2D::Camera.x - radius) * Math.cos(angle)) - ((temp1_y - Ruby2D::Camera.y - radius) * Math.sin(angle))) * Ruby2D::Camera.zoom + half_width
        temp2_y = (((temp1_x - Ruby2D::Camera.x - radius) * Math.sin(angle)) + ((temp1_y - Ruby2D::Camera.y - radius) * Math.cos(angle))) * Ruby2D::Camera.zoom + half_height
        Ruby2D::Circle.draw(x: temp2_x, y: temp2_y,
                            radius: temp_radius,
                            sectors: sectors,
                            color: [color.r, color.g, color.b, color.a])
      end

      def initialize(opts = {})
        super(opts)
        unless opts[:x_offset].nil?
          self.x_offset = opts[:x_offset]
        end
        unless opts[:y_offset].nil?
          self.y_offset = opts[:y_offset]
        end
        Ruby2D::Camera << self
        Window.remove(self)
      end

      def angle
        @angle ||= 0
      end

      def angle=(angle)
        @angle = (angle % 360)
      end

      attr_writer :x_offset, :y_offset

      def x_offset
        @x_offset ||= 0
      end

      def y_offset
        @y_offset ||= 0
      end

      def remove
        @hide = true
      end

      def add
        @hide = false
      end
    end
  end
end
