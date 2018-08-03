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

module AmaneServer
  def post_init
    puts "someone connected to the amane server!"
  end

  def receive_data data
    case data[0, 4]
    when "0x82"
      puts "Player PreLogin..."
      if Util.valid_json? data.slice(4..-1)
        json = JSON.load(data.slice(4..-1))
        puts "client-protocol: #{json["Protocol"]}"
        if json["Protocol"] == "0.0.1"
          send_data '0x83{Status: 1}'
        elsif json["Protocol"].slice(0..2).to_f() > 0.1
          puts "disconnected client: Server is outdated."
          send_data '0x83{"Status": 0}'
          close_connection_after_writing
        elsif json["Protocol"].slice(0..2).to_f() < 0.1
          puts "disconnected client: Client is outdated."
          send_data '0x83{"Status": 1}'
          close_connection_after_writing
        end
      else
        send_data '0x83{"Status": 3}'
      end
    end
  end

  def unbind
    puts "someone disconnected from the amane server!"
  end
end

puts "Starting Amane System"
EventMachine.run {
  EventMachine.start_server "127.0.0.1", 21265, AmaneServer
}