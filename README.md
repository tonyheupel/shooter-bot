# Shooter Bot Console
A command-line console for controlling the Shooter Bot from the NXT 2.0 instructions.
It currently uses the ``` say ``` program on Mac OSX to do speech on the computer as well.

## Usage

As long as you have Ruby installed and Bundler installed (``` gem install bundler ```), you
can simply connect your NXT via Bluetooth.  By default, the console uses '/dev/tty.NXT-DevB'
as the bluetooth serial port connction.  Then, open a command prompt and use it as such:

```bash
$ ./bot
Connecting...
Now controlling the Shooter Bot!
>> fire         # => fires one ball
>> fire 2      # => fires two balls
>> right       # => turns right 90 degrees
>> left 32    # => turns left 32 degrees
>> red        # => turn on the red light on the color light/sensor
>> blue       # => turn on the blue light on the color light/sensor
>> green     # => turn on the green light on the color light/sensor
>> all          # => turn on all the lights on the color light/sensor at the same time
>> off         # => turn off all of the lights on the color light/sensor
>> done     # => disconnect from the robot and end the bot console session
Disconnecting...
Goodbye!
```

### Changing the Port

Right now, you simply change the line the ``` bot_console.rb ```:

```ruby
  $bot = ShooterBot.new
```
to
```ruby
  $bot = ShooterBot.new '/dev/tty.NXT-DevB-my-device-string'
```

It should be easy to update to add command-line parsing for this instead of changing code.  I just
have not done it yet since I always connect on the same port.