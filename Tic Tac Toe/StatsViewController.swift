//
//  StatsViewController.swift
//  Tic Tac Toe
//
//  Created by 90309776 on 9/25/18.
//  Copyright © 2018 90309776. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    var statsArray: [Int] = [0, 0, 0]
    
    
    @IBOutlet weak var winsLabel: UILabel!
    
    @IBOutlet weak var losesLabel: UILabel!
    
    @IBOutlet weak var winRateLabel: UILabel!
    
    @IBAction func statsButton(_ sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //var test =
        statsArray = ViewController.stats
            
        print("loaded")
        winsLabel.text = "Wins: \(statsArray[0])"
        losesLabel.text = "Loses: \(statsArray[1])"
        winRateLabel.text = "Total Games: \(statsArray[2])"
//        if statsArray[2] != 0 {
//            winRateLabel.text = "Win Rate: \(statsArray[0] / statsArray[2])%"
//        }
        
        
        // Do any additional setup after loading the view.
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        var mainVC = segue.destination as! ViewController
//        statsArray = mainVC.stats
//        print("prepared")
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
