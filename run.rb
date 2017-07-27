require_relative "worker"

child_pids = 3.times.map do
  fork do
    @worker = Worker.instance

    Signal.trap("USR1") {
      puts "[#{Process.pid}] Got USR1"
      # worker = Worker.instance
      worker = @worker
      puts "#[#{Process.pid}]: #{worker.object_id}; #{worker.exit!}; #{worker.graceful_exit}"
    }
    
    puts "[#{Process.pid}] Instance #{@worker.object_id}"
    @worker.connect!

    @worker.subscribe do |message|
      puts "[#{Process.pid}] Received #{message.inspect}"
      sleep 10
      puts "[#{Process.pid}] Done"
    end

  end
end


puts "[PARENT] #{Process.pid}"
puts "Children: #{child_pids.inspect}"

puts Process.waitall