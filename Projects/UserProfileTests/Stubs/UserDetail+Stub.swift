//
//  UserDetail+Stub.swift
//  UserProfileTests
//
//  Created by Arvind on 31/05/24.
//

import SwiftUI
@testable import UserProfile

// MARK: - Mappings to Domain
extension UserDetailDTO {
    static func stub(id: Int? = 1,
              firstName: String? = "Emily",
              lastName: String? = "Johnson",
              maidenName: String? = "Smith",
              age: Int? = 28,
              gender: String? = "female",
              email: String? = "emily.johnson@x.dummyjson.com",
              phone: String? = "+81 965-431-3024",
              username: String? = "emilys",
              password: String? = "emilyspass",
              birthDate: String? = "1996-5-30",
              image: String? = "",
              bloodGroup: String? = "O-",
              height: Double? = 193.24,
              weight: Double? = 63.16,
              eyeColor: String? = "Green",
              hair: UserHairDTO? = UserHairDTO.stub(),
              ip: String? = "42.48.100.32",
              address: UserAddressDTO? = UserAddressDTO.stub(),
              macAddress: String? = "47:fa:41:18:ec:eb",
              university: String? = "University of Wisconsin--Madison",
              bank: UserBankDTO? = UserBankDTO.stub(),
              company: UserCompanyDTO? = UserCompanyDTO.stub(),
              ein: String? = "977-175",
              ssn: String? = "900-590-289",
              userAgent: String? = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36",
              crypto: UserCryptoDTO? = UserCryptoDTO.stub(),
              role: String? = "admin") -> Self {
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
                     hair: hair,
                     ip: ip,
                     address: address,
                     macAddress: macAddress,
                     university: university,
                     bank: bank,
                     company: company,
                     ein: ein,
                     ssn: ssn,
                     userAgent: userAgent,
                     crypto: crypto,
                     role: role)
    }
}

extension UserHairDTO {
    static func stub(color: String? = "Brown",
        type: String? = "Curly") -> Self {
        return .init(color: color,
                     type: type)
    }
}

extension UserCryptoDTO {
    static func stub(coin: String? = "Bitcoin",
              wallet: String? = "0xb9fc2fe63b2a6c003f1c324c3bfa53259162181a",
              network: String? = "Ethereum (ERC20)") -> Self {
        return .init(coin: coin,
                     wallet: wallet,
                     network: network)
    }
}

extension UserCompanyDTO {
    static func stub(department: String? = "Engineering",
                  name: String? = "Dooley, Kozey and Cronin",
                  title: String? = "Sales Manager",
                  address: UserAddressDTO? = UserAddressDTO.stub()) -> Self {
        return .init(department: department,
                     name: name,
                     title: title,
                     address: address)
    }
}

extension UserBankDTO {
    static func stub(cardExpire: String? = "03/26",
              cardNumber: String? = "9289760655481815",
              cardType: String? = "Elo",
              currency: String? = "CNY",
              iban: String? = "YPUXISOBI7TTHPK2BR3HAIXL") -> Self {
        return .init(cardExpire: cardExpire,
                     cardNumber: cardNumber,
                     cardType: cardType,
                     currency: currency,
                     iban: iban)
    }
}

extension UserAddressDTO {
    static func stub(address: String? = "626 Main Street",
              city: String? = "Phoenix",
              state: String? = "Mississippi",
              stateCode: String? = "MS",
              postalCode: String? = "29112",
              coordinates: UserAddressCoordinateDTO? = UserAddressCoordinateDTO.stub(),
              country: String? = "United States") -> Self {
        return .init(address: address,
                     city: city,
                     state: state,
                     stateCode: stateCode,
                     postalCode: postalCode,
                     coordinates: coordinates,
                     country: country)
    }
}

extension UserAddressCoordinateDTO {
    static func stub(lat: Double? = -77.16213,
                  lng: Double? = -92.084824) -> Self {
        return .init(lat: lat,
                     lng: lng)
    }
}
