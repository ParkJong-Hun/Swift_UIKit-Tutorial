//
//  ViewController.swift
//  StoryBoardTutorial
//
//  Created by 박종훈 on 2021/08/10.
//

import UIKit
//import TheAnimation animation의 keyPath가 무엇이 있는지 알 수 있고, 더 편하게 애니메이션을 만들 수 있는 라이브러리.
//cocoapods로 설치해야한다.

class ViewController: UIViewController {
    //MARK: Animation
    //CALayer: CoreAnimation을 수행하는 이미지 기반 내용의 객체
    let layer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layer.backgroundColor = UIColor.systemRed.cgColor
        layer.frame = CGRect(x: 100, y: 100, width: 120, height: 120)
        //view의 레이어의 서브 레이어로 추가
        view.layer.addSublayer(layer)
        //deadline 시간 이후에 execute의 내용을 실행하는 비동기
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.animateOpacity()
        })
    }
    //레이어를 움직이게 하는 함수
    func animateMovement() {
        //position이라는 keyPath(이동)로 애니메이션 생성
        let animation = CABasicAnimation(keyPath: "position")
        //처음 값
        animation.fromValue = CGPoint(x: layer.frame.origin.x + (layer.frame.width / 2),
                                      y: layer.frame.origin.y + (layer.frame.height / 2))
        //이후 값
        animation.toValue = CGPoint(x: 300, y: 400)
        //지속 시간
        animation.duration = 1
        //animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunction)
        //애니메이션 모드
        animation.fillMode = .forwards
        //애니메이션이 끝난 후 없앨 것인지
        animation.isRemovedOnCompletion = false
        //시작 시간
        animation.beginTime = CACurrentMediaTime()
        //레이어에 애니메이션을 추가
        layer.add(animation, forKey: nil)
    }
    //레이어를 투명하게 하는 함수
    func animateOpacity() {
        //opacity라는 keyPath(투명화)로 애니메이션 생성
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 3
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.beginTime = CACurrentMediaTime()
        layer.add(animation, forKey: nil)
    }
}
