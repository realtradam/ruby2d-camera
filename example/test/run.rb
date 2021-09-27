require 'ruby2d'
require 'ruby2d/camera'

Window.set(width: 640,
           height: 480)

# ----- UI -----
#Rectangle.new(
#  width: 350,
#  height: 135,
#  color: 'navy',
#  z: 100
#)
@ui_pos_cam = Text.new(
  'pos: 0,0',
  x: 10,
  y: 10,
  color: 'teal',
  z: 101
)
#@ui_pos_ply = Text.new(
#  'pos: 0,0',
#  x: 10,
#  y: 40,
#  color: 'teal',
#  z: 101
#)
@ui_zoom = Text.new(
  'zoom: 0',
  x: 10,
  y: 35,
  color: 'lime',
  z: 101
)
@ui_rotation = Text.new(
  'rotation: 0',
  x: 10,
  y: 60,
  color: 'lime',
  z: 101
)
#Rectangle.new(
#  x: (Window.width - 120),
#  width: 80,
#  height: 45,
#  color: 'navy',
#  opacity: 0.3,
#  z: 100
#)
@ui_fps = Text.new(
  'fps: 60.00',
  x: (Window.width - 110),
  y: 10,
  color: 'teal',
  z: 101
)
@dancing_alien1 = Camera::Sprite.new('./assets/alienpls-56.png',
                                     x: 520 + -28,
                                     y: -28,
                                     width: 56,
                                     height: 56,
                                     clip_width: 56,
                                     loop: true,
                                     time: 35,
                                     z: 1)
@dancing_alien1.play
@dancing_alien2 = Camera::Sprite.new('./assets/alienpls-56.png',
                                     x: -28,
                                     y: 370 + -28,
                                     width: 56,
                                     height: 56,
                                     clip_width: 56,
                                     loop: true,
                                     time: 35,
                                     z: 1)
@dancing_alien2.play
@dancing_alien3 = Camera::Sprite.new('./assets/alienpls-56.png',
                                     x: -520 + -28,
                                     y: -28,
                                     width: 56,
                                     height: 56,
                                     clip_width: 56,
                                     loop: true,
                                     time: 35,
                                     z: 1)
@dancing_alien3.play
@dancing_alien4 = Camera::Sprite.new('./assets/alienpls-56.png',
                                     x: -28,
                                     y: -370 + -28,
                                     width: 56,
                                     height: 56,
                                     clip_width: 56,
                                     loop: true,
                                     time: 35,
                                     z: 1)
@dancing_alien4.play

@caution_topleft = []
@caution_topright = []
@caution_botleft = []
@caution_botright = []

@caution_topleft.push Camera::Triangle.new(color: 'yellow',
                                           x1: -280, y1: -200,
                                           x2: -260, y2: -220,
                                           x3: -300, y3: -220
                                          )
@caution_topleft.push Camera::Triangle.new(color: 'gray',
                                           x1: -280, y1: -200,
                                           x2: -300, y2: -180,
                                           x3: -300, y3: -220
                                          )
@caution_topleft.push Camera::Quad.new(color: 'yellow',
                                       x1: -280, y1: -200,
                                       x2: -300, y2: -180,
                                       x3: -300, y3: -160,
                                       x4: -280, y4: -180
                                      )
@caution_topleft.push Camera::Quad.new(color: 'gray',
                                       x1: -280, y1: -160,
                                       x2: -300, y2: -140,
                                       x3: -300, y3: -160,
                                       x4: -280, y4: -180
                                      )
@caution_topleft.push Camera::Quad.new(color: 'gray',
                                       x1: -280, y1: -200,
                                       x2: -260, y2: -220,
                                       x3: -240, y3: -220,
                                       x4: -260, y4: -200
                                      )
@caution_topleft.push Camera::Quad.new(color: 'yellow',
                                       x1: -240, y1: -200,
                                       x2: -220, y2: -220,
                                       x3: -240, y3: -220,
                                       x4: -260, y4: -200
                                      )

@caution_topright.push Camera::Triangle.new(color: 'yellow',
                                            x1: 280, y1: -200,
                                            x2: 260, y2: -220,
                                            x3: 300, y3: -220
                                           )
@caution_topright.push Camera::Triangle.new(color: 'gray',
                                            x1: 280, y1: -200,
                                            x2: 300, y2: -180,
                                            x3: 300, y3: -220
                                           )
@caution_topright.push Camera::Quad.new(color: 'yellow',
                                        x1: 280, y1: -200,
                                        x2: 300, y2: -180,
                                        x3: 300, y3: -160,
                                        x4: 280, y4: -180
                                       )
