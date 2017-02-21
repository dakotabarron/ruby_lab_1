def updateBalanceToFile(newBal)
   balanceFile = File.open("balance.txt", "w")
   balanceFile.puts(newBal)
   balanceFile.close
end

def getBalanceFromFileAsFloat
   balanceFile = File.open("balance.txt", "r")
   return (balanceFile.read).to_f
end

def clearScreen
   system("clear")
end

clearScreen
STARTING_BALANCE = 100.0 # constant which defines the starting balance if balance.txt does not exist 
if !File.exist?("balance.txt") # if file does not exist
   balance = STARTING_BALANCE  # then set balance to the constant's value
   updateBalanceToFile(balance) # and create a new balance.txt with the constant's value  
else # balance.txt exists
   balance = getBalanceFromFileAsFloat # so just read its value into balance
end

print "Balance is: ", balance, "\n"
