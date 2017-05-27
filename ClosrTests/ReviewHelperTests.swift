//
//  ReviewHelperTests.swift
//  Closr
//
//  Created by ZHITAO TIAN on 2017-05-17.
//  Copyright © 2017 closr. All rights reserved.
//

import XCTest
@testable import Closr

class ReviewHelperTests: XCTestCase {
    
    func testSmallZeroReview() {
        let review = ReviewHelper.yelpSmallReviewImageName(rating: 0)
        
        XCTAssertEqual(review, "small_0")
    }
    
    func testSmallNegativeReview() {
        let review = ReviewHelper.yelpSmallReviewImageName(rating: -4)
        
        XCTAssertEqual(review, "small_0")
    }
    
    func testSmallGreaterNumberReview() {
        let review = ReviewHelper.yelpSmallReviewImageName(rating: 123.4)
        
        XCTAssertEqual(review, "small_5")
    }
    
    func testSmallFloorReview() {
        let review = ReviewHelper.yelpSmallReviewImageName(rating: 3.2)
        
        XCTAssertEqual(review, "small_3")
    }
    
    func testSmallHalfStarReview() {
        let review = ReviewHelper.yelpSmallReviewImageName(rating: 4.8)
        
        XCTAssertEqual(review, "small_4.5")
    }
    
    func testRegularZeroReview() {
        let review = ReviewHelper.yelpRegularReviewImageName(rating: 0)
        
        XCTAssertEqual(review, "regular_0")
    }
    
    func testRegularNegativeReview() {
        let review = ReviewHelper.yelpRegularReviewImageName(rating: -4)
        
        XCTAssertEqual(review, "regular_0")
    }
    
    func testRegularGreaterNumberReview() {
        let review = ReviewHelper.yelpRegularReviewImageName(rating: 123.4)
        
        XCTAssertEqual(review, "regular_5")
    }
    
    func testRegularFloorReview() {
        let review = ReviewHelper.yelpRegularReviewImageName(rating: 3.2)
        
        XCTAssertEqual(review, "regular_3")
    }
    
    func testRegularHalfStarReview() {
        let review = ReviewHelper.yelpRegularReviewImageName(rating: 4.8)
        
        XCTAssertEqual(review, "regular_4.5")
    }
}
