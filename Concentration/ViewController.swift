//
//  ViewController.swift
//  Concentration
//
//  Created by Essam Sleiman on 12/17/19.
//  Copyright © 2019 UC Davis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // lazy is used as a way to only use the variable when needed to save memory
    // this creates an instance of Concentration with an arugument of the number of pairs of cards
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count+1) / 2)
    
    // creates an outlet connection between the click counter label in the View to the Controller
    @IBOutlet weak var flipCountLabel: UILabel!
    
    // every time the variable flipCount is changed, then it changes the text to match the updated flipCCount
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    // creates an outlet connection variable between all the buttons in the View to the Controller to create a variable for each button
    @IBOutlet var cardButtons: [UIButton]!
    
    // creates an outlet connection function between all the buttons in the View to the Controller to account for what happens when a Card is touched
    @IBAction func touchCard(_ sender: UIButton) {
        
        // will increment flipCount every time the button is sends the View that it is clicked
        flipCount += 1
        
        // checks if the optional is set and if yes then set cardNumber to the index of the clicked button in the array cardButtons
        if let cardNumber = cardButtons.firstIndex(of: sender){
            
            // if optional is set, then the game will run function chooseCard from the Model
            game.chooseCard(at: cardNumber)
            
            // if optional is set, then the game will update the View
            updateViewFromModel()
        } else {
            print("Chosen Card is not in Card Buttons")
        }
        
    }
    
    
    func updateViewFromModel() {
        
        // loop checking each index of array of buttons: "cardButtons"
        for index in cardButtons.indices {
            
            // sets constant button to the current index's button from the View
            let button = cardButtons[index]
            
            // sets constant card to the current index's card from the Model
            let card = game.cards[index]
            
            // if the card from the Model is face up, then set the button's title to the card's emoji and the background color to white
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
            // if the card is face down, then set the button's title to nothing and based on if it's matched or unmatched, then set the button's background color to clear or orange respectively
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["🦇","😱","🙀","😈","🎃","👻","🍭","🍬","🍎"]
    
    // variable emoji of type dictionary holding types int and string
    var emoji = [Int:String]()
    
    // function that takes in the struct Card as an argument and returns an emoji
    func emoji(for card: Card) -> String {
        
        // if the emoji doesn't have an identifier, then it will give it a randomIndex from the indices in the array emojiChoices and will set the emoji index to the index in the array emojiChoices
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
            return emoji[card.identifier] ?? "?"
    }
    
    
}

