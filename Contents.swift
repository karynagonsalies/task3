import UIKit
import Foundation

let inputJSON = """
{
"userData": {
"userName": "NameExample",
"userId": 12341234,
"bankAccount": {
"accountNumber": "12341234",
"bankId": "ExampleId",
"bankName": "ExampleName"
}
}
}
"""

struct Data : Codable{
    let userData: User
}

struct User: Codable{
    let userName: String
    let userId: Int
    let bankAccount: Bank
}

struct Bank : Codable{
    var accountNumber: String
    let id: String
    let bank: String
    
    enum CodingKeys: String, CodingKey{
        case accountNumber
        case id = "bankId"
        case bank = "bankName"
    }
}

// Mam pytania. czy trzeba używać EXTENSION, bo bez niego kod działa?
// Napisałam EXTENSION, bo przeczytałam dokumentacje: Encoding and Decoding Custom Types.
extension Bank {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accountNumber = try values.decode(String.self, forKey: .accountNumber)
        id = try values.decode(String.self, forKey: .id)
        bank = try values.decode(String.self, forKey: .bank)
    }
}

let JSON_DATA = inputJSON.data(using: .utf8)!
let userResult = try JSONDecoder().decode(Data.self, from: JSON_DATA)
print("userName: \(userResult.userData.userName), userId: \(userResult.userData.userId), bankAccount: \(userResult.userData.bankAccount)")

