def getNumber
	print "Please enter a positive integer for which to perform the hailstone sequence: "
	userInput = gets.chomp

	while userInput !=~ /^[0-9]+$/
		print "Please enter a valid positive integer: "
		userInput = gets.chomp
	end

	return userInput.to_i
end

getNumber