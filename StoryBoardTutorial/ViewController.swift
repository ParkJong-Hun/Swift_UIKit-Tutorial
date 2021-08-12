//
//  ViewController.swift
//  StoryBoardTutorial
//
//  Created by 박종훈 on 2021/08/10.
//

import UIKit

class ViewController: UIViewController {
    //문장을 입력하면 다음 화면에 문장 표시
    @IBOutlet weak var Input: UITextField!
    @IBAction func NextBtn(_ sender: Any) {
        guard let controller = self.storyboard?.instantiateViewController(identifier: "ResultController") as ResultController? else {
            return
        }
        controller.label = Input.text ?? "nil"
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

