//
//  ViewController.swift
//  StoryBoardTutorial
//
//  Created by 박종훈 on 2021/08/10.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    //MARK: User Defaults
    /*
     유저가 앱에서 무언가 활동을 하고 저장을 하였을 때, 앱을 종료하고 다시 열어도,
     기존의 저장한 데이터를 사용할 수 있게 하는 것.
     xcode에 기본 내장되어 있기 때문에 추가적인 라이브러리 필요 없음.
     */
    @IBOutlet var label: UILabel!
    @IBOutlet var field: UITextField!
    
    //UseDefaults 객체 생성
    //let useDefaults = UserDefaults()
    //안전하게 식별하기 위해 번들 아이디를 지정해 해당 번들의 UseDefaults 객체 생성
    //let useDefaults = UserDefaults(suiteName: "[BundleID]")
    //static 객체생성 class, suiteName을 혹은, UseDefaults.standard를 이용해 다른 클래스에서도 사용할 수 있는 싱글톤(shared) usedefaults도 만들 수 있음.
    
    //뷰가 로드될 때
    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        //userActivity에 savedText라는 키 이름으로 String 값이 저장되어 있다면 savedValue라는 변수를 선언하고 값을 넣음.
        //if let savedValue = userActivity?.value(forKey: "savedText") as? String {
        if let savedValue = UserDefaults.standard.string(forKey: "savedText") {
            //레이블의 텍스트를 savedValue의 값으로 변경
            label.text = savedValue
        }
    }
    
    //엔터키 같이 Return 역할을 하는 것을 입력햇을 때 실행
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //useDefaults에 article이라는 키 이름으로 field.text의 값을 저장.
        //useDefaults.setValue(field.text, forKey: "savedText")
        UserDefaults.standard.set(field.text, forKey: "savedText")
        //첫번째 요청 상태를 포기(컴퓨터가 사람이 엔터를 한 번 눌러도 여러번 누른 것으로 인식해 여러번 저장하는 것을 방지)
        field.resignFirstResponder()
        return true
    }
}
