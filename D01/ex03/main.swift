import Foundation

var clubs: [Card] = Deck.allSpades
var diamonds: [Card] = Deck.allDiamonds
var hearts: [Card] = Deck.allHearts
var spades: [Card] = Deck.allClubs
var cards: [Card] = Deck.allCards

print("\nBefore shuffle\n")

print("\(clubs) \n")
print("\(diamonds) \n")
print("\(hearts) \n")
print("\(spades) \n")
print("\(cards) \n")

print("\nAfter shuffle\n")

clubs.shuffle()
diamonds.shuffle()
hearts.shuffle()
spades.shuffle()
cards.shuffle()

print("\(clubs) \n")
print("\(diamonds) \n")
print("\(hearts) \n")
print("\(spades) \n")
print("\(cards) \n")


