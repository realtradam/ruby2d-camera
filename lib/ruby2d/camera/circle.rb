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
        half_width = Window.width * 0.5
        half_height = Window.height * 0.5
        temp_radius = @radius * Camera.zoom
        temp_x = (((@x - Camera.x + radius) * Math.cos(angle)) - ((@y - Camera.y + radius) * Math.sin(angle))) * Camera.zoom + half_width
        temp_y = (((@x - Camera.x + radius) * Math.sin(angle)) + ((@y - Camera.y + radius) * Math.cos(angle))) * Camera.zoom + half_height
        Ruby2D::Circle.draw(x: temp_x, y: temp_y,
                            radius: temp_radius,
                            sectors: sectors,
                            color: [color.r, color.g, color.b, color.a])
      end

      def initialize(opts = {})
        super(opts)
        Camera << self
        Window.remove(self)
      end

      def z=(z)
        super(z)
        Camera._sort_by_z
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
