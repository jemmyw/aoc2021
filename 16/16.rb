require 'byebug'

def hex_bits(hex)
  c = {
    '0' => '0000',
    '1' => '0001',
    '2' => '0010',
    '3' => '0011',
    '4' => '0100',
    '5' => '0101',
    '6' => '0110',
    '7' => '0111',
    '8' => '1000',
    '9' => '1001',
    'A' => '1010',
    'B' => '1011',
    'C' => '1100',
    'D' => '1101',
    'E' => '1110',
    'F' => '1111',
  }
  hex.each_char.map { |ch| c[ch] }.join('')
end

class MsgStream
  def initialize(bits)
    @s = bits
  end

  def empty?
    @s.empty?
  end

  def length
    @s.length
  end

  def read_bits(len)
    raise 'Not enough bits' if @s.length < len

    b = @s[0..len - 1]
    @s = @s[len..-1]
    b
  end

  def read_i(len)
    read_bits(len).to_i(2)
  end

  def peek_bits(len)
    @s[0..len - 1]
  end

  def peek_i(len)
    peek_bits(len).to_i(2)
  end
end

def read_literal(msg)
  bits = ''
  while true
    is_last = msg.read_i(1) == 0
    bits << msg.read_bits(4)
    break if is_last
  end

  { type: 'literal', value: bits.to_i(2) }
end

def read_subpackets_by_bits(msg)
  bits = msg.read_i(15)
  pbits = msg.read_bits(bits)
  submsg = MsgStream.new(pbits)
  read_packets(submsg)
end

def read_subpackets_by_len(msg)
  len = msg.read_i(11)
  len.times.map { read_packet(msg) }
end

def read_operator(msg)
  mode = msg.read_i(1)

  packets =
    mode == 0 ? read_subpackets_by_bits(msg) : read_subpackets_by_len(msg)

  { type: 'operator', packets: packets }
end

@version_sum = 0
def read_packet(msg)
  version = msg.read_i(3)
  @version_sum += version
  type = msg.read_i(3)

  (type == 4 ? read_literal(msg) : read_operator(msg)).merge(version: version)
end

def read_packets(msg)
  packets = []
  packets << read_packet(msg) while !msg.empty?
  packets
end

msg = MsgStream.new(hex_bits(File.read("input.txt")))
puts read_packet(msg).inspect
puts @version_sum