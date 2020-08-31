import UIKit


@propertyWrapper
struct UserDefaultsWrapper<Token> {
    let tokenKey: String
    let defaultValue: Token
    let userDefaults: UserDefaults = .standard
    
    var wrappedValue: Token{
        get {
            return userDefaults.object(forKey: tokenKey) as? Token ?? defaultValue
        }
        set {
            userDefaults.set(newValue, forKey: tokenKey)
        }
    }
}


