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
        
        //요청할 때 같이 보낼 데이터
        let params = [
            "title": "Macco is the best",
            "body": "This is the body of the post. Get over it faaaaam"
        ]
        
        //서버에 요청할 URL. 해당하는 것이 없으면 return
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        //URL을 통해 서버에 요청하는 URLRequest객체 생성
        var request = URLRequest(url: url)
        //HTTP Method를 POST 방식으로
        request.httpMethod = "POST"
        //Request의 header 값을 설정해 json 파일임을 알림.
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        //Request의 내용이 params를 갖고, json으로 이루어졌음을 의미.
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        //URLSession객체를 싱글톤으로 생성.
        //URLRequest객체로 URL을 이용해 내용 검색을 요청
        //요청한 것을 통해 Data, Response 혹은 Error를 반환받음.
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            //에러면
            if let error = error {
                print("The error was: \(error.localizedDescription)")
            } else {//에러가 아니면
                let jsonRes = try? JSONSerialization.jsonObject(with: data!, options: [])
                print("Response json is: \(jsonRes)")
            }
            //뷰의 배경을 변경
            self.view.backgroundColor = .red
        }.resume()//세션을 가동.
    }
    
    //포스트 컬렉션을 가져옴 (REST API: Get)
    func getPosts() {
        //서버에 요청할 URL. 해당하는 것이 없으면 return
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            //에러면
            if let error = error {
                print("There was an error: \(error.localizedDescription)")
            } else {//에러가 아니면
                let jsonRes = try? JSONSerialization.jsonObject(with: data!, options: [])
                print("The response: \(jsonRes)")
            }
        }.resume()
    }
}
