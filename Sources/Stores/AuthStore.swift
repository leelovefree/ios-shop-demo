import Foundation
import Observation

@Observable
final class AuthStore {
    static let demoEmail = "demo@shop.com"
    static let demoPassword = "123456"

    var isLoggedIn = false
    var errorMessage: String?

    func login(email: String, password: String) {
        if email == Self.demoEmail && password == Self.demoPassword {
            errorMessage = nil
            isLoggedIn = true
        } else {
            errorMessage = "Invalid email or password."
        }
    }

    func logout() {
        isLoggedIn = false
        errorMessage = nil
    }
}
