:ok = :hackney_pool.start_pool(:first_pool, [timeout: 15000, max_connections: 1000])
HTTPoison.start

# Calculate squares of these numbers
parallelism = 100_000
num_of_entries = 1_000_000
start_time = :os.system_time(:millisecond)
results = Parallel.pmap(1..parallelism, fn(integer) ->
  randi = :rand.uniform(num_of_entries)
  # IO.puts "request #{randi}"
  response = HTTPoison.get!("http://localhost:8888/hello/#{randi}", [], [recv_timeout: 1000000])
  # response = HTTPoison.get!("http://localhost:8888/hello?name=#{randi}", [], [recv_timeout: 1000000])
  # response = HTTPoison.get!("http://localhost:8888/hi?name=#{randi}", [], [recv_timeout: 1000000])
  # response = HTTPoison.get!("http://www.google.com", [], [recv_timeout: 1000000])
  # IO.puts "response for #{randi}: #{response.body}"
end)
IO.puts "size of results: #{length results}"
end_time = :os.system_time(:millisecond)

IO.puts "total time #{end_time - start_time}ms"
