module SerialPorts::Util::Struct(T)
  @ptr : T*?

  def initialize(ptr : T*? = nil)
    self.ptr = ptr
  end

  def to_unsafe : T*
    ptr
  end

  def wrapped : T
    ptr.value
  end

  def ptr? : T*?
    @ptr
  end

  def ptr : T*
    @ptr ||= Pointer(T).null
  end

  protected def ptr=(ptr) : T*?
    @ptr = ptr
  end
end
