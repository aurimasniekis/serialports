# SerialPorts

LibSerialPort binding

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  serialports:
    github: aurimasniekis/serialports
```

## Usage

```crystal
require "serialports"

port = SerialPorts::Port.new "/dev/cu.usbmodem1423"

pp port.metadata

port.open

pp port.configuration

port.config.baudrate = 115200
port.config.save
pp port.configuration

io = port.io

while true
  result = io.gets

  puts result unless result.nil?

  while port.input_waiting < 1
    sleep 1
  end
end

```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it ( https://github.com/aurimasniekis/serialport/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [aurimasniekis](https://github.com/aurimasniekis) Aurimas Niekis - creator, maintainer
