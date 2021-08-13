//
//  ViewController.swift
//  StoryBoardTutorial
//
//  Created by 박종훈 on 2021/08/10.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    var price = 0
    @IBOutlet weak var Button_Price: UILabel!
    @IBAction func Switch_Pizza(_ sender: UISwitch) {
        if sender.isOn {
            price += 15
            Button_Price.text = "$\(price)"
        } else {
            price -= 15
            if price < 0 {
                price = 0
            }
            Button_Price.text = "$\(price)"
        }
    }
    @IBAction func Switch_Coke(_ sender: UISwitch) {
        if sender.isOn {
            price += 2
            Button_Price.text = "$\(price)"
        } else {
            price -= 2
            if price < 0 {
                price = 0
            }
            Button_Price.text = "$\(price)"
        }
    }
    @IBAction func Switch_Hamburger(_ sender: UISwitch) {
        if sender.isOn {
            price += 6
            Button_Price.text = "$\(price)"
        } else {
            price -= 6
            if price < 0 {
                price = 0
            }
            Button_Price.text = "$\(price)"
        }
    }
}

