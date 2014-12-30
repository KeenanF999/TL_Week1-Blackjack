
puts "TreeLeaf Blackjack!"

#Setup the deck
suits = ['H', 'D', 'S', 'C']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'K', 'Q', 'J', 'A']
deck = suits.product(cards)

#Shuffle the deck
deck.shuffle!

#Deal Player then Dealer two random cards
player = []
dealer = []

player << deck.pop
dealer << deck.pop
player << deck.pop
dealer << deck.pop

def calculate_total(cards)
# [['H', '4'], ['D', 'Q']]
  arr = cards.map{|e| e[1] }

  total = 0
  arr.each do |value|
    if value == "A"
      total += 11
    elsif value.to_i == 0
      total += 10
    else
      total += value.to_i
    end
  end

#Adjust for Aces
arr.select{|e| e == "A"}.count.times do
  if total > 21
    total -= 10
  end
end

  return total
end

#calculate total of cards
playertotal = calculate_total(player)
dealertotal = calculate_total(dealer)

#announce card values
puts "Player has: #{player[0]} and #{player[1]}, for a total of #{playertotal}"
puts "Dealer has: #{dealer[0]} and #{dealer[1]}, for a total of #{dealertotal}"
puts ""


#Ask Player, "Do you want to 'Hit' or 'Stay'?"
if playertotal == 21
  puts "Winner-Winner-Chicken-Dinner! You hit Blackjack!!"
  exit
end

while playertotal < 21
  puts "What would you like to do: 1) Hit 2) Stay"
  hit_or_stay = gets.chomp
  if !['1', '2'].include?(hit_or_stay)
    puts "Error: you must enter 1 or 2"
    next
  end

  if hit_or_stay == "2"
    puts "You chose to stay"
    break
  end

#If Player Hits then deal random card
  new_card = deck.pop
  puts "Dealing card to player: #{new_card}"
  player << new_card
  playertotal = calculate_total(player)
  puts "You new total is now: #{playertotal}"

  if playertotal == 21
    puts "Winner-Winner-Chicken-Dinner! You hit Blackjack!!"
    exit
  elsif playertotal > 21
    puts "Awww, busted! You lose. Dealer Wins."
    exit
  end
end

#Dealer
#If card value != 21 then select card
#Or if card value is >= 17 and <= 21 than stay
#Calculate card value
if dealertotal == 21
  puts "Dealer has 21! House Wins!"
  exit
end

while dealertotal < 17
  new_card = deck.pop
  puts "Dealer gets hits: #{new_card}"
  dealer << new_card
  dealertotal = calculate_total(dealer)
  puts "The dealer now has #{dealertotal}"

  if dealertotal == 21
    puts "Blackjack!! House wins! You lose."
    exit
  elsif dealertotal > 21
    puts "Dealer bust! You Win!"
    exit
  end
end

#If either totals 21 then game ends
puts "Dealer's cards: "
dealer.each do |card|
  puts "=> #{card}"
end

puts "Your cards: "
player.each do |card|
  puts "=> #{card}"
end

#Anounce winner
if dealertotal > playertotal
  puts "Blackjack!! House wins! You lose."
elsif dealertotal < playertotal
  puts "Winner-Winner-Chicken-Dinner! You win!!"
else
  puts "It's a tie."
end

exit