@caution_topright.push Camera::Quad.new(color: 'gray',
                                        x1: 280, y1: -160,
                                        x2: 300, y2: -140,
                                        x3: 300, y3: -160,
                                        x4: 280, y4: -180
                                       )
@caution_topright.push Camera::Quad.new(color: 'gray',
                                        x1: 280, y1: -200,
                                        x2: 260, y2: -220,
                                        x3: 240, y3: -220,
                                        x4: 260, y4: -200
                                       )
@caution_topright.push Camera::Quad.new(color: 'yellow',
                                        x1: 240, y1: -200,
                                        x2: 220, y2: -220,
                                        x3: 240, y3: -220,
                                        x4: 260, y4: -200
                                       )

@caution_botleft.push Camera::Triangle.new(color: 'yellow',
                                           x1: -280, y1: 200,
                                           x2: -260, y2: 220,
                                           x3: -300, y3: 220
                                          )
@caution_botleft.push Camera::Triangle.new(color: 'gray',
                                           x1: -280, y1: 200,
                                           x2: -300, y2: 180,
                                           x3: -300, y3: 220
                                          )
@caution_botleft.push Camera::Quad.new(color: 'yellow',
                                       x1: -280, y1: 200,
                                       x2: -300, y2: 180,
                                       x3: -300, y3: 160,
                                       x4: -280, y4: 180
                                      )
@caution_botleft.push Camera::Quad.new(color: 'gray',
                                       x1: -280, y1: 160,
                                       x2: -300, y2: 140,
                                       x3: -300, y3: 160,
                                       x4: -280, y4: 180
                                      )
@caution_botleft.push Camera::Quad.new(color: 'gray',
                                       x1: -280, y1: 200,
                                       x2: -260, y2: 220,
                                       x3: -240, y3: 220,
                                       x4: -260, y4: 200
                                      )
@caution_botleft.push Camera::Quad.new(color: 'yellow',
                                       x1: -240, y1: 200,
                                       x2: -220, y2: 220,
                                       x3: -240, y3: 220,
                                       x4: -260, y4: 200
                                      )

@caution_botright.push Camera::Triangle.new(color: 'yellow',
                                            x1: 280, y1: 200,
                                            x2: 260, y2: 220,
                                            x3: 300, y3: 220
                                           )
@caution_botright.push Camera::Triangle.new(color: 'gray',
                                            x1: 280, y1: 200,
                                            x2: 300, y2: 180,
                                            x3: 300, y3: 220
                                           )
@caution_botright.push Camera::Quad.new(color: 'yellow',
                                        x1: 280, y1: 200,
                                        x2: 300, y2: 180,
                                        x3: 300, y3: 160,
                                        x4: 280, y4: 180
                                       )
@caution_botright.push Camera::Quad.new(color: 'gray',
                                        x1: 280, y1: 160,
                                        x2: 300, y2: 140,
                                        x3: 300, y3: 160,
                                        x4: 280, y4: 180
                                       )
@caution_botright.push Camera::Quad.new(color: 'gray',
                                        x1: 280, y1: 200,
                                        x2: 260, y2: 220,
                                        x3: 240, y3: 220,
                                        x4: 260, y4: 200
                                       )
@caution_botright.push Camera::Quad.new(color: 'yellow',
                                        x1: 240, y1: 200,
                                        x2: 220, y2: 220,
                                        x3: 240, y3: 220,
                                        x4: 260, y4: 200
                                       )

@text = Camera::Text.new("Bigger circles should always be in front of smaller ones",
                         size: 30,
                         x: 0, y: 65)
@text.center = true

@zindex_test = []

@zindex_test.push Camera::Circle.new(color: 'random',
                                     x: 50 + -25, y: -25,
                                     radius: 25)
@zindex_test.push Camera::Circle.new(color: 'random',
                                     x: 25 + -25, y: -25,
                                     radius: 25)
@zindex_test.push Camera::Circle.new(color: 'random',
                                     x: 0 + -25, y: -25,
                                     radius: 25)
@zindex_test.push Camera::Circle.new(color: 'random',
                                     x: -25 + -25, y: -25,
                                     radius: 25)
@zindex_test.push Camera::Circle.new(color: 'random',
                                     x: -50 + -25, y: -25,
                                     radius: 25)

@speed = 5
@one_degree_in_radians = 0.01745329

