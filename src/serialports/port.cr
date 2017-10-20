require "./port/*"

module SerialPorts
  class Port
    include Util::Struct(LibSerialPort::Port)
    include MetaData

    getter? opened : Bool = false
    getter config : Configuration?

    def initialize(ptr : LibSerialPort::Port*)
      SerialPorts.check_result LibSerialPort.copy_port(ptr, out copy_port)
      self.ptr = copy_port
    end

    def initialize(name : String)
      SerialPorts.check_result LibSerialPort.get_port_by_name(name, out ptr)

      super ptr
    end

    def finalize
      close if opened?

      LibSerialPort.free_port(self)
      self.ptr = nil
    end

    def config : Configuration
      @config ||= begin
        config = Configuration.new self
        SerialPorts.check_result LibSerialPort.get_config(self, config)
        config
      end
    end

    def configuration
      config.inspect
    end

    def closed?
      !opened?
    end

    def openReadOnly
      open(:read)
    end

    def open
      open(:read_write)
    end

    def open(mode : Symbol) : Bool
      return false if opened?

      begin
        mode = LibSerialPort::Mode.parse(mode.to_s)
        SerialPorts.check_result LibSerialPort.open(self, mode)
        @opened = true
      end

      true
    end

    def close : Bool
      return false if closed?

      begin
        SerialPorts.check_result LibSerialPort.close(self)
        @opened = false
      end

      true
    end

    def handle
      fd = uninitialized LibC::Int
      SerialPorts.check_result LibSerialPort.get_port_handle(self, pointerof(fd))
      fd
    end

    def io
      @io ||= IO::FileDescriptor.new handle

      @io
    end

    def input_waiting
      LibSerialPort.input_waiting(self)
    end
  end
end
