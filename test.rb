require 'ruby2d'
require 'ruby2d/camera'

Camera::Quad.new
#Camera::Image.new('./assets/bricktexture.png')
#@test = Image.new('./assets/bricktexture.png')
#@test.remove
update do
#  @test.draw(x: get(:mouse_x),
#             y: get(:mouse_y))
#  @test.x = get(:mouse_x)
#  @test.y = get(:mouse_y)
  Camera.x = get(:mouse_x)
  Camera.angle = get(:mouse_y)
end

show
