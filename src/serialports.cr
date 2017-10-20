require "./serialports/util/*"
require "./serialports/*"

module SerialPorts

  def self.list
    SerialPorts.check_result LibSerialPort.list_ports(out list)

    ports = [] of Port
    i = 0
    while port = list[i]
      ports << Port.new(port)
      i += 1
    end

    LibSerialPort.free_port_list(list)

    ports
  end

  def self.check_result(result : LibSerialPort::Return)
    return if result.ok?

    case result
    when .err_arg?
      raise ArgumentError.new
    when .err_fail?
      code = LibSerialPort.last_error_code.to_i
      message_ptr = LibSerialPort.last_error_message
      message = String.new message_ptr

      raise OSError.new(message, code)
    when .err_supp?
      raise NotSupportedError.new
    when .err_mem?
      raise MemoryAllocationError.new
    end
  end
end