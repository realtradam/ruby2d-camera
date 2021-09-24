# frozen_string_literal: true

module Ruby2D
  module Camera
    # Wraps existing variables as well as adding new methods
    # so that it can be handled by the Camera Module
    class Line < Ruby2D::Line
      # Recalculates real coordiantes
      # Use after changing variables
      def _draw
        return if @hide

        angle = Camera.angle * (Math::PI / 180)
        half_width = Window.width * 0.5
        half_height = Window.height * 0.5
        temp_x1 = (((x + @x1 - Camera.x) * Math.cos(angle)) - ((y + @y1 - Camera.y) * Math.sin(angle))) * Camera.zoom + half_width
        temp_y1 = (((x + @x1 - Camera.x) * Math.sin(angle)) + ((y + @y1 - Camera.y) * Math.cos(angle))) * Camera.zoom + half_height
        temp_x2 = (((x + @x2 - Camera.x) * Math.cos(angle)) - ((y + @y2 - Camera.y) * Math.sin(angle))) * Camera.zoom + half_width
        temp_y2 = (((x + @x2 - Camera.x) * Math.sin(angle)) + ((y + @y2 - Camera.y) * Math.cos(angle))) * Camera.zoom + half_height
        temp_width = width * Camera.zoom
        Ruby2D::Line.draw(x1: temp_x1, y1: temp_y1,
                          x2: temp_x2, y2: temp_y2,
                          width: temp_width,
                          color: [
                            [color.r, color.g, color.b, color.a],
                            [color.r, color.g, color.b, color.a],
                            [color.r, color.g, color.b, color.a],
                            [color.r, color.g, color.b, color.a]
                          ],
                          z: z)
      end

      def initialize(opts = {})
        super(opts)
        Ruby2D::Camera << self
        Window.remove(self)
      end

      def remove
        @hide = true
      end

      def add
        @hide = false
      end

      # Methods for moving the shape
      attr_writer :x, :y

      def x
        @x ||= 0
      end

      def y
        @y ||= 0
      end

      def z=(z)
        super(z)
        Ruby2D::Camera._sort_by_z
      end
    end
  end
end
