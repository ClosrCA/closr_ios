//
// RestaurantHours.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class RestaurantHours: JSONEncodable {

    public var hoursType: String?
    public var isOpenNow: Bool?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["hours_type"] = self.hoursType
        nillableDictionary["is_open_now"] = self.isOpenNow

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
