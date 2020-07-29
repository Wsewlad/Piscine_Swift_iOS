import Foundation

let card1 = Card(c: Color.club, v: Value.ace)
let card2 = Card(c: Color.diamond, v: Value.king)
let card3 = Card(c: Color.club, v: Value.ace)

print("card1: \(card1)")
print("card2: \(card2)")
print("card3: \(card3)\n")

print("card1.isEqual(card2): \(card1.isEqual(card2))")
print("card1.isEqual(card3): \(card1.isEqual(card3))")
print("card2.isEqual(card2): \(card2.isEqual(card2))\n")

print("card1 == card2: \(card1 == card2)")
print("card1 == card3: \(card1 == card3)")
print("card2 == card2: \(card2 == card2)")

