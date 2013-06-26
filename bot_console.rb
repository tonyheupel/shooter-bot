#!/usr/bin/env ruby

require_relative './shooter_bot'

puts "Connecting..."

begin
  $bot = ShooterBot.new
rescue Exception => e
  puts "There was an error connecting: #{e.message}"
  puts "Please make sure your robot is on and connected."
  exit(1)
end

module Kernel
  def fire(count=1)
    say "Fire #{count}!"
    handle_error { $bot.fire count }
  end

  def right(degrees=90)
    turn_degrees(degrees, :c)
  end

  def left(degrees=90)
    turn_degrees(degrees, :b)
  end

  def red
    turn_light_on(:red)
  end

  def blue
    turn_light_on(:blue)
  end

  def green
    turn_light_on(:green)
  end

  def all
    turn_light_on(:full)
  end

  def off
    turn_light_off
  end

  def done
    handle_error do
      puts "Disconnecting..."
      say "Disconnecting"
      $bot.shut_down
      puts "Goodbye!"
      say "Goodbye!"
      exit(0)
    end
  end

  private
  def say(words)
    voice = "Victoria" #"Trinoids" #"Vicki"
    system("say -v \"#{voice}\" \"#{words}\"")
  end

  def turn_light_on(color)
    handle_error { $bot.light_on(color) }
  end

  def turn_light_off
    handle_error { $bot.light_off }
  end

  def turn_degrees(degrees, motor)
    handle_error do
      actual_turn_degrees = degrees * 12 # magic constant of requested degrees times actual motor degrees = robot degrees
      $bot.move_motor_and_brake(motor, 75, actual_turn_degrees)

    end
  end

  def handle_error(&block)
    begin
      result = yield
      puts "There was a problem: #{result.message}" unless result.success?
      "Completed."
    rescue Exception => e
      "There was an error: #{e.message}"
    end
  end
end

welcome = "Now controlling the Shooter Bot!"
puts welcome
say welcome
