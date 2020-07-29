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
	
	var cards: [Card] = Deck.allCards
    var disards: [Card] = []
    var outs: [Card] = []
    
    init (cardsMixed: Bool) {
        if cardsMixed {
            self.cards.shuffle()
        }
    }
    
    override var description: String {
        return cards.description
    }
    
    func draw() -> Card? {
        if let firstCard = cards.remove(at: 0) as Card? {
            outs.append(firstCard)
            return firstCard
        }
    }
    
    func fold(c: Card) {
        if outs.contains(c) {
            print(c)
            disards.append(outs.remove(at: outs.firstIndex(of: c)!))
        }
    }
}
