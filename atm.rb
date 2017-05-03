# Dakota Barron
# Lab work 1
# CS 440

# ATM program

def updateBalanceToFile(newBal) # writes a specified value to the balance.txt file
   balanceFile = File.open("balance.txt", "w") # open the file for writing
   balanceFile.puts(newBal) # write the new balance in the file
   balanceFile.close # close the file
end

def getBalanceFromFileAsFloat # reads the balance from balance.txt and returns it as a float
   balanceFile = File.open("balance.txt", "r") # open the file for reading
   balanceToReturn = (balanceFile.read).to_f # read the value in the file as a float
   balanceFile.close # close the file
   return balanceToReturn # return the float value
end

def clearScreen # clears the screen
  for i in (1..100)
    print "\n"
  end
end

def prompt # prompt for the user's choice
   print "D)eposit, W)ithdraw, B)alance, Q)uit: "
end

def getValidFloat # makes sure the user enters a valid float, when a float is expected
   stringInput = gets.chomp # get the user's input
   while (!isValidFloat(stringInput)) # while the user has not entered a valid float
      print "\nSorry, you must enter a valid float with max 2 decimal places\n" # tell them what is wrong
      print "Please try again: $" # ask them to try again
      stringInput = gets.chomp # get their input again, if still not valid the loop will repeat
   end

   # when they get here, out of the loop, we know their input is valid
   return stringInput.to_f # so return the valid input as a float
end

def deposit # performs a deposit
   print "Enter amount to deposit: $"  # prompt the user
   amount = getValidFloat # make sure they enter a valid float amount
   while amount <= 0 # check if amount is greater than or equal to 0
      print "\nAmount must be greater than 0\n" # if amount <= 0, tell the user what is wrong
      print "Please try again: $" # ask them for another input
      amount = getValidFloat # get the new input, if it is still invalid then the loop will repeat
   end

   # when we get here, the user will have entered a valid deposit amount

   updateBalanceToFile(getBalanceFromFileAsFloat + amount) # so calculate the new balance and write it to balance file
end

def printBalance # prints the user's current balance
   print "Your current balance is $", getBalanceFromFileAsFloat, "\n"
end

def withdraw # performs a withdraw
   print "Enter amount to withdraw: $" # prompt the user
   amount = getValidFloat # make sure they enter a valid float amount

   # goodInput is a boolean used to test whether or not their input meets the requirements
   goodInput = true # we start by assuming the input is good
   if amount <= 0 # if their amount is negative
      goodInput = false # then that is not good input
   end
   if amount > getBalanceFromFileAsFloat # if their amount is greater than the current balance
      goodInput = false # then that is not good input
   end

   while !goodInput # if the user does not enter a valid input, then repeat the process until they do
      print "\nSorry, withdraw amount must be >= 0 and <= balance\n" # tell the user what is wrong
         
      print "Please try again: $" # ask them for another input
      amount = getValidFloat # make sure they enter a valid float amount

      # goodInput is a boolean used to test whether or not their input meets the requirements
      goodInput = true # we start by assuming the input is good
      if amount <= 0 # if their amount is negative
         goodInput = false # then that is not good input
      end
      if amount > getBalanceFromFileAsFloat # if their amount is greater than the current balance
         goodInput = false # then that is not good input
      end

      # if goodInput is still false, loop will repeat until the user enters a good value
   end

   # when we get here we know that they entered a valid withdraw amount

   updateBalanceToFile(getBalanceFromFileAsFloat - amount) # so calculate the new balance and write it to the balance file
end

def isValidFloat(number) # checks whether or not a given string matches the regular expression for a float
   if (number =~ /^[0-9]*\.?[0-9]+$/) # if the string matches the regular expression for a float
      return true # then it is valid so return true
   else # it is not valid
      return false # so return false
   end
end

# program execution starts here
clearScreen # clear the screen
STARTING_BALANCE = 100.0 # constant which defines the starting balance if balance.txt does not exist 
if !File.exist?("balance.txt") # if balance.txt file does not exist
   balance = STARTING_BALANCE  # then set the starting balance to the constant's value
   updateBalanceToFile(balance) # and create a new balance.txt with the starting balance value  
else # balance.txt already exists
   balance = getBalanceFromFileAsFloat # so just read in the existing balance
end

# when execution gets here, balance now contains the correct value

prompt # prompt the user for their menu choice
choice = (gets.chomp).downcase # downcase the input in case the user enters uppercase letter

while (choice != "q") # loop until user enters q to quit
   case choice # switch based on the choice
      when "d" # deposit
         deposit
         printBalance
      when "w" # withdraw
         withdraw
         printBalance
      when "b" # balance check
         printBalance
      else # if it gets here that means they did not enter a valid choice
         # so tell them what is wrong
         print "Sorry, you must enter one of: D, W, B, Q in upper or lower case\n"
         # and then the loop will just repeat and ask them for another input
   end

   print "\nPress any key to continue..." # tell them to press any key to continue
   gets # pause until they press a key to continue
   clearScreen # clear the screen for the next prompt
   prompt # prompt them again
   choice = (gets.chomp).downcase # get the user's menu option for this time
end

# when we get here, we know the program is ending
print "ATM exited\n" # so give an exit message
