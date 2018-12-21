//
//  ViewController.swift
//  Concentration
//
//  Created by Danni Chen on 9/27/18.
//  Copyright © 2018 Danni Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var game:Concentration!
    let theme = [0:["😇","🤬","🤢","😈","😹","🤯","😤","🤮","😷","🙄","🤔","😱"],
                 1:["🍏","🍌","🥥","🥝","🥐","🍠","🍟","🌮","🥗","🍍","🍕","🍓"],
                 2:["🐶","🐱","🐽","🙈","🐸","🐥","🦄","🦋","🦐","🐟","🦀","🦓"],
                 3:["🏝","🌙","⭐️","🌈","🌪","☀️","⛄️","❄️","🔥","🌊","💧","🌎"]]
    
    var emojiChoices = [String]()
    var emoji = Dictionary<Int,String>()
    
    var newGameButton = UIButton()
  
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "Flips:\(flipCount)"
        }
    }
    override func viewDidLoad() {
        startNewGame()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
         flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
    
        }
        else{
            print("No card found")
        }
        
    
    }
    func updateViewFromModel(){
        if (game.gameDone){
            setUpButton()
            newGameButton.isHidden = false
            flipCountLabel.backgroundColor = UIColor.clear
            flipCountLabel.text = ""
        }
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for:card), for: .normal);
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1);
            }
            else{
                button.setTitle("", for: .normal);
                button.backgroundColor = card.isMatched ? UIColor.clear: UIColor.orange
            }
        }
    }

    
    private func setUpButton(){
        
        let myAttibutes = [NSAttributedStringKey.backgroundColor:UIColor.white,
                           NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 40),
                           NSAttributedStringKey.strokeColor:UIColor.blue,
                           NSAttributedStringKey.foregroundColor:UIColor.blue]
        newGameButton.setAttributedTitle(NSAttributedString(string: "New Game", attributes: myAttibutes), for: .normal)
        self.view.addSubview(newGameButton)
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        newGameButton.bottomAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        newGameButton.leadingAnchor.constraintEqualToSystemSpacingAfter(self.view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0.3).isActive = true
        newGameButton.trailingAnchor.constraintEqualToSystemSpacingAfter(self.view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0.3).isActive = true
       newGameButton.addTarget(self, action: #selector(newGamePressed), for: UIControlEvents.touchUpInside)
        }

    @objc private func newGamePressed(_sender:UIButton){
        startNewGame()
    }
   
    private func startNewGame(){
        newGameButton.isHidden = true
        game = Concentration(numberOfPairsCards: (cardButtons.count+1)/2)
        flipCount = 0
        let random = theme.count.randomIndex
        emojiChoices = theme[random]!
        for index in cardButtons.indices{
            let button = cardButtons[index]
            button.setTitle("", for: .normal)
            button.backgroundColor = .orange
        }
        
    }
  

    
    func emoji(for card:Card)->String{
        if emoji[card.identifier] == nil ,emojiChoices.count > 0 {
            let randomIndex = emojiChoices.count.randomIndex
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }

    
}

extension Int {
    var randomIndex:Int{
        return Int(arc4random_uniform(UInt32(self)))
    }
}
