//
//  ContentView.swift
//  MICHAELMCGINNIS-RockPaperScissors
//
//  Created by Michael Mcginnis on 2/9/22.
//
//I used GuessTheFlag as a reference
import SwiftUI

struct ContentView: View {
    @State private var moves = ["🪨", "🧻", "✂️"]
    var winningMoves = ["🧻", "✂️", "🪨"]
    //Whether the user should win or lose
    @State private var winlose = true
    @State private var questionCounter = 0
    //move the app makes
    @State private var appMove = Int.random(in: 0...2)
    //score handling
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var showingScore = false
    @State private var showingEndScore = false
    //used to determine the correct answer based on the appMove
    func correctAnswer(_ number: Int) -> String{
        //If user should win
        if winlose == true{
            switch moves[number]{
            case moves[0]:
                return winningMoves[0]
            case moves[1]:
                return winningMoves[1]
            case moves[2]:
                return winningMoves[2]
            default:
                return "Whoops"
            }
        }
        //if user should lose
        else{
            switch moves[number]{
            case moves[0]:
                return winningMoves[1]
            case moves[1]:
                return winningMoves[2]
            case moves[2]:
                return winningMoves[0]
            default:
                return "Whoops"
            }
        }
    }
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.9, green: 0.4, blue: 0.6), location: 0.9),
                .init(color: Color(red: 0.0, green: 0.15, blue: 0.6), location: 0.3),
            ], center: .top, startRadius: 300, endRadius: 500)
                .ignoresSafeArea()
        VStack{
                Text("Rock Paper Scissors").font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
            VStack{
                Spacer()
                Text("Game chose: \(moves[appMove])").font(.largeTitle)
                Spacer()
                if(winlose == false){
                    Text("You should: Lose").font(.title)
                }else{
                    Text("You should: Win").font(.title)
                }
            }
            Spacer()
            VStack(spacing: 30){
                ForEach(0..<3){ number in
                    Button{
                        moveTapped(number)
                    } label: {
                        Text(moves[number]).font(.system(size: 45))
                    }
                }
            }.frame(maxWidth: 200)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            VStack{
                Spacer()
                Spacer()
                Text("Score: \(score)").font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                Spacer()
            }
        }
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action:  nextMove)
        } message: {
            Text("Current score: \(score)")
        }
        
        .alert("Game End!", isPresented: $showingEndScore){
            Button("Reset Game", action: resetGame)
        }message: {
            Text("Final score: \(score)")
        }
    }
    
    func moveTapped(_ number: Int){
        if(moves[number] == correctAnswer(appMove)){
            scoreTitle = "Win"
            score += 1
        }
        else{
            scoreTitle = "Lose"
            score -= 1
        }
        winlose.toggle()
        questionCounter += 1
        
        if questionCounter == 10{
            showingEndScore = true
        }
        else{
        showingScore = true
        }
    }
    
    //game handling
    func nextMove(){
        appMove = Int.random(in: 0...2)
    }
    func resetGame(){
        questionCounter = 0
        score = 0
        nextMove()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