on :key do |event|
  Camera.y -= (Math.cos(Camera.angle * @one_degree_in_radians) * @speed) if event.key == 'w'
  Camera.y += (Math.cos(Camera.angle * @one_degree_in_radians) * @speed) if event.key == 's'
  Camera.x -= (Math.sin(Camera.angle * @one_degree_in_radians) * @speed) if event.key == 'w'
  Camera.x += (Math.sin(Camera.angle * @one_degree_in_radians) * @speed) if event.key == 's'

  Camera.x += (Math.cos(Camera.angle * @one_degree_in_radians) * @speed) if event.key == 'd'
  Camera.x -= (Math.cos(Camera.angle * @one_degree_in_radians) * @speed) if event.key == 'a'
  Camera.y -= (Math.sin(Camera.angle * @one_degree_in_radians) * @speed) if event.key == 'd'
  Camera.y += (Math.sin(Camera.angle * @one_degree_in_radians) * @speed) if event.key == 'a'

  #@pressed_space = true if event.key == 'space' && !(@scene_transition_into || @scene_transition_out)
  Camera.angle += 1.5 if event.key == 'q'
  Camera.angle -= 1.5 if event.key == 'e'
  Camera.zoom *= 1.01 if event.key == 'z'
  Camera.zoom *= 0.99 if event.key == 'x'
  if event.key == 'r'# && !(@scene_transition_into || @scene_transition_out || Camera.angle.zero?)
    if Camera.zoom < 1.0
      Camera.zoom *= 1.03
      if Camera.zoom > 1.0
        Camera.zoom = 1.0
      end
    elsif Camera.zoom > 1.0
      Camera.zoom /= 1.03
      if Camera.zoom < 1.0
        Camera.zoom = 1.0
      end
    end
    if Camera.angle <= 180
      Camera.angle -= if Camera.angle > 10
                        10
                      elsif Camera.angle != 0
                        1
                      else
                        0
                      end
    elsif Camera.angle += if Camera.angle < 350
      10
                          elsif Camera.angle != 0
                            1
                          else
                            0
                          end
    if (Camera.angle > 359) || (Camera.angle < 1)
      Camera.angle = 0
    end
    end
  end
end

@frame = 0
update do
  @frame += 1

  @a = (Math.sin(((@frame - 30) % 120) * (Math::PI / 60.0)) * 15 + 25)
  @b = (Math.sin(((@frame - 15) % 120) * (Math::PI / 60.0)) * 15 + 25)
  @c = (Math.sin((@frame % 120) * (Math::PI / 60.0)) * 15 + 25)
  @d = (Math.sin(((@frame + 15) % 120) * (Math::PI / 60.0)) * 15 + 25)
  @e = (Math.sin(((@frame + 30) % 120) * (Math::PI / 60.0)) * 15 + 25)
  @zindex_test[0].z = @a
  @zindex_test[0].radius = @a
  @zindex_test[0].x = 50 + -@a
  @zindex_test[0].y = -@a
  @zindex_test[1].z = @b
  @zindex_test[1].radius = @b
  @zindex_test[1].x = 25 + -@b
  @zindex_test[1].y = -@b
  @zindex_test[2].z = @c
  @zindex_test[2].radius = @c
  @zindex_test[2].x = -@c
  @zindex_test[2].y = -@c
  @zindex_test[3].z = @d 
  @zindex_test[3].radius = @d 
  @zindex_test[3].x = -25 + -@d 
  @zindex_test[3].y = -@d 
  @zindex_test[4].z = @e
  @zindex_test[4].radius = @e
  @zindex_test[4].x = -50 + -@e
  @zindex_test[4].y = -@e

  if (@frame % 120) < 30
    @dancing_alien1.add
    @dancing_alien2.remove
    @dancing_alien3.remove
    @dancing_alien4.remove
  elsif ((@frame + 30)  % 120) < 30
    @dancing_alien1.remove
    @dancing_alien2.add
    @dancing_alien3.remove
    @dancing_alien4.remove
  elsif ((@frame + 60)  % 120) < 30
    @dancing_alien1.remove
    @dancing_alien2.remove
    @dancing_alien3.add
    @dancing_alien4.remove
  elsif ((@frame + 90)  % 120) < 30
    @dancing_alien1.remove
    @dancing_alien2.remove
    @dancing_alien3.remove
    @dancing_alien4.add
  end

  @ui_pos_cam.text = "Camera Position: #{Camera.x.round(1)}, #{Camera.y.round(1)}"
  #@ui_pos_ply.text = "Player Position: #{@player.x.round(1)}, #{@player.y.round(1)}"
  @ui_zoom.text = "Zoom: #{Camera.zoom.round(3)}"
  @ui_fps.text = "FPS: #{Window.fps.round(2)}"
  @ui_rotation.text = "Angle: #{Camera.angle}"
end

show
