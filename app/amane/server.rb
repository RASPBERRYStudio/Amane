require 'eventmachine'
require 'json'
$stdout.sync = true

class Util
  def self.valid_json?(json)
    JSON.parse(json)
    return true
  rescue JSON::ParserError => e
    return false
  end
end

class AmaneServer < EventMachine::Connection  
  def initialize channel
    @channel = channel
  end
  
  def post_init
    @sid = @channel.subscribe do |msg|
      send_data msg
    end
    puts "someone connected to the amane server!"
  end

  def receive_data data
    case data[0, 4]
    when "0x82"
      puts "Player PreLogin..."
      if Util.valid_json? data.slice(4..-1)
        json = JSON.load(data.slice(4..-1))
        if json["Protocol"] == "0.0.1"
          send_data '0x83{Status: 1}'
        elsif json["Protocol"].slice(0..2).to_f() > 0.1
          send_data '0x83{"Status": 0}'
          close_connection_after_writing
        elsif json["Protocol"].slice(0..2).to_f() < 0.1
          send_data '0x83{"Status": 1}'
          close_connection_after_writing
        end
      else
        send_data '0x83{"Status": 3}'
      end
    when "0x0f"
      @channel.push data.slice(4..-1)
    end
  end

  def unbind
    @channel.unsubscribe @sid
    puts "someone disconnected from the amane server!"
  end
end

puts "Starting Amane System"

EM.run do
  @channel = EventMachine::Channel.new
  EventMachine.start_server "127.0.0.1", 21265, AmaneServer, @channel
end