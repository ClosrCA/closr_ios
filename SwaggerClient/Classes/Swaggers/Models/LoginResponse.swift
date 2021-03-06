//
// LoginResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class LoginResponse: JSONEncodable {

    public var profile: Profile?
    public var isNewUser: Bool?
    public var token: String?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["profile"] = self.profile?.encodeToJSON()
        nillableDictionary["isNewUser"] = self.isNewUser
        nillableDictionary["token"] = self.token

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
