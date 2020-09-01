import UIKit
import Foundation


struct Person: Codable {
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

let me = Person(name: "Mohammed", favoriteColor: .yellow)
let encoder = JSONEncoder()
if let encodedData = try? encoder.encode(me)  {
    UserDefaults.standard.set(encodedData, forKey: "meObject")
} else {
    print("Data couldn't be encoded")
}


let dataFromUserDefault = UserDefaults.standard.data(forKey: "meObject")
let decoder = JSONDecoder()
if let decodedData = try? decoder.decode(Person.self, from: dataFromUserDefault!) {
    print(decodedData.name)
    print(decodedData.favoriteColor)
} else {
    print("Data could not be decoded")
}

