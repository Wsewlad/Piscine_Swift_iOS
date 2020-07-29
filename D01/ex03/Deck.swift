import Foundation

extension Array {
    mutating func shuffle() {
        var tmp: Element
        for i in 0..<count {
            let rand = Int(arc4random_uniform(UInt32(count)))
            if rand != i {
                tmp = self[i]
                self[i] = self[rand]
                self[rand] = tmp
            }
        }
    }
}

class Deck : NSObject {
    static let allSpades: [Card] = Value.allValues.map({Card(c: Color.spade, v: $0)})
    static let allDiamonds: [Card] = Value.allValues.map({Card(c: Color.diamond, v: $0)})
    static let allHearts: [Card] = Value.allValues.map({Card(c: Color.heart, v: $0)})
    static let allClubs: [Card] = Value.allValues.map({Card(c: Color.club, v: $0)})
    static let allCards: [Card] = allSpades + allDiamonds + allDiamonds + allClubs
}
