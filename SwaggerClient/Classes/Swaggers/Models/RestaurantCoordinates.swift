//
// RestaurantCoordinates.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class RestaurantCoordinates: JSONEncodable {

    public var latitude: Double?
    public var longitude: Double?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["latitude"] = self.latitude
        nillableDictionary["longitude"] = self.longitude

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
