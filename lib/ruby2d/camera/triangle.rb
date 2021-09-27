# frozen_string_literal: true

module Ruby2D
  module Camera
    class Triangle < Ruby2D::Triangle
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
        temp_x3 = (((x + @x3 - Camera.x) * Math.cos(angle)) - ((y + @y3 - Camera.y) * Math.sin(angle))) * Camera.zoom + half_width
        temp_y3 = (((x + @x3 - Camera.x) * Math.sin(angle)) + ((y + @y3 - Camera.y) * Math.cos(angle))) * Camera.zoom + half_height
        Ruby2D::Triangle.draw(x1: temp_x1, y1: temp_y1,
                              x2: temp_x2, y2: temp_y2,
                              x3: temp_x3, y3: temp_y3,
                              color: [
                                [c1.r, c1.g, c1.b, c1.a],
                                [c2.r, c2.g, c2.b, c2.a],
                                [c3.r, c3.g, c3.b, c3.a]
                              ],
                              z: z)
      end

      def initialize(opts = {})
        super(opts)
        Camera << self
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
        Camera._sort_by_z
      end
    end
  end
end
