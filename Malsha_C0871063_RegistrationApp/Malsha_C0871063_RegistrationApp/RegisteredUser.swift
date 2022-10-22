//
//  RegisteredUser.swift
//  Malsha_C0871063_RegistrationApp
//
//  Created by Malsha Lambton on 2022-10-22.
//

import Foundation

struct RegisteredUser {
    var userName : String
    var password : String
    var firstName : String
    var lastName : String
    var email : String
    
    init(userName: String, password: String, firstName: String, lastName: String, email: String) {
        self.userName = userName
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}

extension RegisteredUser : CustomStringConvertible {
     var description: String {
        let a =
        """
        Username : \(userName) \n
        password : \(password)\n
        firstName : \(firstName)\n
        lastName : \(lastName)\n
        email : \(email)\n
        """
        
        return a
    }
}
