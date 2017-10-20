module SerialPorts
  class Port
    class Configuration
      include SerialPorts::Util::Struct(LibSerialPort::PortConfig)

      def initialize(port : SerialPorts::Port)
        @port = port

        new
      end

      def finalize
        free
      end

      private def new
        SerialPorts.check_result LibSerialPort.new_config(out ptr)
        self.ptr = ptr
      end

      private def free
        LibSerialPort.free_config(self)
        self.ptr = nil
      end

      def save
        SerialPorts.check_result LibSerialPort.set_config(@port, self)
      end

      def inspect
        {
          :baudrate => baudrate,
          :parity => parity,
          :bits => bits,
          :stop_bits => stop_bits,
          :rts => rts,
          :cts => cts,
          :dtr => dtr,
          :dsr => dsr,
          :xon_xoff => xon_xoff
        }
      end

      def baudrate : Int32
        SerialPorts.check_result LibSerialPort.get_config_baudrate(self, out baudrate)

        baudrate.to_i
      end

      def baudrate=(baudrate : Int32) : Void
        SerialPorts.check_result LibSerialPort.set_config_baudrate(self, baudrate.to_i16)

        save
      end

      def parity : LibSerialPort::Parity
        SerialPorts.check_result LibSerialPort.get_config_parity(self, out parity)
        parity
      end

      def parity=(parity : Symbol) : Void
        parity = LibSerialPort::Parity.parse(parity.to_s)

        SerialPorts.check_result LibSerialPort.set_config_parity(self, parity)

        save
      end

      def bits : Int32
        SerialPorts.check_result LibSerialPort.get_config_bits(self, out bits)
        bits.to_i
      end

      def bits=(bits : Int32) : Void
        SerialPorts.check_result LibSerialPort.set_config_bits(self, bits.to_i16)

        save
      end

      def stop_bits : Int32
        SerialPorts.check_result LibSerialPort.get_config_stopbits(self, out stopbits)
        stopbits.to_i
      end

      def stop_bits=(stopbits : Int32) : Void
        SerialPorts.check_result LibSerialPort.set_config_stopbits(self, stopbits.to_i16)

        save
      end

      def rts : LibSerialPort::RTS
        SerialPorts.check_result LibSerialPort.get_config_rts(self, out rts)
        rts
      end

      def rts=(rts : Symbol) : Void
        rts = LibSerialPort::RTS.parse(rts.to_s)
        SerialPorts.check_result LibSerialPort.set_config_rts(self, rts)

        save
      end

      def cts : LibSerialPort::CTS
        SerialPorts.check_result LibSerialPort.get_config_cts(self, out cts)
        cts
      end

      def cts=(cts : Symbol) : Void
        cts = LibSerialPort::CTS.parse(cts.to_s)
        SerialPorts.check_result LibSerialPort.set_config_cts(self, cts)

        save
      end

      def dtr : LibSerialPort::DTR
        SerialPorts.check_result LibSerialPort.get_config_dtr(self, out dtr)
        dtr
      end

      def dtr=(dtr : Symbol) : Void
        dtr = LibSerialPort::DTR.parse(dtr.to_s)
        SerialPorts.check_result LibSerialPort.set_config_dtr(self, dtr)

        save
      end

      def dsr : LibSerialPort::DSR
        SerialPorts.check_result LibSerialPort.get_config_dsr(self, out dsr)
        dsr
      end

      def dsr=(dsr : Symbol) : Void
        dsr = LibSerialPort::DSR.parse(dsr.to_s)
        SerialPorts.check_result LibSerialPort.set_config_dsr(self, dsr)

        save
      end

      def xon_xoff : LibSerialPort::XonXoff
        SerialPorts.check_result LibSerialPort.get_config_xon_xoff(self, out xon_xoff)
        xon_xoff
      end

      def xon_xoff=(xon_xoff : Symbol) : Void
        xon_xoff = LibSerialPort::XonXoff.parse(xon_xoff.to_s)
        SerialPorts.check_result LibSerialPort.set_config_xon_xoff(self, xon_xoff)

        save
      end

      def flow_control=(flowcontrol : Symbol) : Void
        flowcontrol = LibSerialPort::FlowControl.parse(flowcontrol.to_s)
        SerialPorts.check_result LibSerialPort.set_config_flowcontrol(self, flowcontrol)

        save
      end
    end
  end
end
