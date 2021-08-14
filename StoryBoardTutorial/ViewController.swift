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
    @IBAction func showAlert(_ sender: Any) {
        let uialert = UIAlertController(title: "AlertTitle", message: "This is Alert message article!", preferredStyle: UIAlertController.Style.alert)
        uialert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
        self.present(uialert, animated: true, completion: nil)
    }
}

