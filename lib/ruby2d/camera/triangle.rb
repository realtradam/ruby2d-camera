# frozen_string_literal: true

module Ruby2D
  module Camera
    # Wraps existing variables as well as adding new methods
    # so that it can be handled by the Ruby2D::Camera Module
    class Triangle << Ruby2D::Triangle
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
        self.draw(x1: temp_x1, y1: temp_y1,
                  x2: temp_x2, y2: temp_y2,
                  x3: temp_x3, y3: temp_y3)
      end

      def initialize(opts= {})
        #add to camera?
        super(opts)
        Ruby2D::Camera << self
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
=begin
      # Wrappers for the coordinates so that
      # they are handled by the Ruby2D::Camera instead
      # and for ease of programming
      def x1
        @virtual_x1 ||= @x1
      end

      def x1=(x1)
        @virtual_x1 = x1
      end

      def y1
        @virtual_y1 ||= @y1
      end

      def y1=(y1)
        @virtual_y1 = y1
      end

      def x2
        @virtual_x2 ||= @x2
      end

      def x2=(x2)
        @virtual_x2 = x2
      end

      def y2
        @virtual_y2 ||= @y2
      end

      def y2=(y2)
        @virtual_y2 = y2
      end

      def x3
        @virtual_x3 ||= @x3
      end

      def x3=(x3)
        @virtual_x3 = x3
      end

      def y3
        @virtual_y3 ||= @y3
      end

      def y3=(y3)
        @virtual_y3 = y3
      end
=end
    end
  end
end

