//
//  ViewController.swift
//  StoryBoardTutorial
//
//  Created by 박종훈 on 2021/08/10.
//

import UIKit

class ViewController: UIViewController {
    
    private let field:UITextField = {
        let field = UITextField()
        field.placeholder = "Enter Text"
        field.backgroundColor = .white
        return field
    }()
    
    private let button:UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Save", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(field)
        view.addSubview(button)
        field.becomeFirstResponder()
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        field.frame = CGRect(x: 20, y: view.safeAreaInsets.top+10,
                             width: view.frame.size.width-40,
                             height: 52)
        
        button.frame = CGRect(x:30, y: view.safeAreaInsets.top+70,
                              width: view.frame.size.width-60,
                              height: 50)
    }
    
    @objc private func didTapButton() {
        
    }
}
