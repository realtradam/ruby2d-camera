# frozen_string_literal: true

module Ruby2D
  module Camera
    # Wraps existing variables as well as adding new methods
    # so that it can be handled by the Camera Module
    class Quad < Ruby2D::Quad
      # Recalculates real coordiantes
      # Use after changing variables
      def _draw
        return if @hide

        angle = Camera.angle * (Math::PI / 180)
        self_angle = self.angle * (Math::PI / 180)
        half_width = Window.width * 0.5
        half_height = Window.height * 0.5
        # rotate the shape
        temp1_x1 = (x1 * Math.cos(self_angle)) - (y1 * Math.sin(self_angle))
        temp1_y1 = (y1 * Math.cos(self_angle)) + (x1 * Math.sin(self_angle))
        temp1_x2 = (x2 * Math.cos(self_angle)) - (y2 * Math.sin(self_angle))
        temp1_y2 = (y2 * Math.cos(self_angle)) + (x2 * Math.sin(self_angle))
        temp1_x3 = (x3 * Math.cos(self_angle)) - (y3 * Math.sin(self_angle))
        temp1_y3 = (y3 * Math.cos(self_angle)) + (x3 * Math.sin(self_angle))
        temp1_x4 = (x4 * Math.cos(self_angle)) - (y4 * Math.sin(self_angle))
        temp1_y4 = (y4 * Math.cos(self_angle)) + (x4 * Math.sin(self_angle))
        # apply the camera modifications
        temp2_x1 = (((x + temp1_x1 - Camera.x) * Math.cos(angle)) - ((y + temp1_y1 - Camera.y) * Math.sin(angle))) * Camera.zoom + half_width
        temp2_y1 = (((x + temp1_x1 - Camera.x) * Math.sin(angle)) + ((y + temp1_y1 - Camera.y) * Math.cos(angle))) * Camera.zoom + half_height
        temp2_x2 = (((x + temp1_x2 - Camera.x) * Math.cos(angle)) - ((y + temp1_y2 - Camera.y) * Math.sin(angle))) * Camera.zoom + half_width
        temp2_y2 = (((x + temp1_x2 - Camera.x) * Math.sin(angle)) + ((y + temp1_y2 - Camera.y) * Math.cos(angle))) * Camera.zoom + half_height
        temp2_x3 = (((x + temp1_x3 - Camera.x) * Math.cos(angle)) - ((y + temp1_y3 - Camera.y) * Math.sin(angle))) * Camera.zoom + half_width
        temp2_y3 = (((x + temp1_x3 - Camera.x) * Math.sin(angle)) + ((y + temp1_y3 - Camera.y) * Math.cos(angle))) * Camera.zoom + half_height
        temp2_x4 = (((x + temp1_x4 - Camera.x) * Math.cos(angle)) - ((y + temp1_y4 - Camera.y) * Math.sin(angle))) * Camera.zoom + half_width
        temp2_y4 = (((x + temp1_x4 - Camera.x) * Math.sin(angle)) + ((y + temp1_y4 - Camera.y) * Math.cos(angle))) * Camera.zoom + half_height
        Ruby2D::Quad.draw(x1: temp2_x1, y1: temp2_y1,
                          x2: temp2_x2, y2: temp2_y2,
                          x3: temp2_x3, y3: temp2_y3,
                          x4: temp2_x4, y4: temp2_y4,
                          color: [
                            [c1.r, c1.g, c1.b, c1.a],
                            [c2.r, c2.g, c2.b, c2.a],
                            [c3.r, c3.g, c3.b, c3.a],
                            [c4.r, c4.g, c4.b, c4.a]
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

      def angle
        @angle ||= 0
      end

      def angle=(angle)
        @angle = (angle % 360)
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
