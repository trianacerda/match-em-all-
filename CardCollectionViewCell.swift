//
//  CardCollectionViewCell.swift
//  CS50 Final
//
//  Created by Triana Cerda on 10/28/22.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontView: UIImageView!
    
    @IBOutlet weak var backView: UIImageView!
    
    // Keep track of card that is displayed
    // intitally it's nil -- that is why we ad ded optional chaining
    var card:Card?
    
    func setCard(_ card:Card) {
        // self refers to the class == CardCollectionViewCell && self.card refers to the class.property (line 18)
        // this is the card that gets passed in and assigned to self.card
        self.card = card
        
        // check to make sure cells aren't reused when matched
        if card.isMatched == true {
            
            // converts opacity to zero
            backView.alpha = 0
            frontView.alpha = 0
            
            // just returns the function so nothing else runs
            return
        }
        else {
            
            // else if card is NOT matched then ensure they are still visible
            backView.alpha = 1
            frontView.alpha = 1
        }
        
        // assigning the frontView (created from nib) to the cardName that is passed in. UIImage accepts a String
        frontView.image = UIImage(named: card.cardName)
        
        // determine if the card is flipped or not
        if card.isflipped == true {
            // frontView on top
            UIView.transition(from: backView, to: frontView, duration: 0, options: [.transitionFlipFromTop, .showHideTransitionViews])
        }
        else {
            //backView on top
            UIView.transition(from: frontView, to: backView, duration: 0, options: [.transitionFlipFromBottom, .showHideTransitionViews])
        }
    }
    
    // flips back(what the user sees) -> front
    func flip() {
        
        UIView.transition(from: backView, to: frontView, duration: 0.3, options: [.transitionFlipFromTop, .showHideTransitionViews], completion: nil)
    }
    
    // flips front -> back
    func flipBack() {
        
        // this waits for the current time plus 5 seconds
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            
            // needed to put self in from of the properties to be more specific on where you're referencing
            UIView.transition(from: self.frontView, to: self.backView, duration: 0.3, options: [.transitionFlipFromBottom, .showHideTransitionViews], completion: nil)
        }
    }
    
    func removeMatch() {
        
        // removes the match
        backView.alpha = 0
        
        // TODO: animate it removing the cards when matched
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            //alpha is opacity-- makes cards invisible
            self.frontView.alpha = 0
        }, completion: nil)
    
       
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10.0
    }
}
