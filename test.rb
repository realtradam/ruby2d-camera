require 'ruby2d'
require 'ruby2d/camera'

@tri = Ruby2D::Camera::Triangle.new

update do
  Ruby2D::Camera.redraw
end

show
