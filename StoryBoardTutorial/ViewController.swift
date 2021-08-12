//
//  ViewController.swift
//  StoryBoardTutorial
//
//  Created by 박종훈 on 2021/08/10.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    /*
     WebKitView = 웹뷰.
     ctrl + 클릭 드래그를 이용해 뷰 컨트롤러에 WKWebView를 생성 (WebKit import 필요!)
     */
    //웹뷰에 웹사이트 출력하는 법
    @IBOutlet weak var WebViewMain: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //5. 만든 웹뷰 로딩 함수 호출
        urlPass()
    }
    //1. 웹뷰 로딩 함수 정의
    func urlPass() {
        //2. 주소를 String으로 받아서 URL 형식으로 변환
        let urlStr = "https://www.google.com/"
        let url = URL(string: urlStr)
        //3. URL을 URLrequest로 바꿈
        let urlReq = URLRequest(url: url!)
        //4. request를 load함
        WebViewMain.load(urlReq)
    }
    
    
    
}

