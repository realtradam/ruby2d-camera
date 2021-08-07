require 'ruby2d'
require 'ruby2d/camera'

Camera::Image.new('./assets/bricktexture.png')

update do
  Camera.x = get(:mouse_x)
  Camera.angle = get(:mouse_y)
end

show
