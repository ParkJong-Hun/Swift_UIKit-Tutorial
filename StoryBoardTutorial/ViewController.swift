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
    /*
    오른쪽 상단의 + 버튼을 클릭해 view를 storyboard에 드래그해 생성할 수 있음
    automatic asistant는 class가 잘 연결되어 있어야 가능
    stroyboard 밑에 두번째, 세번째거 클릭해서 Constraint 지정 가능
     */
    
    //storyboard에서 뷰를 Ctrl + 클릭하여 드래그하면 이렇게 이벤트 처리 코드를 생성할 수 있음
    @IBAction func Click_moveBtn(_ sender: Any) {
        print("moved!")
    }
    
}

