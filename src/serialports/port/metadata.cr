module SerialPorts
  class Port
    module MetaData
      def name
        String.new LibSerialPort.get_port_name(self)
      end

      def description
        String.new LibSerialPort.get_port_description(self)
      end

      def transport
        LibSerialPort.get_port_transport(self)
      end

      def usb_bus_address?
        begin
          usb_bus_address
        rescue ex : SerialPorts::NotSupportedError
        rescue ex : SerialPorts::ArgumentError
          nil
        end
      end

      def usb_bus_address
        SerialPorts.check_result LibSerialPort.get_port_usb_bus_address(self, out usb_bus, out usb_address)
        {usb_bus, usb_address}
      end

      def usb_vid_pid?
        begin
          usb_vid_pid
        rescue ex : SerialPorts::NotSupportedError
        rescue ex : SerialPorts::ArgumentError
          nil
        end
      end

      def usb_vid_pid
        SerialPorts.check_result LibSerialPort.get_port_usb_vid_pid(self, out usb_vid, out usb_pid)
        {usb_vid, usb_pid}
      end

      def usb_manufacturer?
        begin
          usb_manufacturer
        rescue ex : SerialPorts::NotSupportedError
        rescue ex : SerialPorts::ArgumentError
          nil
        end
      end

      def usb_manufacturer
        value = LibSerialPort.get_port_usb_manufacturer(self)
        String.new value unless value.null?
      end

      def usb_product?
        begin
          usb_product
        rescue ex : SerialPorts::NotSupportedError
        rescue ex : SerialPorts::ArgumentError
          nil
        end
      end

      def usb_product
        value = LibSerialPort.get_port_usb_product(self)
        String.new value unless value.null?
      end

      def usb_serial?
        begin
          usb_serial
        rescue ex : SerialPorts::NotSupportedError
        rescue ex : SerialPorts::ArgumentError
          nil
        end
      end

      def usb_serial
        value = LibSerialPort.get_port_usb_serial(self)
        String.new value unless value.null?
      end

      def bluetooth_address?
        begin
          bluetooth_address
        rescue ex : SerialPorts::NotSupportedError
          nil
        end
      end

      def bluetooth_address
        value = LibSerialPort.get_port_bluetooth_address(self)
        String.new value unless value.null?
      end

      def metadata
        {
          :name => name,
          :description => description,
          :transport => transport,
          :usb_bus_address => usb_bus_address?,
          :usb_vid_pid => usb_vid_pid?,
          :usb_manufacturer => usb_manufacturer?,
          :usb_product => usb_product?,
          :usb_serial => usb_serial?,
          :bluetooth_address => bluetooth_address?
        }
      end
    end
  end
end
