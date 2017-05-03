# Dakota Barron
# Lab work 1
# CS 440

# program to perform the hailstone sequence

def getNumber # makes sure that the user enters a valid integer
	print "Please enter a positive integer for which to perform the hailstone sequence: "
	userInput = gets.chomp # get input from the user

	while !(userInput =~ /^[0-9]+$/) # if the user's input does not match the regular expression for a valid integer
		print "Please enter a valid positive integer: " # then prompt them for a valid integer
		userInput = gets.chomp # get their input again, if it is still not valid, then the loop repeats
	end

	return userInput.to_i # if it gets here after the while loop we know their input is valid, so return it as an int
end

def hailstone(sequenceCounter, lineCounter, number) # performs the hailstone sequence
	# sequnceCounter = how many numbers have been printed so far
	# lineCounter = number of integers printed on the current line
	# number = the current integer to process

	print number, " " # print the current number
	sequenceCounter += 1 # increment the sequence counter
	lineCounter += 1 # increment the line counter

	if lineCounter == 10 # check if 10 numbers have been printed on the current line
		print "\n" # if so, then go to the next line
		lineCounter = 0 # and set lineCounter back to 0
	end

	if (number == 1) # check for the base case
		if lineCounter != 10 # if this is not the 10th number on the current line then we will have to manually output a newline
			print "\n" # output a newline because we are done (1 has been reached)
		end

		print "This sequence had ", sequenceCounter, " items.\n" # tell how many numbers were in the sequence

		return # we are done so now we return
	end

	# if we get here we know that 1 has not yet been reached
	# so we increment according to the hailstone sequence

	if number % 2 == 0 # for even numbers
		number = number / 2 # halve the number
	else # for odd numbers
		number *= 3 # times by three
		number += 1 # then add 1
	end

	hailstone(sequenceCounter, lineCounter, number) # recursively call hailstone with the updated values
end

def clearScreen
  for i in (1..100)
    print "\n"
  end
end

# program execution begins here
clearScreen
number = getNumber # get the number from the user
hailstone(0, 0, number) # perform the hailstone sequence
