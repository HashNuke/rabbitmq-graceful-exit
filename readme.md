### Start workers

```
ruby run.rb
```

### To send messages

```
irb -r ./rabbit.rb
```

Code to send messages

```
r = Rabbit.new
r.post "hello"

(1..20).to_a.map {|i| r.post("hello #{i}")}
```

### Send signal to gracefully exit

```
kill -SIGUSR1 <pid>
```
