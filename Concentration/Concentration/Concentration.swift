//
//  Concentration.swift
//  Concentration
//
//  Created by Danni Chen on 9/27/18.
//  Copyright © 2018 Danni Chen. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var gameDone:Bool {
        get{
            for index in cards.indices{
                if cards[index].isMatched == false{
                    return false
                }
            }
            return true
        }
    }
    
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
        get{
            var foundIndex:Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundIndex == nil{
                        foundIndex = index
                    }
                    else{
                        return nil
                    }
                }
            }
            return foundIndex
        }
    }
    
    init(numberOfPairsCards:Int){
        for _ in 1...numberOfPairsCards{
            let card = Card()
            cards += [card,card]
        }
        shuffle()
 
    }
    private func shuffle(){
        for _ in 0..<20{
            let randomindex1 = Int(arc4random_uniform(UInt32(cards.count)))
            let randomindex2 = Int(arc4random_uniform(UInt32(cards.count)))
            cards.swapAt(randomindex1, randomindex2)
  
        }
    
        
    }
    func chooseCard(at index:Int){
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //check if cards match
                if(cards[matchIndex].identifier == cards[index].identifier){
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                }
                cards[index].isFaceUp = true
            }
            else{
                //either no cards or 2 cards are face up
        
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
}
