car = wins = 0
many = 100000
 
many.times do |game| 
    choice1 = rand(3)
    host_opts = [0, 1, 2] - [choice1, car]
    choice2 = [0, 1, 2] - [choice1, host_opts.first]
    wins += 1 if choice2 == [car] 
 
    progress = ((game + 1) * 100) / many
    print("\b\b\b#{progress}%")
end
 
puts "\b\b\b\b#{wins} wins in #{many} games."
puts "Success rate of #{(wins * 100) / many}%"
