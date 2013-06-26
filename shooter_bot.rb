require 'nxt'

class ShooterBot < NXT
  def initialize(device_path='/dev/tty.NXT-DevB')
    super
    setup_inputs
    self.connect
  end

  def fire(count=1)
    fire_shots(count)
  end

  def shut_down
    self.disconnect
  end

  def light_on(color)
    color_symbol = "color#{color}".to_sym
    set_color(color_symbol)
  end

  def light_off
    set_color(:colornone)
  end

  def move_motor_and_brake(motor, power, turn_degrees)
    state = OutputState.new({
      :port => motor,
      :power => power,
      :mode_flags => OutputModeFlags.MOTORON | OutputModeFlags.BRAKE,
      :regulation_mode => :motor_speed,
      :run_state => :running,
      :tacho_limit => turn_degrees
    })

    set_output_state(state)
    reset_motor_position
  end

  private
  def setup_inputs
    return
    self.add_color_input(:three, :light)
  end

  def set_color(color_symbol)
    set_input_mode(:three, color_symbol, :booleanmode)
  end

  def fire_shots(count)
    move_motor_and_brake(:a, 100, 360 * count)
  end

end
