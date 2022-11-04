//
//  ViewController.swift
//  CS50 Final
//
//  Created by Triana Cerda on 10/24/22.
//

import UIKit
// UIViewController is superclass.
// ViewController is a subclass of UIViewController and will conform to protocols
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var timeRemaining: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCard: IndexPath?

    var timer:Timer?
    
    // 10 seconds
    var milliseconds:Float = 45 * 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardArray = model.getCards()
        
        // when action is made collectionView will access info via delegate
        collectionView.delegate = self
        
        // when the colleciton view needs data it will use this dataSource
        collectionView.dataSource = self
        
        // assigned to miliseconds and will each time
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        
        // allow the time to continute even if the user is scrolling
        RunLoop.main.add(timer!, forMode: .common)
        
        }
    
    override func viewDidAppear(_ animated: Bool) {
        
        SoundManager.playSound(.shuffle)
        print("******played shuffle")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Timer Methods
    
    @objc func timerElapsed() {
        
        // decrements by 1
        milliseconds -= 1
        
        // convert to seconds
        // .2f formats to 2 decimal places and dividing the milliseconds will convert seconds
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        // set label to the seconds remaining
        timeRemaining.text = "\(seconds)"
        
        // stop timer when it reaches 0
        if milliseconds <= 0 {
            
            // stop time iwth invalidate and requests the removal on the loop-- stopping at less than or equal to zero
            timer?.invalidate()
            
            // notify user that the timer stoped at 0 with red font
            timeRemaining.textColor = .red
            
            checkGameEnded()
        }
        
    }
    
    // MARK: - UICollectionView Protocol Methods
    
    // this is will determine how many cells/cards to have
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count
        
    }
    
    // this is display new data
    // similar to a 2d array
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // this is the reuseable cell made
        // get a CCVcell obj
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell" , for: indexPath) as! CardCollectionViewCell

        // assigning whatever card index in that cardArray to card
        let card = cardArray[indexPath.row]
        
        // setCard accepets card (in this case, random card)
        cell.setCard(card)

        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // check if time is left
        if milliseconds <= 0 {
            return
        }
        
        // Get cell that user selected
        let cardCell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        // Get card that user selected
        let card = cardArray[indexPath.row]
        
        //if card isflipped == false, flip to front
        if card.isflipped == false && card.isMatched == false{
            // Flip from back to front
            cardCell.flip()
            
            // play flip sound
            SoundManager.playSound(.flip)
            print("!!! played flip")
            
            // status change
            card.isflipped = true
            
            // check if it's the first or second card that is flipped
            if firstFlippedCard == nil {
                
                // assign firstFlipped to the card in teh array
                firstFlippedCard = indexPath
            }
            else {
                // second card being flipped-- matched
                checkForMatch(indexPath)
                // TODO: matching logic
            }
        }
        else {
        
            
        }

    } // end of didSelect... method
    
    // MARK: ~ game logic methods
    
    func checkForMatch(_ secondFlippedCard: IndexPath) {
        
        // get the cells for the two cards picked
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCard!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCard) as? CardCollectionViewCell
        
        // get the cards for the two cards picked
        let cardOne = cardArray[firstFlippedCard!.row]
        let cardTwo = cardArray[secondFlippedCard.row]
        
        // compare the two cards to see if they are a match
        if cardOne.cardName == cardTwo.cardName {
            
            // match
            // play match sound
            SoundManager.playSound(.match)
            
            // set both statuses of cards
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            // remove cards from collection cell
            // if there is a card then it will removeMatch, if nil-- won't fire (guards from crashes)
            cardOneCell?.removeMatch()
            cardTwoCell?.removeMatch()
            
            // check if any cards are left over and unmatched
            checkGameEnded()
            
        }
        else {
            
            // no match
            // play nomatch sound
            SoundManager.playSound(.nomatch)
            
            // set both statuses of cards
            cardOne.isflipped = false
            cardTwo.isflipped = false
            
            // flip both cards back to continue
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        
        // collectView to reload the cell of first card IF = nil
        
        if cardOneCell == nil {
            collectionView.reloadItems(at: [firstFlippedCard!])
        }
        
        // reset cards back to nil to let user start over and continute for matches
        firstFlippedCard = nil
    }
    
    func checkGameEnded() {
        
        // check is cards are unmatched
        var winner = true
        
        // if not -- user has won, stop timer
        for card in cardArray {
            
            if card.isMatched == false {
                winner = false
                break
            }
        }
        
        var title = ""
        var message = ""
        
        // if unmatched -- notify user that game is over and no time left
        if winner == true {
            
            if milliseconds > 0 {
                timer?.invalidate()
                
            }
            
            // play winner sound
            SoundManager.playSound(.win)
            
            // show won/lost message
            title = "Congrats!!"
            message = "You're a WINNER!!!"
        
        }
        else {
         
            if milliseconds > 0 {
                return
            }
            
            //play lost sound
            SoundManager.playSound(.lost)
            
            title = "Oh no, game over."
            message = "You have lost"
            
        }
        
        showAlert(title, message)
    
        
    }
    
    func showAlert(_ title:String, _ message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }

} // end of viewController

