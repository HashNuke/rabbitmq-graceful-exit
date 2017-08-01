require "singleton"
require "bunny"
require_relative "rabbit"
require "pry"

class Worker
  include Singleton

  attr_accessor :rabbit
  attr_accessor :graceful_exit

  def connect!
    @rabbit = Rabbit.new
    @graceful_exit = false
  end


  def subscribe
    while true
      if graceful_exit?
        puts "[#{Process.pid}] gracefully exiting..."
        rabbit.q.channel.close
        rabbit.conn.close
        exit(0)
      end

      delivery_info, properties, message = rabbit.q.pop
      next if message.nil?
      yield message
    end
  end


  def graceful_exit!
    @graceful_exit = true
  end


  def graceful_exit?
    @graceful_exit
  end
end
