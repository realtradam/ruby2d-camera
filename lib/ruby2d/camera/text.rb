# frozen_string_literal: true

module Ruby2D
  module Camera
    # Wraps existing variables as well as adding new methods
    # so that it can be handled by the Camera Module
    # TODO: note that text could not be resized at the current iteration
    # of Ruby2D so the math needs to be changed compensate for this.
    # When Ruby2D gets updated to allow text resizing the math will need
    # to be corrected again(see image_wrapper.rb for reference, that has
    # math that allows for resizing)
    class Text < Ruby2D::Text
      # Recalculates real coordiantes
      # Use after changing variables
      def _draw
        return if @hide

        angle = Camera.angle * (Math::PI / 180)
        #puts render_text.width
        half_width = Window.width * 0.5
        half_height = Window.height * 0.5
        if center
          offset_y = y + (Camera.zoom / 2)
          offset_x = x + (Camera.zoom / 2)
          render_text.size = size
        else
          # very broken
          #offset_x = x + (width / Camera.zoom / 2)# - (render_text.width / 2 / Camera.zoom)
          #offset_y = y + (height / Camera.zoom / 2)# - (render_text.height / 2 / Camera.zoom)
          #render_text.size = size * Camera.zoom
          offset_y = y + (Camera.zoom / 2)
          offset_x = x + (Camera.zoom / 2)
          render_text.size = size * Camera.zoom
        end
        temp_x = (((offset_x - Camera.x) * Math.cos(angle)) - ((offset_y - Camera.y) * Math.sin(angle))) \
          * Camera.zoom + half_width - (width / 2)
        temp_y = (((offset_x - Camera.x) * Math.sin(angle)) + ((offset_y - Camera.y) * Math.cos(angle))) \
          * Camera.zoom + half_height - (height / 2)
        temp_rotate = rotate + Camera.angle
        render_text.draw(x: temp_x, y: temp_y,
                         rotate: temp_rotate,
                         color: [color.r, color.g, color.b, color.a])
      end

      def initialize(text, opts = {})
        super(text, opts)
        self.render_text = Ruby2D::Text.new(text, opts)
        render_text.remove
        if opts[:center].nil?
          self.center = true
        else
          self.center = opts[:center]
        end
        Camera << self
        Window.remove(self)
      end

      def z=(z)
        super(z)
        render_text.z = z
        Camera._sort_by_z
      end

      def text=(text)
        super(text)
        render_text.text = text
      end

      def remove
        @hide = true
      end

      def add
        @hide = false
      end

      attr_accessor :center, :render_text
    end
  end
end
