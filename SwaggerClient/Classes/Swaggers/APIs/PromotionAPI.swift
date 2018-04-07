//
// PromotionAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class PromotionAPI: APIBase {
    /**

     - parameter authorization: (header)  
     - parameter upload: (form)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func createPromotion(authorization: String, upload: URL, completion: @escaping ((_ data: ModelErrorResponse?,_ error: Error?) -> Void)) {
        createPromotionWithRequestBuilder(authorization: authorization, upload: upload).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - POST /promotions
     - Uploads csv file of restaurant/promotion info, admin required.
     - examples: [{contentType=application/json, example={ }}]
     
     - parameter authorization: (header)  
     - parameter upload: (form)  

     - returns: RequestBuilder<ModelErrorResponse> 
     */
    open class func createPromotionWithRequestBuilder(authorization: String, upload: URL) -> RequestBuilder<ModelErrorResponse> {
        let path = "/promotions"
        let URLString = SwaggerClientAPI.basePath + path
        let formParams: [String:Any?] = [
            "upload": upload
        ]

        let nonNullParameters = APIHelper.rejectNil(formParams)
        let parameters = APIHelper.convertBoolToString(nonNullParameters)

        let url = NSURLComponents(string: URLString)

        let nillableHeaders: [String: Any?] = [
            "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<ModelErrorResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }

    /**

     - parameter id: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getPromotionById(id: String, completion: @escaping ((_ data: InlineResponse2002?,_ error: Error?) -> Void)) {
        getPromotionByIdWithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - GET /promotions/{id}
     - get a single promotion by mongo id.
     - examples: [{contentType=application/json, example={
  "promotions" : [ {
    "country" : "aeiou",
    "promotionType" : "featured",
    "amount" : 0.80082819046101150206595775671303272247314453125,
    "item" : "aeiou",
    "images" : [ "aeiou" ],
    "city" : "aeiou",
    "endDate" : "aeiou",
    "endHour" : "aeiou",
    "province" : "aeiou",
    "phone" : "aeiou",
    "street" : "aeiou",
    "startHour" : "aeiou",
    "price" : "aeiou",
    "yelpID" : "aeiou",
    "contact" : "aeiou",
    "name" : "aeiou",
    "email" : "aeiou",
    "startDate" : "aeiou"
  } ]
}}]
     
     - parameter id: (path)  

     - returns: RequestBuilder<InlineResponse2002> 
     */
    open class func getPromotionByIdWithRequestBuilder(id: String) -> RequestBuilder<InlineResponse2002> {
        var path = "/promotions/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<InlineResponse2002>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter page: (query)  
     - parameter pageSize: (query)  
     - parameter radius: (query) we are using meter as base UNIT 
     - parameter lat: (query)  (optional)
     - parameter lng: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getPromotions(page: Double, pageSize: Double, radius: Double, lat: Double? = nil, lng: Double? = nil, completion: @escaping ((_ data: InlineResponse2002?,_ error: Error?) -> Void)) {
        getPromotionsWithRequestBuilder(page: page, pageSize: pageSize, radius: radius, lat: lat, lng: lng).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     - GET /promotions
     - Get a list of nearby promotions.
     - examples: [{contentType=application/json, example={
  "promotions" : [ {
    "country" : "aeiou",
    "promotionType" : "featured",
    "amount" : 0.80082819046101150206595775671303272247314453125,
    "item" : "aeiou",
    "images" : [ "aeiou" ],
    "city" : "aeiou",
    "endDate" : "aeiou",
    "endHour" : "aeiou",
    "province" : "aeiou",
    "phone" : "aeiou",
    "street" : "aeiou",
    "startHour" : "aeiou",
    "price" : "aeiou",
    "yelpID" : "aeiou",
    "contact" : "aeiou",
    "name" : "aeiou",
    "email" : "aeiou",
    "startDate" : "aeiou"
  } ]
}}]
     
     - parameter page: (query)  
     - parameter pageSize: (query)  
     - parameter radius: (query) we are using meter as base UNIT 
     - parameter lat: (query)  (optional)
     - parameter lng: (query)  (optional)

     - returns: RequestBuilder<InlineResponse2002> 
     */
    open class func getPromotionsWithRequestBuilder(page: Double, pageSize: Double, radius: Double, lat: Double? = nil, lng: Double? = nil) -> RequestBuilder<InlineResponse2002> {
        let path = "/promotions"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "page": page, 
            "pageSize": pageSize, 
            "lat": lat, 
            "lng": lng, 
            "radius": radius
        ])
        

        let requestBuilder: RequestBuilder<InlineResponse2002>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
