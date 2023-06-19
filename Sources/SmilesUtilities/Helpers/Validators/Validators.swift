//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 19/06/2023.
//

import Foundation
import SmilesLanguageManager

class ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws
}

public enum ValidatorType {
    case email
    case password
    case name(isFirstName: Bool?)
    case phone
    case URL
    case requiredField(field: String)
    case selectionField(field: String)
    case weight
    case ssn
    case customError(message: String)
}

enum ValidatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .password: return PasswordValidator()
        case .name(let isFirstName): return NameValidator(isFirstName)
        case .phone: return PhoneNumberValidator()
        case .URL: return URLValidator()
        case .requiredField(let fieldName): return RequiredFieldValidator(fieldName)
        case .selectionField(let fieldName): return SelectionValidator(fieldName)
        case .weight: return WeightValidator()
        case .ssn: return SSNValidator()
        case .customError(let msg): return CustomErrorValidator(msg)
            
        }
    }
}

struct CustomErrorValidator: ValidatorConvertible {
    private let message: String
    
    init(_ msg: String) {
        message = msg
    }
    
    func validated(_ value: String) throws {
        guard !value.isEmpty else {
            throw ValidationError(message)
        }
    }
}

struct RequiredFieldValidator: ValidatorConvertible {
    private let fieldName: String
    
    init(_ field: String) {
        fieldName = field
    }
    
    func validated(_ value: String) throws {
        guard !value.isEmpty else {
            throw ValidationError(fieldName + " is required")
        }
    }
}

struct NameValidator: ValidatorConvertible {
    
    private let isFirstName: Bool?
    
    init(_ isFirstName: Bool?) {
        self.isFirstName = isFirstName
    }
    
    func validated(_ value: String) throws {
        var name = "Full"
        if let isFirstName {
            name = isFirstName ? "First" : "Last"
        }
        guard value.count >= 3 else {
            throw ValidationError(name + " Name must contain at least three characters")
        }
        guard value.count < 19 else {
            throw ValidationError(name + " Name shoudn't contain more than 18 characters")
        }
    }
    
}

struct PasswordValidator: ValidatorConvertible {
    func validated(_ value: String) throws {
        guard value != "" else {throw ValidationError("Password is Required")}
        guard value.count >= 6 else { throw ValidationError("Password must have at least 6 characters") }
        
        do {
            if try NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Password must be more than 6 characters, with at least one character and one numeric character")
            }
        } catch {
            throw ValidationError("Password must be more than 6 characters, with at least one character and one numeric character")
        }
    }
}

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) throws {
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid e-mail Address")
            }
        } catch {
            throw ValidationError("Invalid e-mail Address")
        }
    }
}

struct URLValidator: ValidatorConvertible {
    func validated(_ value: String) throws {
        do {
            if try NSRegularExpression(pattern: "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid URL")
            }
        } catch {
            throw ValidationError("Invalid URL")
        }
    }
}

struct PhoneNumberValidator: ValidatorConvertible {
    
    func validated(_ value: String) throws {
        do {
            let plainPhoneNumber = getPlainPhoneNumber(text: value)
            if try NSRegularExpression(pattern: "^\\s*\\+?\\s*([0-9][\\s-]*){10,}$", options: .caseInsensitive).firstMatch(in: plainPhoneNumber, options: [], range: NSRange(location: 0, length: plainPhoneNumber.count)) == nil {
                throw ValidationError("Invalid phone number")
            }
        } catch {
            throw ValidationError("Invalid phone number")
        }
    }
    
    private func getPlainPhoneNumber(text: String) -> String {
        
        var value = ""
        value = text.replacingOccurrences(of: "(", with: "")
        value = value.replacingOccurrences(of: ")", with: "")
        value = value.replacingOccurrences(of: " ", with: "")
        value = value.replacingOccurrences(of: "-", with: "")
        return value
        
    }
    
}

struct WeightValidator: ValidatorConvertible {
    
    func validated(_ value: String) throws {
        do {
            if try NSRegularExpression(pattern: "^[0-9]*$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid patient weight")
            }
        } catch {
            throw ValidationError("Invalid patient weight")
        }
    }
    
}

struct SSNValidator: ValidatorConvertible {
    
    func validated(_ value: String) throws {
        do {
            if try NSRegularExpression(pattern: "^(?!(000|666|9))\\d{3}-(?!00)\\d{2}-(?!0000)\\d{4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid SSN")
            }
        } catch {
            throw ValidationError("Invalid SSN")
        }
    }
    
}

struct SelectionValidator: ValidatorConvertible {
    private let fieldName: String
    
    init(_ field: String) {
        fieldName = field
    }
    
    func validated(_ value: String) throws {
        guard !value.isEmpty else {
            throw ValidationError("Please select \(fieldName)")
        }
    }
}

extension String {
    
    func validatedText(validationType: ValidatorType) throws {
        let validator = ValidatorFactory.validatorFor(type: validationType)
        return try validator.validated(self)
    }
    
}
