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
        let reviewImageName = ReviewHelper.yelpSmallReviewImageName(rating: 0)
        
        XCTAssertEqual(reviewImageName, "small_0")
    }
    
    func testSmallNegativeReview() {
        let reviewImageName = ReviewHelper.yelpSmallReviewImageName(rating: -4)
        
        XCTAssertEqual(reviewImageName, "small_0")
    }
    
    func testSmallGreaterNumberReview() {
        let reviewImageName = ReviewHelper.yelpSmallReviewImageName(rating: 123.4)
        
        XCTAssertEqual(reviewImageName, "small_5")
    }
    
    func testSmallFloorReview() {
        let reviewImageName = ReviewHelper.yelpSmallReviewImageName(rating: 3.2)
        
        XCTAssertEqual(reviewImageName, "small_3")
    }
    
    func testSmallHalfStarReview() {
        let reviewImageName = ReviewHelper.yelpSmallReviewImageName(rating: 4.8)
        
        XCTAssertEqual(reviewImageName, "small_4.5")
    }
    
    func testRegularZeroReview() {
        let reviewImageName = ReviewHelper.yelpRegularReviewImageName(rating: 0)
        
        XCTAssertEqual(reviewImageName, "regular_0")
    }
    
    func testRegularNegativeReview() {
        let reviewImageName = ReviewHelper.yelpRegularReviewImageName(rating: -4)
        
        XCTAssertEqual(reviewImageName, "regular_0")
    }
    
    func testRegularGreaterNumberReview() {
        let reviewImageName = ReviewHelper.yelpRegularReviewImageName(rating: 123.4)
        
        XCTAssertEqual(reviewImageName, "regular_5")
    }
    
    func testRegularFloorReview() {
        let reviewImageName = ReviewHelper.yelpRegularReviewImageName(rating: 3.2)
        
        XCTAssertEqual(reviewImageName, "regular_3")
    }
    
    func testRegularHalfStarReview() {
        let reviewImageName = ReviewHelper.yelpRegularReviewImageName(rating: 4.8)
        
        XCTAssertEqual(reviewImageName, "regular_4.5")
    }
}
