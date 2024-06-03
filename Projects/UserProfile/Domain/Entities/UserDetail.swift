//
//  UserDetail.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import Foundation

struct UserDetail: Codable {
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
    let hair: UserHair?
    let ip: String?
    let address: UserAddress?
    let macAddress: String?
    let university: String?
    let bank: UserBank?
    let company: UserCompany?
    let ein: String?
    let ssn: String?
    let userAgent: String?
    let crypto: UserCrypto?
    let role: String?
}

struct UserHair: Codable {
    let color: String?
    let type: String?
}

struct UserCrypto: Codable {
    let coin: String?
    let wallet: String?
    let network: String?
}

struct UserCompany: Codable {
    let department: String?
    let name: String?
    let title: String?
    let address: UserAddress?
}

struct UserBank: Codable {
    let cardExpire: String?
    let cardNumber: String?
    let cardType: String?
    let currency: String?
    let iban: String?
}

struct UserAddress: Codable {
    let address: String?
    let city: String?
    let state: String?
    let stateCode: String?
    let postalCode: String?
    let coordinates: UserAddressCoordinate?
    let country: String?
}

struct UserAddressCoordinate: Codable {
    let lat: Double?
    let lng: Double?
}
