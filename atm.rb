def updateBalanceToFile(newBal)
   balanceFile = File.open("balance.txt", "w")
   balanceFile.puts(newBal)
   balanceFile.close
end

def getBalanceFromFileAsFloat
   balanceFile = File.open("balance.txt", "r")
   balanceToReturn = (balanceFile.read).to_f
   balanceFile.close
   return balanceToReturn
end

def clearScreen
   system("clear") # this is changed depending on the intended operating system
end

def prompt
   print "D)eposit, W)ithdraw, B)alance, Q)uit: "
end

def getValidFloat
   stringInput = gets.chomp
   while (!isValidFloat(stringInput))
      print "\nSorry, you must enter a valid float with max 2 decimal places\n"
      print "Please try again: $"
      stringInput = gets.chomp
   end

   return stringInput.to_f
end

def deposit
   print "Enter amount to deposit: $"
   amount = getValidFloat
   while amount <= 0
      print "\nAmount must be greater than 0\n"
      print "Please try again: $"
      amount = getValidFloat
   end

   updateBalanceToFile(getBalanceFromFileAsFloat + amount)
end

def printBalance
   print "Your current balance is $", getBalanceFromFileAsFloat, "\n"
end

def withdraw
   print "Enter amount to withdraw: $"
   amount = getValidFloat
   goodInput = true
   if amount <= 0
      goodInput = false
   end
   if amount > getBalanceFromFileAsFloat
      goodInput = false
   end

   while !goodInput
      print "\nSorry, withdraw amount must be >= 0 and <= balance\n"
         
      print "Please try again: $"
      amount = getValidFloat
      goodInput = true
      if amount <= 0
         goodInput = false
      end
      if amount > getBalanceFromFileAsFloat
         goodInput = false
      end
   end

   updateBalanceToFile(getBalanceFromFileAsFloat - amount)
end

def isValidFloat(number)
   if (number =~ /^[0-9]+\.{0,1}[0-9]{1,2}$/)
      return true
   else
      return false
   end
end

clearScreen
STARTING_BALANCE = 100.0 # constant which defines the starting balance if balance.txt does not exist 
if !File.exist?("balance.txt") # if file does not exist
   balance = STARTING_BALANCE  # then set balance to the constant's value
   updateBalanceToFile(balance) # and create a new balance.txt with the constant's value  
else # balance.txt exists
   balance = getBalanceFromFileAsFloat # so just read its value into balance
end

prompt
choice = (gets.chomp).downcase

while (choice != "q")
   case choice
      when "d" 
         deposit
         printBalance
      when "w"
         withdraw
         printBalance
      when "b"
         printBalance
      else
         print "Sorry, you must enter one of: D, W, B, Q in upper or lower case\n"
   end

   print "\nPress any key to continue..."
   gets
   clearScreen
   prompt
   choice = (gets.chomp).downcase   
end

print "ATM exited\n"
