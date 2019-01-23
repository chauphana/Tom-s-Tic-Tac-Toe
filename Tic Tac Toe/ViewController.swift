//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by 90309776 on 9/14/18.
//  Copyright © 2018 90309776. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var playerTurn = 0
    var indexArray = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
    var hasStartedGame = false
    var isPlayingTom = true
    var turnCount = 0
    static var stats = [0, 0, 0]
    @IBOutlet var buttonsArray: [UIButton]!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var newGame: UIButton!
    
    @IBAction func buttonFill(_ sender: UIButton) {
        
        //If the player has not pressed the start
        if !hasStartedGame {return}
        
        for button in buttonsArray {
            if sender == button {
                
            }
        }
        
        if sender.title(for: .normal) == nil {
            if playerTurn == 0 {
                sender.setTitle("X", for: .normal)
                playerTurn = 1
            }
            turnCount += 1
            checkwin()
            if isPlayingTom {
                if turnCount == 0 || turnCount == 1 {
                    specialCase()
                } else if turnCount < 8 {
                    turnCount += 1
                    computerMove()
                }
            }
        }
    }
    
    func checkwin() {
        //print("\(indexArray[0][2])")

        for (i, _) in indexArray.enumerated() {
            /*
             This if statement nests under the first for loop which is
             responsible for iterating through eve2ry row of the
             game board (buttonsArray). The if statement checks for if all
             3 columns of a single row are the same to win the game.
             buttonsArray[indexArray[row][col]]
            */
            if buttonsArray[indexArray[i][0]].title(for: .normal) != nil {
                if buttonsArray[indexArray[i][0]].title(for: .normal)
                    == buttonsArray[indexArray[i][1]].title(for: .normal)
                    && buttonsArray[indexArray[i][1]].title(for: .normal)
                    == buttonsArray[indexArray[i][2]].title(for: .normal) {
                    changeLabel(winningSide: buttonsArray[indexArray[i][2]].title(for: .normal)!)
                    print("row win")
                }
            }
        }
        for (j, _) in indexArray[0].enumerated() {
            /*
             Basically same thing as rows, but for cols
             buttonsArray[indexArray[row][col]]
             */
            if buttonsArray[indexArray[0][j]].title(for: .normal) != nil {
                if buttonsArray[indexArray[0][j]].title(for: .normal)
                    == buttonsArray[indexArray[1][j]].title(for: .normal)
                    && buttonsArray[indexArray[1][j]].title(for: .normal)
                    == buttonsArray[indexArray[2][j]].title(for: .normal) {
                    changeLabel(winningSide: buttonsArray[indexArray[0][j]].title(for: .normal)!)
                    print("col win")
                    updateStats(sendSide: buttonsArray[indexArray[0][j]].title(for: .normal)!)
                }
            }
        }
        
        if buttonsArray[indexArray[1][1]].title(for: .normal) != nil {
            if buttonsArray[indexArray[0][0]].title(for: .normal)
                == buttonsArray[indexArray[1][1]].title(for: .normal)
                && buttonsArray[indexArray[1][1]].title(for: .normal)
                == buttonsArray[indexArray[2][2]].title(for: .normal) {
                changeLabel(winningSide: buttonsArray[indexArray[1][1]].title(for: .normal)!)
                print("diag 1")
                updateStats(sendSide: buttonsArray[indexArray[1][1]].title(for: .normal)!)
            }
            if buttonsArray[indexArray[0][2]].title(for: .normal)
                == buttonsArray[indexArray[1][1]].title(for: .normal)
                && buttonsArray[indexArray[1][1]].title(for: .normal)
                == buttonsArray[indexArray[2][0]].title(for: .normal) {
                changeLabel(winningSide: buttonsArray[indexArray[1][1]].title(for: .normal)!)
                print("diag 2")
                updateStats(sendSide: buttonsArray[indexArray[1][1]].title(for: .normal)!)
            }
        }
        
    }
    
    func updateStats(sendSide side: String) {
        if side == "X" {
            ViewController.stats[0] += 1
        } else if side == "O" {
            ViewController.stats[1] += 1
        }
        //ViewController.stats[2] += 1
    }
    
    func changeLabel(winningSide side: String) {
        if playerTurn != 3 {
            topLabel.text = side + " wins!"
        }
        playerTurn = 3
    }
    
    @IBAction func statsUpdate(_ sender: UIButton) {
        print("stats \(ViewController.stats[0])")
    }
    
    /*
     Resets the boxes of the game setting them to nil
    */
    @IBAction func new2PlayerGame(_ sender: Any) {
        ViewController.stats[2] += 1
        for (i, row) in indexArray.enumerated() {
            for (j, _) in row.enumerated() {
                if  buttonsArray[indexArray[i][j]].title(for: .normal) != nil {
                    buttonsArray[indexArray[i][j]].setTitle(nil, for: .normal)
                    turnCount = 0
                    playerTurn = 0
                }
            }
        }
        
        hasStartedGame = true
        newGame.setTitle("New Game", for: .normal)
        let ranNum = Int.random(in: 0...2)
        print("\(ranNum)")
        if ranNum == 1 {
            topLabel.text = "Tom goes first (O)"
            specialCase()
            //turnCount += 1
        } else {
            topLabel.text = "You go first (X)"
        }
    }
    
    /*
     EVERYTHING BELOW THIS IS RELATED TO TOM
     EVERYTHING BELOW THIS IS RELATED TO TOM
     EVERYTHING BELOW THIS IS RELATED TO TOM
     EVERYTHING BELOW THIS IS RELATED TO TOM
    */
    
    /*
     SOURCE: https://www3.ntu.edu.sg/home/ehchua/programming/java/JavaGame_TicTacToe_AI.html
    */
    
    func computerMove() {
        print("\n\n\ncomputer is moving \ncomputer is moving\n\n\n")
        //let maxMoves = generateMoves().count
        //var result = miniMax(depth: 2, currentTurn: "computer")
        var result = miniMaxAlphaBeta(depth: 2, currentTurn: "computer", startingAlpha: Int.min, startingBeta: Int.max)
        print("\(result[1]), \(result[2])")
        
        if !canWin() {
            buttonsArray[indexArray[result[1]][result[2]]].setTitle("O", for: .normal)
        }
        
        playerTurn = 0
        checkwin()
    }
    
    func generateMoves() -> [[Int]] {
        print("generating moves")
        /*
         creates an array of an array of points (indexArray)
        */
        var possibleMoves: [[Int]] = []
        
        
        for (i, row) in indexArray.enumerated() {
            for (j, _) in row.enumerated() {
                if buttonsArray[indexArray[i][j]].title(for: .normal) == nil {
                    //point are the indexArray coords for the specific button/tile
                    let point: [Int] = [i, j]
                    possibleMoves.append(point)
                }
            }
        }
        print("\(possibleMoves)")
        return possibleMoves
    }
    
    func miniMaxAlphaBeta (depth maxMoves: Int, currentTurn turn: String, startingAlpha lalpha: Int, startingBeta lbeta: Int) -> [Int]{
        let possibileMoves: [[Int]] = generateMoves()
        var alpha = lalpha
        var beta = lbeta
        var score: Int
        var bestPoint = [-1, -1]
        /*
         This algorithm recursivly calls itself to play test games of tic tac toe from all
         the currently possibile positions.
         
         Once the tree of all possibilities have been created for the current test move,
         each branch will be evaluated and given a value based on the evaluate function.
         The computer is trying to get the maximum number whilst the player is trying to get
         the most minimum number.
         
         While the computer is in the process of evaluating every branch, the computer will
         search for possible "pruning" spots. Areas where the evuation of a branch is not needed
         because the end result wouldn't effect the last needed depth.
         
         */
        if possibileMoves.isEmpty || maxMoves == 0 {
            score = evaluate()
            return [score, bestPoint[0], bestPoint[1]]
        } else {
            for point in possibileMoves {
                if turn == "computer" {
                    buttonsArray[indexArray[point[0]][point[1]]].setTitle("O", for: .normal)
                } else {
                    buttonsArray[indexArray[point[0]][point[1]]].setTitle("X", for: .normal)
                }
                
                if turn == "computer" {
                    score = miniMaxAlphaBeta(depth: maxMoves - 1, currentTurn: "player", startingAlpha: alpha, startingBeta: beta)[0]
                    if score > alpha {
                        alpha = score
                        print("SETTING POINT TO \(point)")
                        bestPoint = point
                    }
                } else {
                    score = miniMaxAlphaBeta(depth: maxMoves - 1, currentTurn: "computer", startingAlpha: alpha, startingBeta: beta)[0]
                    if score < beta {
                        beta = score
                        print(" h SETTING POINT TO \(point)")
                        bestPoint = point
                    }
                }
                buttonsArray[indexArray[point[0]][point[1]]].setTitle(nil, for: .normal)
                if alpha >= beta {
                    print("Pruned at depth \(maxMoves) of \(point)")
                    break
                }
            }
            print("recursioning")
            return [(turn == "computer") ? alpha : beta, bestPoint[0], bestPoint[1]]
        }
    }
    
    func evaluate() -> Int {
        print("evaluating")
        var score = 0
        //ROWS
        score += evaluateSet(setArray: [0, 1, 2])
        score += evaluateSet(setArray: [3, 4, 5])
        score += evaluateSet(setArray: [6, 7, 8])
        //COLUMNS
        score += evaluateSet(setArray: [0, 3, 6])
        score += evaluateSet(setArray: [1, 4, 7])
        score += evaluateSet(setArray: [2, 5, 8])
        //DIAGONALS
        score += evaluateSet(setArray: [0, 4, 7])
        score += evaluateSet(setArray: [2, 4, 6])
        
        print("done evaluating, score: \(score)")
        return score
    }
    
    func evaluateSet (setArray set: [Int]) -> Int {
        print("evaluating set")
        var score = 0
        //First value of the set of positions in the buttonsArray
        if buttonsArray[set[0]].title(for: .normal) == "O" {
            score = 1
        } else if buttonsArray[set[0]].title(for: .normal) == "X" {
            score = -1
        }
        
        //Second value of the set
        if buttonsArray[set[1]].title(for: .normal) == "O" {
            //evauates the second value of the set for the scoring
            //method. if first value was already 1 (which means it is the same type)
            //then it is set to 10 because both 2 values are same
            //however if they are not same and one is the opponent, then set
            //is disregarded
            if score == 1 {
                score = 10
            } else if score == -1 {
                //print("RETURNING zero \(score)")
                return 0
            } else {
                score = 1
            }
        } else if buttonsArray[set[1]].title(for: .normal) == "X" {
            if score == -1 {
                score = -10
            } else if score == 1 {
                //print("RETURNING zero \(score)")
                return 0
            } else {
                score = -1
            }
        }
        
        //Thurd set of values
        if buttonsArray[set[2]].title(for: .normal) == "O" {
            if score > 0 {
                score *= 10
            } else if score < 0 {
                return 0
            } else {
                score = 1
            }
        } else if buttonsArray[set[2]].title(for: .normal) == "X" {
            if score < 0 {
                score *= 10
            } else if score > 1 {
                return 0
            } else {
                score = -1
            }
        }
        print("returning evaulated score: \(score)")
        return score
    }
    
    func canWin() -> Bool {
        for row in indexArray {
            if buttonsArray[row[1]].title(for: .normal) == "O"
                && buttonsArray[row[0]].title(for: .normal) == "O"
                || buttonsArray[row[1]].title(for: .normal) == "O"
                && buttonsArray[row[2]].title(for: .normal) == "O" {
                if buttonsArray[row[0]].title(for: .normal) == nil {
                    buttonsArray[row[0]].setTitle("O", for: .normal)
                    return true
                } else if buttonsArray[row[2]].title(for: .normal) == nil {
                    buttonsArray[row[2]].setTitle("O", for: .normal)
                    return true
                }
            }
        }
        for col in indexArray[0] {
            if buttonsArray[indexArray[1][col]].title(for: .normal) == "O"
                && buttonsArray[indexArray[0][col]].title(for: .normal) == "O"
                || buttonsArray[indexArray[1][col]].title(for: .normal) == "O"
                && buttonsArray[indexArray[2][col]].title(for: .normal) == "O" {
                if buttonsArray[indexArray[0][col]].title(for: .normal) == nil {
                    buttonsArray[indexArray[0][col]].setTitle("O", for: .normal)
                    return true
                } else if buttonsArray[indexArray[2][col]].title(for: .normal) == nil {
                    buttonsArray[indexArray[2][col]].setTitle("O", for: .normal)
                    return true
                }
            }
        }
        return false
    }
    
    func specialCase() {
        var priorityPosition = [4, 0, 2, 6, 8]
        if buttonsArray[4].title(for: .normal) == nil {
            print("tom first ")
            buttonsArray[4].setTitle("O", for: .normal)
        } else {
            let ranNum = Int.random(in: 1...4)
            buttonsArray[priorityPosition[ranNum]].setTitle("O", for: .normal)
        }
        turnCount += 1
        playerTurn = 0
    }
}

