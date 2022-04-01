//
//  Game.swift
//  GameTurnTimer
//
//  Created by Hunter Haufler on 1/18/21.
//

import Foundation

struct Game {
    let timerLength: Int
    let name: String
    let players: [String]
    
    static let example = Game(timerLength: 120, name: "Test Game", players: ["Player 1", "Player 2", "Player 3"])
}

