// Models.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

protocol JSONEncodable {
    func encodeToJSON() -> Any
}

public enum ErrorResponse : Error {
    case Error(Int, Data?, Error)
}

open class Response<T> {
    open let statusCode: Int
    open let header: [String: String]
    open let body: T?

    public init(statusCode: Int, header: [String: String], body: T?) {
        self.statusCode = statusCode
        self.header = header
        self.body = body
    }

    public convenience init(response: HTTPURLResponse, body: T?) {
        let rawHeader = response.allHeaderFields
        var header = [String:String]()
        for (key, value) in rawHeader {
            header[key as! String] = value as? String
        }
        self.init(statusCode: response.statusCode, header: header, body: body)
    }
}

private var once = Int()
class Decoders {
    static fileprivate var decoders = Dictionary<String, ((AnyObject, AnyObject?) -> AnyObject)>()

    static func addDecoder<T>(clazz: T.Type, decoder: @escaping ((AnyObject, AnyObject?) -> T)) {
        let key = "\(T.self)"
        decoders[key] = { decoder($0, $1) as AnyObject }
    }

    static func decode<T>(clazz: T.Type, discriminator: String, source: AnyObject) -> T {
        let key = discriminator;
        if let decoder = decoders[key] {
            return decoder(source, nil) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }

    static func decode<T>(clazz: [T].Type, source: AnyObject) -> [T] {
        let array = source as! [AnyObject]
        return array.map { Decoders.decode(clazz: T.self, source: $0, instance: nil) }
    }

    static func decode<T, Key: Hashable>(clazz: [Key:T].Type, source: AnyObject) -> [Key:T] {
        let sourceDictionary = source as! [Key: AnyObject]
        var dictionary = [Key:T]()
        for (key, value) in sourceDictionary {
            dictionary[key] = Decoders.decode(clazz: T.self, source: value, instance: nil)
        }
        return dictionary
    }

    static func decode<T>(clazz: T.Type, source: AnyObject, instance: AnyObject?) -> T {
        initialize()
        if T.self is Int32.Type && source is NSNumber {
            return (source as! NSNumber).int32Value as! T
        }
        if T.self is Int64.Type && source is NSNumber {
            return (source as! NSNumber).int64Value as! T
        }
        if T.self is UUID.Type && source is String {
            return UUID(uuidString: source as! String) as! T
        }
        if source is T {
            return source as! T
        }
        if T.self is Data.Type && source is String {
            return Data(base64Encoded: source as! String) as! T
        }

        let key = "\(T.self)"
        if let decoder = decoders[key] {
           return decoder(source, instance) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }

    static func decodeOptional<T>(clazz: T.Type, source: AnyObject?) -> T? {
        if source is NSNull {
            return nil
        }
        return source.map { (source: AnyObject) -> T in
            Decoders.decode(clazz: clazz, source: source, instance: nil)
        }
    }

    static func decodeOptional<T>(clazz: [T].Type, source: AnyObject?) -> [T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    static func decodeOptional<T, Key: Hashable>(clazz: [Key:T].Type, source: AnyObject?) -> [Key:T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [Key:T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    private static var __once: () = {
        let formatters = [
            "yyyy-MM-dd",
            "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ss'Z'",
            "yyyy-MM-dd'T'HH:mm:ss.SSS",
            "yyyy-MM-dd HH:mm:ss"
        ].map { (format: String) -> DateFormatter in
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = format
            return formatter
        }
        // Decoder for Date
        Decoders.addDecoder(clazz: Date.self) { (source: AnyObject, instance: AnyObject?) -> Date in
           if let sourceString = source as? String {
                for formatter in formatters {
                    if let date = formatter.date(from: sourceString) {
                        return date
                    }
                }
            }
            if let sourceInt = source as? Int64 {
                // treat as a java date
                return Date(timeIntervalSince1970: Double(sourceInt / 1000) )
            }
            fatalError("formatter failed to parse \(source)")
        } 

        // Decoder for [AuthBody]
        Decoders.addDecoder(clazz: [AuthBody].self) { (source: AnyObject, instance: AnyObject?) -> [AuthBody] in
            return Decoders.decode(clazz: [AuthBody].self, source: source)
        }
        // Decoder for AuthBody
        Decoders.addDecoder(clazz: AuthBody.self) { (source: AnyObject, instance: AnyObject?) -> AuthBody in
            let sourceDictionary = source as! [AnyHashable: Any]
            let result = instance == nil ? AuthBody() : instance as! AuthBody
            
            result.accessToken = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["access_token"] as AnyObject?)
            return result
        }


        // Decoder for [Event]
        Decoders.addDecoder(clazz: [Event].self) { (source: AnyObject, instance: AnyObject?) -> [Event] in
            return Decoders.decode(clazz: [Event].self, source: source)
        }
        // Decoder for Event
        Decoders.addDecoder(clazz: Event.self) { (source: AnyObject, instance: AnyObject?) -> Event in
            let sourceDictionary = source as! [AnyHashable: Any]
            let result = instance == nil ? Event() : instance as! Event
            
            result.id = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["id"] as AnyObject?)
            result.yelpID = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["yelpID"] as AnyObject?)
            result.title = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["title"] as AnyObject?)
            result.description = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["description"] as AnyObject?)
            result.purpose = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["purpose"] as AnyObject?)
            result.startTime = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["startTime"] as AnyObject?)
            result.minAge = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["minAge"] as AnyObject?)
            result.maxAge = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["maxAge"] as AnyObject?)
            result.capacity = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["capacity"] as AnyObject?)
            result.gender = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["gender"] as AnyObject?)
            result.attendees = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["attendees"] as AnyObject?)
            result.author = Decoders.decodeOptional(clazz: Profile.self, source: sourceDictionary["author"] as AnyObject?)
            result.hasFinished = Decoders.decodeOptional(clazz: Bool.self, source: sourceDictionary["hasFinished"] as AnyObject?)
            result.lng = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["lng"] as AnyObject?)
            result.lat = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["lat"] as AnyObject?)
            result.createdAt = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["createdAt"] as AnyObject?)
            result.updatedAt = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["updatedAt"] as AnyObject?)
            return result
        }


        // Decoder for [EventCreate]
        Decoders.addDecoder(clazz: [EventCreate].self) { (source: AnyObject, instance: AnyObject?) -> [EventCreate] in
            return Decoders.decode(clazz: [EventCreate].self, source: source)
        }
        // Decoder for EventCreate
        Decoders.addDecoder(clazz: EventCreate.self) { (source: AnyObject, instance: AnyObject?) -> EventCreate in
            let sourceDictionary = source as! [AnyHashable: Any]
            let result = instance == nil ? EventCreate() : instance as! EventCreate
            
            result.yelpID = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["yelpID"] as AnyObject?)
            result.title = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["title"] as AnyObject?)
            result.description = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["description"] as AnyObject?)
            result.purpose = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["purpose"] as AnyObject?)
            result.startTime = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["startTime"] as AnyObject?)
            result.minAge = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["minAge"] as AnyObject?)
            result.maxAge = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["maxAge"] as AnyObject?)
            result.capacity = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["capacity"] as AnyObject?)
            result.gender = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["gender"] as AnyObject?)
            result.lng = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["lng"] as AnyObject?)
            result.lat = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["lat"] as AnyObject?)
            return result
        }


        // Decoder for [LoginResponse]
        Decoders.addDecoder(clazz: [LoginResponse].self) { (source: AnyObject, instance: AnyObject?) -> [LoginResponse] in
            return Decoders.decode(clazz: [LoginResponse].self, source: source)
        }
        // Decoder for LoginResponse
        Decoders.addDecoder(clazz: LoginResponse.self) { (source: AnyObject, instance: AnyObject?) -> LoginResponse in
            let sourceDictionary = source as! [AnyHashable: Any]
            let result = instance == nil ? LoginResponse() : instance as! LoginResponse
            
            result.profile = Decoders.decodeOptional(clazz: Profile.self, source: sourceDictionary["profile"] as AnyObject?)
            result.isNewUser = Decoders.decodeOptional(clazz: Bool.self, source: sourceDictionary["isNewUser"] as AnyObject?)
            result.token = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["token"] as AnyObject?)
            return result
        }


        // Decoder for [ModelErrorResponse]
        Decoders.addDecoder(clazz: [ModelErrorResponse].self) { (source: AnyObject, instance: AnyObject?) -> [ModelErrorResponse] in
            return Decoders.decode(clazz: [ModelErrorResponse].self, source: source)
        }
        // Decoder for ModelErrorResponse
        Decoders.addDecoder(clazz: ModelErrorResponse.self) { (source: AnyObject, instance: AnyObject?) -> ModelErrorResponse in
            if let source = source as? String {
                return source
            }
            fatalError("Source \(source) is not convertible to typealias ModelErrorResponse: Maybe swagger file is insufficient")
        }


        // Decoder for [Profile]
        Decoders.addDecoder(clazz: [Profile].self) { (source: AnyObject, instance: AnyObject?) -> [Profile] in
            return Decoders.decode(clazz: [Profile].self, source: source)
        }
        // Decoder for Profile
        Decoders.addDecoder(clazz: Profile.self) { (source: AnyObject, instance: AnyObject?) -> Profile in
            let sourceDictionary = source as! [AnyHashable: Any]
            let result = instance == nil ? Profile() : instance as! Profile
            
            result.id = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["id"] as AnyObject?)
            result.facebookID = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["facebookID"] as AnyObject?)
            result.firebaseID = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["firebaseID"] as AnyObject?)
            result.firstname = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["firstname"] as AnyObject?)
            result.displayName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["displayName"] as AnyObject?)
            result.lastname = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["lastname"] as AnyObject?)
            result.gender = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["gender"] as AnyObject?)
            result.email = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["email"] as AnyObject?)
            result.birthday = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["birthday"] as AnyObject?)
            result.avatar = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["avatar"] as AnyObject?)
            result.phone = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["phone"] as AnyObject?)
            result.createdAt = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["createdAt"] as AnyObject?)
            result.updatedAt = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["updatedAt"] as AnyObject?)
            return result
        }


        // Decoder for [ProfileUpdate]
        Decoders.addDecoder(clazz: [ProfileUpdate].self) { (source: AnyObject, instance: AnyObject?) -> [ProfileUpdate] in
            return Decoders.decode(clazz: [ProfileUpdate].self, source: source)
        }
        // Decoder for ProfileUpdate
        Decoders.addDecoder(clazz: ProfileUpdate.self) { (source: AnyObject, instance: AnyObject?) -> ProfileUpdate in
            let sourceDictionary = source as! [AnyHashable: Any]
            let result = instance == nil ? ProfileUpdate() : instance as! ProfileUpdate
            
            result.displayName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["displayName"] as AnyObject?)
            result.email = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["email"] as AnyObject?)
            result.phone = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["phone"] as AnyObject?)
            result.avatar = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["avatar"] as AnyObject?)
            return result
        }
    }()

    static fileprivate func initialize() {
        _ = Decoders.__once
    }
}
