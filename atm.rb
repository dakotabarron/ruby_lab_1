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

def deposit
   print "Enter amount to deposit: $"
   amount = (gets.chomp).to_f
   while amount <= 0
      print "\nAmount must be greater than 0\n"
      print "Enter amount to deposit: $"
      amount = (gets.chomp).to_f
   end

   updateBalanceToFile(getBalanceFromFileAsFloat + amount)
end

def printBalance
   print "Your current balance is $", getBalanceFromFileAsFloat, "\n"
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
         print "You selected w\n"
      when "b"
         printBalance
      else
         print "invalid input\n"
   end

   prompt
   choice = (gets.chomp).downcase   
end
