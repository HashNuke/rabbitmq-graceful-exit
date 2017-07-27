require "bunny"

class Rabbit
  attr_accessor :conn, :channel, :q

  def initialize
    @conn = Bunny.new
    conn.start
    @channel = conn.create_channel
    @q = channel.queue("hello-rabbit", durable: true)
  end


  def post(message)
    channel.default_exchange.publish(message, routing_key: q.name)
    puts "[x] Sent #{message.inspect}"
  end


  def destroy
    conn.close
  end
end
