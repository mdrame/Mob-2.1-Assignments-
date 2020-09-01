import UIKit
import Foundation


struct Person {
    var name: String
    var favoriteColor: UIColor
}

extension Person {
    enum CodingKeys: String, CodingKey {
        case name
        case favoriteColor
        
    }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(name, forKey: .name)
            
            let colorData = try NSKeyedArchiver.archivedData(withRootObject: favoriteColor, requiringSecureCoding: false)
            try container.encode(colorData, forKey: .favoriteColor)
        }
        
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            name = try container.decode(String.self, forKey: .name)
            
            let colorData = try container.decode(Data.self, forKey: .favoriteColor)
            favoriteColor = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor ?? UIColor.purple
        }
        
    
}


