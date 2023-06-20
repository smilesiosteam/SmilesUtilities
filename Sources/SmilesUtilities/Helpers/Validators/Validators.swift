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
    var errorMessage: String { get set }
    func validated(_ value: String) throws
}

public enum ValidatorType {
    case email(errorMessage: String)
    case phone(errorMessage: String)
    case requiredField(errorMessage: String)
}

enum ValidatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email(let msg): return EmailValidator(msg)
        case .phone(let msg): return PhoneNumberValidator(msg)
        case .requiredField(let msg): return RequiredFieldValidator(msg)
        }
    }
}

struct RequiredFieldValidator: ValidatorConvertible {
    
    var errorMessage: String
    
    init(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    func validated(_ value: String) throws {
        guard !value.isEmpty else {
            throw ValidationError(errorMessage)
        }
    }
}

struct EmailValidator: ValidatorConvertible {
    
    var errorMessage: String
    
    init(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    func validated(_ value: String) throws {
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError(errorMessage)
            }
        } catch {
            throw ValidationError(errorMessage)
        }
    }
}

struct PhoneNumberValidator: ValidatorConvertible {
    
    var errorMessage: String
    
    init(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    func validated(_ value: String) throws {
        do {
            if try NSRegularExpression(pattern: "^((\\+)|(00))[0-9]{8,16}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError(errorMessage)
            }
        } catch {
            throw ValidationError(errorMessage)
        }
    }
    
}

extension String {
    
    func validatedText(validationType: ValidatorType) throws {
        let validator = ValidatorFactory.validatorFor(type: validationType)
        return try validator.validated(self)
    }
    
}
