//
//  ReviewFactory.swift
//  Closr
//
//  Created by Tao on 2017-03-09.
//  Copyright © 2017 closr. All rights reserved.
//

import UIKit
import EasyPeasy

class ReviewHelper {
    
    fileprivate static let kSmallReviewFormat = "small_%@"
    fileprivate static let kRegularReviewFormat = "regular_%@"
    
    class func buildReviewView(rating: Double, scoreImage: UIImage?, halfScoreImage: UIImage?) -> (reviewView: UIView?, preferredSize: CGSize) {
        guard let scoreImage = scoreImage else {
            return (nil, .zero)
        }
        
        guard let halfScoreImage = halfScoreImage else {
            return (nil, .zero)
        }
        
        let score = max(0.0, min(rating, 5.0))
        
        let backgroundView              = UIView()
        backgroundView.backgroundColor  = UIColor.white
        
        for _ in 0..<Int(score) {
            
            let scoreImageView = UIImageView(image: scoreImage)
            
            if let previousReview = backgroundView.subviews.last {
                backgroundView.addSubview(scoreImageView)
                
                scoreImageView <- [
                    Leading(10).to(previousReview, .trailing),
                    Top()
                ]
                
            } else {
                backgroundView.addSubview(scoreImageView)
                
                scoreImageView <- [
                    Leading(),
                    Top(),
                ]
            }
        }
        
        if score - floor(score) >= 0.5 {
            let scoreImageView = UIImageView(image: halfScoreImage)
            
            if let previousReview = backgroundView.subviews.last {
                backgroundView.addSubview(scoreImageView)
                
                scoreImageView <- [
                    Leading(10).to(previousReview, .trailing),
                    Top()
                ]
                
            } else {
                backgroundView.addSubview(scoreImageView)
                
                scoreImageView <- [
                    Leading(),
                    Top(),
                ]
            }
        }
        
        if backgroundView.subviews.isEmpty {
            return (nil, .zero)
        }
        
        let height = ceil(scoreImage.size.height)
        let width  = ceil(scoreImage.size.width * CGFloat(backgroundView.subviews.count) + CGFloat(10 * (backgroundView.subviews.count - 1)))
        
        return (backgroundView, CGSize(width: width, height: height))
    }
    
    class func yelpSmallReviewImageName(rating: Double) -> String {
        
        let review = calculateReview(rating: rating)
        
        return String(format: kSmallReviewFormat, review)
    }
    
    class func yelpRegularReviewImageName(rating: Double) -> String {
        let review = calculateReview(rating: rating)
        
        return String(format: kRegularReviewFormat, review)
    }
    
    fileprivate class func calculateReview(rating: Double) -> String {
        let score = max(0.0, min(rating, 5.0))
        
        if score - floor(score) >= 0.5 {
            return String(floor(score) + 0.5)
        }
        
        return String(Int(score))
    }
}
