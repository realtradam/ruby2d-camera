# frozen_string_literal: true

module Ruby2D
  module Camera
    class Triangle < Ruby2D::Triangle
      # Recalculates real coordiantes
      # Use after changing variables
      def _draw
        angle = Ruby2D::Camera.angle * (Math::PI / 180)
        half_width = Window.width * 0.5
        half_height = Window.height * 0.5
        temp_x1 = (((x + @x1 - Ruby2D::Camera.x) * Math.cos(angle)) - ((y + @y1 - Ruby2D::Camera.y) * Math.sin(angle))) * Ruby2D::Camera.zoom + half_width
        temp_y1 = (((x + @x1 - Ruby2D::Camera.x) * Math.sin(angle)) + ((y + @y1 - Ruby2D::Camera.y) * Math.cos(angle))) * Ruby2D::Camera.zoom + half_height
        temp_x2 = (((x + @x2 - Ruby2D::Camera.x) * Math.cos(angle)) - ((y + @y2 - Ruby2D::Camera.y) * Math.sin(angle))) * Ruby2D::Camera.zoom + half_width
        temp_y2 = (((x + @x2 - Ruby2D::Camera.x) * Math.sin(angle)) + ((y + @y2 - Ruby2D::Camera.y) * Math.cos(angle))) * Ruby2D::Camera.zoom + half_height
        temp_x3 = (((x + @x3 - Ruby2D::Camera.x) * Math.cos(angle)) - ((y + @y3 - Ruby2D::Camera.y) * Math.sin(angle))) * Ruby2D::Camera.zoom + half_width
        temp_y3 = (((x + @x3 - Ruby2D::Camera.x) * Math.sin(angle)) + ((y + @y3 - Ruby2D::Camera.y) * Math.cos(angle))) * Ruby2D::Camera.zoom + half_height
        Ruby2D::Triangle.draw(x1: temp_x1, y1: temp_y1,
                              x2: temp_x2, y2: temp_y2,
                              x3: temp_x3, y3: temp_y3,
                              color: [[self.c1.r, self.c1.g, self.c1.b, self.c1.a],
                                      [self.c2.r, self.c2.g, self.c2.b, self.c2.a],
                                      [self.c3.r, self.c3.g, self.c3.b, self.c3.a]])
      end

      def initialize(opts= {})
        super(opts)
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

