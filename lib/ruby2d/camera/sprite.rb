# frozen_string_literal: true

module Ruby2D
  module Camera
    # Wraps existing variables as well as adding new methods
    # so that it can be handled by the Camera Module
    class Sprite < Ruby2D::Sprite
      # Recalculates real coordiantes
      # Use after changing variables
      def _draw
        return if @hide

        angle = Camera.angle * (Math::PI / 180)
        half_width = Window.width * 0.5
        half_height = Window.height * 0.5
        offset_x = @x + (width / 2)
        offset_y = @y + (height / 2)
        temp_x = (((offset_x - Camera.x) * Math.cos(angle)) - ((offset_y - Camera.y) * Math.sin(angle))) \
          * Camera.zoom + half_width - (width * Camera.zoom / 2)
        temp_y = (((offset_x - Camera.x) * Math.sin(angle)) + ((offset_y - Camera.y) * Math.cos(angle))) \
          * Camera.zoom + half_height - (height * Camera.zoom / 2)
        temp_rotate = rotate + Camera.angle
        temp_width = width * Camera.zoom
        temp_height = height * Camera.zoom
        case @flip
        when :both
          temp_x += temp_height
          temp_y += temp_width
          temp_width = -temp_width
          temp_height = -temp_height
          puts 'both'
        when :horizontal
          temp_y += temp_width
          temp_height = -temp_height
        when :vertical
          temp_width = -temp_width
          temp_x += temp_height
        end
        draw(x: temp_x, y: temp_y,
             width: temp_width,
             height: temp_height,
             rotate: temp_rotate)
        update
      end

      def initialize(path, opts = {})
        super(path, opts)
        Ruby2D::Camera << self
        Window.remove(self)
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
