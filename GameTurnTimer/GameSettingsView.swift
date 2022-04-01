//
//  GameSettingsView.swift
//  GameTurnTimer
//
//  Created by Hunter Haufler on 1/18/21.
//

import SwiftUI

struct GameSettingsView: View {
    @State private var gameName = ""
    @State private var timerAmount = 60
    @State private var newPlayerName = ""
    @State private var playerNames = [String]()
    
    var game: Game {
        Game(timerLength: timerAmount, name: gameName, players: playerNames)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Game Info")) {
                    TextField("Game name", text: $gameName)
                
                    Stepper(value: $timerAmount, in: 5...1800, step: 5) {
                        Text("Timer per Player: \(timerAmount) (sec)")
                    }
                }
                
                Section(header: Text("Players")) {
                    List {
                        ForEach(playerNames, id: \.self) { playerName in
                            Text(playerName)
                        }
                        .onDelete { indexSet in
                            playerNames.remove(atOffsets: indexSet)
                        }
                    }

                    HStack {
                        TextField("Add Player", text: $newPlayerName)
                        
                        Divider()
                        
                        Button("Add") {
                            playerNames.append(newPlayerName)
                            newPlayerName = ""
                        }
                        .disabled(newPlayerName.isEmpty)
                    }
                }
            }
            .navigationBarTitle("Game Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Start", destination: GameTimerView(game: game))
                }
            }
        }
    }
}

struct GameSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        GameSettingsView()
    }
}
