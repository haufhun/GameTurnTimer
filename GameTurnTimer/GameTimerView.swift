//
//  GameTimerView.swift
//  GameTurnTimer
//
//  Created by Hunter Haufler on 1/18/21.
//

import SwiftUI

struct PurpleButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .frame(width: 200, height: 100)
            .background(Color.purple)
            .clipShape(Capsule())
            .foregroundColor(.primary)
            .padding()
    }
}

extension View {
    func purpleButton() -> some View {
        self.modifier(PurpleButton())
    }
}

struct GameTimerView: View {
    let game: Game
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var timeRemaining = -1
    @State private var currentPlayer = 0
    @State private var isPaused = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(game.players[currentPlayer])
                .font(.custom("PingFangTC-Semibold", size: 72))

            Spacer()
            
            Text("\(timeRemaining)")
                .font(.custom("PingFangTC-Semibold", size: 72))
            
            Spacer()
            Spacer()
            
            Button {
                isPaused.toggle()
            } label: {
                Text("\(isPaused ? "Play" : "Pause")")
                    .purpleButton()
            }
            
            Button(action: nextPlayer) {
                Text("Next Player")
                    .purpleButton()
            }
        }
        .onAppear(perform: setUp)
        .onReceive(timer) { _ in
            advanceTimer()
        }
        .navigationBarTitle(Text(game.name), displayMode: .inline)
    }
    
    func setUp() {
        timeRemaining = game.timerLength
    }
    
    func advanceTimer() {
        if isPaused == false && self.timeRemaining > 0 {
            self.timeRemaining -= 1
        }
    }
    
    func nextPlayer() {
        if currentPlayer < game.players.count - 1 {
            currentPlayer += 1
        } else {
            currentPlayer = 0
        }
        
        timeRemaining = game.timerLength
        isPaused = false
    }
}

struct GameTimerView_Previews: PreviewProvider {
    static var previews: some View {
        GameTimerView(game: Game.example)
    }
}
