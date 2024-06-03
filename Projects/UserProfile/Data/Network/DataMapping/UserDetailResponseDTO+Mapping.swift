//
//  UserDetailResponseDTO+Mapping.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import Foundation

// MARK: - Data Transfer Object
struct UserDetailDTO: Codable {
    let id: Int?
    let firstName: String?
    let lastName: String?
    let maidenName: String?
    let age: Int?
    let gender: String?
    let email: String?
    let phone: String?
    let username: String?
    let password: String?
    let birthDate: String?
    let image: String?
    let bloodGroup: String?
    let height: Double?
    let weight: Double?
    let eyeColor: String?
    let hair: UserHairDTO?
    let ip: String?
    let address: UserAddressDTO?
    let macAddress: String?
    let university: String?
    let bank: UserBankDTO?
    let company: UserCompanyDTO?
    let ein: String?
    let ssn: String?
    let userAgent: String?
    let crypto: UserCryptoDTO?
    let role: String?
}

// MARK: - Mappings to Domain
extension UserDetailDTO {
    func toDomain() -> UserDetail {
        return .init(id: id,
                     firstName: firstName,
                     lastName: lastName,
                     maidenName: maidenName,
                     age: age,
                     gender: gender,
                     email: email,
                     phone: phone,
                     username: username,
                     password: password,
                     birthDate: birthDate,
                     image: image,
                     bloodGroup: bloodGroup,
                     height: height,
                     weight: weight,
                     eyeColor: eyeColor,
                     hair: hair?.toDomain(),
                     ip: ip,
                     address: address?.toDomain(),
                     macAddress: macAddress,
                     university: university,
                     bank: bank?.toDomain(),
                     company: company?.toDomain(),
                     ein: ein,
                     ssn: ssn,
                     userAgent: userAgent,
                     crypto: crypto?.toDomain(),
                     role: role)
    }
}

// MARK: - Data Transfer Object
struct UserHairDTO: Codable {
    let color: String?
    let type: String?
}

// MARK: - Mappings to Domain
extension UserHairDTO {
    func toDomain() -> UserHair {
        return .init(color: color,
                     type: type)
    }
}

// MARK: - Data Transfer Object
struct UserCryptoDTO: Codable {
    let coin: String?
    let wallet: String?
    let network: String?
}

// MARK: - Mappings to Domain
extension UserCryptoDTO {
    func toDomain() -> UserCrypto {
        return .init(coin: coin,
                     wallet: wallet,
                     network: network)
    }
}

// MARK: - Data Transfer Object
struct UserCompanyDTO: Codable {
    let department: String?
    let name: String?
    let title: String?
    let address: UserAddressDTO?
}

// MARK: - Mappings to Domain
extension UserCompanyDTO {
    func toDomain() -> UserCompany {
        return .init(department: department,
                     name: name,
                     title: title,
                     address: address?.toDomain())
    }
}

// MARK: - Data Transfer Object
struct UserBankDTO: Codable {
    let cardExpire: String?
    let cardNumber: String?
    let cardType: String?
    let currency: String?
    let iban: String?
}

// MARK: - Mappings to Domain
extension UserBankDTO {
    func toDomain() -> UserBank {
        return .init(cardExpire: cardExpire,
                     cardNumber: cardNumber,
                     cardType: cardType,
                     currency: currency,
                     iban: iban)
    }
}

// MARK: - Data Transfer Object
struct UserAddressDTO: Codable {
    let address: String?
    let city: String?
    let state: String?
    let stateCode: String?
    let postalCode: String?
    let coordinates: UserAddressCoordinateDTO?
    let country: String?
}

// MARK: - Mappings to Domain
extension UserAddressDTO {
    func toDomain() -> UserAddress {
        return .init(address: address,
                     city: city,
                     state: state,
                     stateCode: stateCode,
                     postalCode: postalCode,
                     coordinates: coordinates?.toDomain(),
                     country: country)
    }
}

// MARK: - Data Transfer Object
struct UserAddressCoordinateDTO: Codable {
    let lat: Double?
    let lng: Double?
}

// MARK: - Mappings to Domain
extension UserAddressCoordinateDTO {
    func toDomain() -> UserAddressCoordinate {
        return .init(lat: lat,
                     lng: lng)
    }
}
