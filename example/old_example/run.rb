# frozen_string_literal: true

require 'ruby2d'
require 'ruby2d/camera'
require_relative 'house'
require_relative 'room'

Window.set(icon: './assets/blobcoolthink.png',
           width: 1280,
           height: 720,
           background: 'blue')

@player = Camera::Sprite.new('./assets/sprites/mainblob-128.png',
                             x: 1920 / 1.1,
                             y: 1080 / 1.1,
                             width: 50,
                             height: 50,
                             clip_width: 128,
                             loop: true,
                             time: 1,
                             z: 99,
                             animations: {
                               walk: 0...60,
                               stand: 60...61
                             })
@shadow = Camera::Image.new(
  'assets/blobshadow.png',
  width: 52,
  height: 10,
  z: 4
)
@player.play animation: :walk, loop: true

# UI
Rectangle.new(
  width: 350,
  height: 135,
  color: 'navy',
  z: 100
)
@ui_pos_cam = Text.new(
  'pos: 0,0',
  x: 10,
  y: 10,
  color: 'teal',
  z: 101
)
@ui_pos_ply = Text.new(
  'pos: 0,0',
  x: 10,
  y: 40,
  color: 'teal',
  z: 101
)
@ui_zoom = Text.new(
  'zoom: 0',
  x: 10,
  y: 70,
  color: 'lime',
  z: 101
)
@ui_rotation = Text.new(
  'rotation: 0',
  x: 10,
  y: 100,
  color: 'lime',
  z: 101
)
Rectangle.new(
  x: (Window.width - 120),
  width: 120,
  height: 45,
  color: 'navy',
  z: 100
)
@ui_fps = Text.new(
  'fps: 60.00',
  x: (Window.width - 110),
  y: 10,
  color: 'teal',
  z: 101
)

# How fast the player can move
@speed = 5

# Initializing
@player_movement_x = 0
@player_movement_y = 0
@pressed_space = false
@scene_transition_into = false
@scene_transition_out = false
@indoors = false
@house = nil
@room = nil

on :key do |event|
  @player_movement_y -= @speed if event.key == 'w' && !(@scene_transition_into || @scene_transition_out)
  @player_movement_y += @speed if event.key == 's' && !(@scene_transition_into || @scene_transition_out)
  @player_movement_x += @speed if event.key == 'd' && !(@scene_transition_into || @scene_transition_out)
  @player_movement_x -= @speed if event.key == 'a' && !(@scene_transition_into || @scene_transition_out)
  @pressed_space = true if event.key == 'space' && !(@scene_transition_into || @scene_transition_out)
  Camera.angle += 1 if event.key == 'q' && !(@scene_transition_into || @scene_transition_out)
  Camera.angle -= 1 if event.key == 'e' && !(@scene_transition_into || @scene_transition_out)
  if event.key == 'r' && !(@scene_transition_into || @scene_transition_out || Camera.angle.zero?)
    if Camera.angle <= 180
      Camera.angle -= if Camera.angle > 10
                        10
                      else
                        1
                      end
    elsif Camera.angle += if Camera.angle < 350
      10
                          else
                            1
                          end
    end
  end
end

update do
  if (@player.x > 2371 && @player_movement_x.positive?) || (@player.x.negative? && @player_movement_x.negative?)
    @player_movement_x = 0
  end
  if (@player.y > 1608 && @player_movement_y.positive?) || (@player.y.negative? && @player_movement_y.negative?)
    @player_movement_y = 0
  end
  if !@player_movement_y.zero? == !@player_movement_x.zero?
    @player_movement_x /= 1.4141
    @player_movement_y /= 1.4141
  end
  @player.x += @player_movement_x
  @player.y += @player_movement_y
  if @player_movement_x.negative?
    @player.play animation: :walk, loop: true
  elsif @player_movement_x.positive? || !@player_movement_y.zero?
    @player.play animation: :walk, loop: true, flip: :vertical
  else
    @player.play animation: :stand
  end

  if !@scene_transition_into && !@scene_transition_out
    Camera.zoom += ((-[
      Math.sqrt(((@player.x + (@player.width / 2) - Camera.x)**2) + ((@player.y + (@player.width / 2) - Camera.y)**2)), 350
    ].min * 0.004) + 2 - Camera.zoom) * 0.25
    Camera.x += (@player.x + (@player.width / 2) - Camera.x) * 0.025
    Camera.y += (@player.y + (@player.height / 2) - Camera.y) * 0.025
  elsif @scene_transition_into
    if Camera.zoom < 250
      Camera.zoom *= 1.05
      Camera.angle += 5
    else
      @scene_transition_into = false
      @scene_transition_out = true
      if @room.nil?
        @house.remove
        @house = nil
        @indoors = true
      else
        @room.remove
        @room = nil
        @indoors = false
      end
      @background.remove
      @background = nil
    end
    Camera.x += (@player.x + (@player.width / 2) - Camera.x) * 0.25
    Camera.y += (@player.y + (@player.height / 2) - Camera.y) * 0.25
  elsif @scene_transition_out
    if !((Camera.zoom <= (@zoom_transition * 1.001)) && (Camera.angle == @angle_transition))
      Camera.zoom /= 1.05
      Camera.angle -= 5
    else
      @scene_transition_out = false
    end
  end

  if @house.nil? && !@indoors
    @house = House.new(750, 300)
    @background = Camera::Image.new(
      'assets/background.png',
      x: 100, y: 100,
      z: -1
    )
  elsif @room.nil? && @indoors
    @room = Room.new(750, 300)
    @background = Camera::Rectangle.new(
      color: 'black',
      x: 0,
      y: 0,
      width: 1920,
      height: 1080,
      z: -1
    )
  end
  @shadow.x = @player.x - 2
  @shadow.y = @player.y + 42

  @house_text&.remove
  @house_text = if @indoors
                  @room.visted_by?(@player)
                else
                  @house.visted_by?(@player)
                end
  unless @house_text.nil?
    @house_text.center = true
  end
  if !@house_text.nil? && @pressed_space && !@scene_transition_into && !@scene_transition_out
    @scene_transition_into = true
    @angle_transition = Camera.angle
    @zoom_transition = Camera.zoom
  end
  @ui_pos_cam.text = "Camera Position: #{Camera.x.round(1)}, #{Camera.y.round(1)}"
  @ui_pos_ply.text = "Player Position: #{@player.x.round(1)}, #{@player.y.round(1)}"
  @ui_zoom.text = "Zoom: #{Camera.zoom.round(3)}"
  @ui_fps.text = "FPS: #{Window.fps.round(2)}"
  @ui_rotation.text = "Angle: #{Camera.angle}"
  @player_movement_x = 0
  @player_movement_y = 0
  @pressed_space = false

end
show
