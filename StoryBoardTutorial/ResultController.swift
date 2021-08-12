//
//  ResultController.swift
//  StoryBoardTutorial
//
//  Created by 박종훈 on 2021/08/12.
//

import UIKit

class ResultController:ViewController {
    var label:String = "Hi"
    @IBOutlet weak var Text: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Text.text = label
    }
}
