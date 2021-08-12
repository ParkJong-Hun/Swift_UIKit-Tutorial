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
     View Controller를 클릭해 우측에 Is Initial View Controller를 체크 함으로 본 스토리가 들어와지면 시작될 화면을 설정할 수 있음
     주로 View Controller 간 연결은 storyboard에서 뷰를 클릭하고, Ctrol + 클릭 드래그로 한다.
     하지만, 여러 뷰를 연결할 때에는 이런식으로 하면 storyboard가 선으로 매우 난잡해지기 때문에, 코드로 작성하는 것을 권장한다.
     */
    @IBAction func Click_moveBtn(_ sender: Any) {
        //버튼으로 다른 뷰 컨트롤러로 이동하는 방법
        //1. 스토리보드에서 이동할 컨트롤러 찾기
            //1-1. 이동할 컨트롤러의 Identity의 storyboardID를 지정 (보통 Controller 이름과 동일하게 지음)
        //해당 indentifier 이름을 갖는 controller 가져오기
        if let controller = self.storyboard?.instantiateViewController(identifier: "DetailController") {
            //2. 컨트롤러 이동하기
            //네비게이션 컨트롤러에 뷰 컨트롤러를 푸쉬함 (네비게이션 컨트롤러 = 스택)
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
    }
    
}

