//
//  ViewController.swift
//  StoryBoardTutorial
//
//  Created by 박종훈 on 2021/08/10.
//

import UIKit
import WidgetKit

class ViewController: UIViewController {
    //UITextField를 동적 생성
    private let field:UITextField = {
        let field = UITextField()
        field.placeholder = "Enter Text"
        field.backgroundColor = .white
        return field
    }()
    //UIButton을 동적 생성
    private let button:UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Save", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //뷰(컨테이너)의 배경색을 지정
        view.backgroundColor = .systemBlue
        //뷰에 만든 필드, 버튼을 추가
        view.addSubview(field)
        view.addSubview(button)
        //해당 뷰에서 객체를 firstResponder로 설정
        field.becomeFirstResponder()
        //버튼을 클릭하면 전달되어지는 목적지 설정
        //해당 버튼을 클릭시 didTapButton 함수를 실행
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    //서브 뷰가 보여질 때
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //필드의 너비, 높이 설정
        field.frame = CGRect(x: 20, y: view.safeAreaInsets.top+10,
                             width: view.frame.size.width-40,
                             height: 52)
        //버튼의 너비, 높이 설정
        button.frame = CGRect(x:30, y: view.safeAreaInsets.top+70,
                              width: view.frame.size.width-60,
                              height: 50)
    }
    //버튼을 눌렀을 때 appgroups를 통해 데이터가 전달됨.
    @objc private func didTapButton() {
        field.resignFirstResponder()
        
        let userDefaults = UserDefaults(suiteName: "group.storyboardtutorialwidgetscache")
        
        guard let text = field.text, !text.isEmpty else {
            return
        }
        
        userDefaults?.setValue(text, forKey: "text")
        //위젯의 타임라인을 새로고침
        WidgetCenter.shared.reloadAllTimelines()
    }
}
