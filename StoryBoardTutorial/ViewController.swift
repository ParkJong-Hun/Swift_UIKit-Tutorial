//
//  ViewController.swift
//  StoryBoardTutorial
//
//  Created by 박종훈 on 2021/08/10.
//

import UIKit

class ViewController: UIViewController {
    //버튼 클릭하면 값 오르게 하기
    @IBOutlet weak var Number: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func UpEvent(_ sender: Any) {
        Number.text = "\(Int(Number.text!)! + 1)"
    }
    
    @IBAction func DownEvent(_ sender: Any) {
        Number.text = "\(Int(Number.text!)! - 1)"
    }
}

