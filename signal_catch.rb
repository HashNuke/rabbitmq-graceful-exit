begin
  puts "going to sleep"
  sleep 100
rescue => e
  puts e.inspect
end
