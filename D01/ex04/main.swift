import Foundation

// let newDeck = Deck(cardsMixed: true)
let newDeck = Deck(cardsMixed: false)
print("\(newDeck)\n")
print("draw -> \(newDeck.draw()!)")
print("\(newDeck)\n")
print("-------\n outs \(newDeck.outs)")

newDeck.fold(c: Card(c: Color.spade, v: Value.ace))

print("-------\n outs \(newDeck.outs)")
print("-------\n disards \(newDeck.disards)")
