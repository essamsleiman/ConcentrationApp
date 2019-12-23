//
//  Concentration.swift
//  Concentration
//
//  Created by Essam Sleiman on 12/22/19.
//  Copyright © 2019 UC Davis. All rights reserved.
//

import Foundation

class Concentration
{
    // create cards which is an array of struct Card
    // struct Card knows if the card is face up, is matched, and has an identifier to it
    var cards = [Card]()
    
    // this is an optional that will be "set" only when there is one card flipped
    // is used to keep track of how many cards are flipped and the logic
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    //
    func chooseCard(at index: Int) {
        
        // goes through the loop only if struct cards[index] has its element isMatched = false
        // this means that the card still hasn't been matched with another card
        if !cards[index].isMatched {
            
            // first sets the const matchIndex to indexOfOneAndOnlyFaceUpCard only if indexOfOneAndOnlyFaceUpCard isn't nil
            // also only goes through if statement if the flipped card's index is different than the second flipped card's index which means you clicked on a card different than the already flipped card
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                
                // checks if the two cards have the same identifier and if they do, will set the isMatched of both indices of the cards to be true
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                
                // switches the second card pressed to faceup so now two cards are faced up
                cards[index].isFaceUp = true
                
                // this will change indexOfOneAndOnlyFaceUpCard to nil because now there isn't just one card flipped up, there are two now
                indexOfOneAndOnlyFaceUpCard = nil
              
            // this else will take place if indexOfOneAndOnlyFaceUpCard is nil, which means there are either no cards are flipped up before a card is touched or there are two cards flipped up before a card is touched
            } else {
                
                //this will flip all cards down
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                
                // will flip the card touched up so now it is the only card up and because we only have one card face up, we can have indexOfOneAndOnlyFaceUpCard be equal to that index and not nil
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    //this is an init that will take in the number of pairs of cards as an argument then will create two instances of the struct Card for each card in the set and place them into the array of structs "cards" in pairs so the final result will have the array "structs" have all the cards in the set twice
    
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        shuffleCards()
    }
    
    // function that will shuffle all the cards in the "cards" array
    func shuffleCards() {
        
        var last = cards.count - 1
        while(last > 0) {
            // creates a constant "randomIndex that will hold a randomIndex in array "cards"
            let randomIndex = Int(arc4random_uniform(UInt32(last)))
            
            cards.swapAt(randomIndex, last)
            last -= 1
        }
    }
}
