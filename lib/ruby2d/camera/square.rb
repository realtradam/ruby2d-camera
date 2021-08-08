# frozen_string_literal: true

module Ruby2D
  module Camera
    # Wraps existing variables as well as adding new methods
    # so that it can be handled by the Camera Module
    class Square < Ruby2D::Square
      # Recalculates real coordiantes
      # Use after changing variables
      def _draw
        return if @hide
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
        Ruby2D::Quad.draw(x1: temp_x1, y1: temp_y1,
                          x2: temp_x2, y2: temp_y2,
                          x3: temp_x3, y3: temp_y3,
                          x4: temp_x4, y4: temp_y4,
                          color: [
                            [self.c1.r, self.c1.g, self.c1.b, self.c1.a],
                            [self.c2.r, self.c2.g, self.c2.b, self.c2.a],
                            [self.c3.r, self.c3.g, self.c3.b, self.c3.a],
                            [self.c4.r, self.c4.g, self.c4.b, self.c4.a]
                          ],
                          z: self.z
                         )
      end

      def initialize(opts= {})
        super(opts)
        Ruby2D::Camera << self
        Window.remove(self)
        @x1 -= @x
        @x2 -= @x
        @x3 -= @x
        @x4 -= @x
        @y1 -= @y
        @y2 -= @y
        @y3 -= @y
        @y4 -= @y
      end

      def remove
        @hide = true
      end

      def add
        @hide = false
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

