//
// EventUpdate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class EventUpdate: JSONEncodable {

    public var title: String?
    public var description: String?
    public var purpose: String?
    public var minAge: Double?
    public var maxAge: Double?
    /** user current location */
    public var lat: Double?
    /** user current location */
    public var lng: Double?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["title"] = self.title
        nillableDictionary["description"] = self.description
        nillableDictionary["purpose"] = self.purpose
        nillableDictionary["minAge"] = self.minAge
        nillableDictionary["maxAge"] = self.maxAge
        nillableDictionary["lat"] = self.lat
        nillableDictionary["lng"] = self.lng

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
