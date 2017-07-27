Signal.trap("USR1")  {
  puts "Got USR1"
  exit 0
}

puts "going to sleep"
sleep 3000
puts "woken up"
