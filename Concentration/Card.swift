//
//  Card.swift
//  Concentration
//
//  Created by Essam Sleiman on 12/22/19.
//  Copyright © 2019 UC Davis. All rights reserved.
//

import Foundation

struct Card {
    // variable to see if the card is face up or down
    var isFaceUp = false
    
    // variable to see if the card has already been matched with another card or not
    var isMatched = false
    
    // variable that is used to give a unique identifier to the card
    var identifier: Int
    
    // static variable which means the variable is retains its variable across all objects of the class and is used to hold the value of the unique identifiers
    static var identifierFactory = 0
    
    // static function means the function can't be overwritten and retains its past identifierFactory value
    // this will return a unique value every time function is called
    static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    // initialization for the identifier in a constructor because it wasn't initialized in the code above so it will be initialized when the function is called by calling the function "getUniqueIdentifier"
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
