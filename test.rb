require 'ruby2d'
require 'ruby2d/camera'

Camera::Circle.new

update do
  Camera.x = get(:mouse_x)
  Camera.angle = get(:mouse_y)
end

show
