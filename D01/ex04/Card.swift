import Foundation

class Card : NSObject {
    let color: Color
    let value: Value
    
    init (c: Color, v: Value) {
        self.color = c
        self.value = v
    }
    
    override var description: String {
        return "Color: \(self.color.rawValue), Value: \(self.value.rawValue)"
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let obj = object as? Card {
            return self.color == obj.color && self.value == obj.value
        }
        return false
    }
    
    static func ==(left: Card, right: Card) -> Bool {
        return left.color == right.color && left.value == right.value
    }
}
