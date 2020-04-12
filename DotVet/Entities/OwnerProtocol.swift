import Foundation

protocol Owner: Person {
    var pets: [Pet] { get }
    var address: String? { get }
}

protocol Person {
    var name: String { get }
    var phones: [String]? { get }
}

protocol User {
    var email: String { get }
    var id: String { get }
}
