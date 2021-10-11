//
//  ViewController.swift
//  StoryBoardTutorial
//
//  Created by 박종훈 on 2021/08/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var downloadImageView: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progressLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //프로그레스 바의 초기값 설정
        progressBar.progress = 0
    }
    //버튼 클릭했을 때
    @IBAction func downloadBtnClicked(_ sender: UIButton) {
        //프로그레스 바가 보이게 함.
        progressLbl.isHidden = false
        //이미지 뷰의 이미지를 nil로 설정
        downloadImageView.image = nil
        
        //이미지를 표현하는 URL String
        let urlString = "https://d17fnq9dkz9hgj.cloudfront.net/breed-uploads/2018/08/rottweiler-card-small.jpg?bust=1535568036"
        //URL 유효성 검사해 객체 생성
        guard let url = URL(string: urlString) else {
            //URL이 제대로된 값인지 확인
            print("This is an invalid URL")
            return
        }
        //DownloadTask를 위한 세션 생성(큐, 델레게이션, 컨피규레이션 설정).
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        //URL 이용해서 download 작업 실행.
        session.downloadTask(with: url).resume()
    }
    
}
//extension 패턴으로 URLSessionDownload 부분을 분리
extension ViewController: URLSessionDownloadDelegate {
    //downloadTask에서 다운로드가 끝날 때
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        //locate에서 데이터를 가져옴.
        guard let data = try? Data(contentsOf: location) else {
            print("The data could not be loaded")
            return
        }
        //가져온 데이터를 이미지 객체로 만듦.
        let image = UIImage(data: data)
        //비동기로 이미지뷰의 이미지를 가져온 데이터를 이용한 이미지 객체로 변경하고, 프로그레스바 안보이게 설정.
        DispatchQueue.main.async { [weak self] in
            self?.downloadImageView.image = image
            self?.progressLbl.isHidden = true
        }
    }
    //downloadTask에서 데이터 다운로드(기기로 읽어들여오는) 중.
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        //현재 읽어들여온 크기 / 예상되는 전체 크기 값
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        //비동기로 프로그레스 바를 위에서 만든 값으로 변경하고 진행도를 0이 최저고 1이 최고인 double 값이기 때문에 * 100 해서 최대를 100으로 만듦.
        DispatchQueue.main.async { [weak self] in
            self?.progressBar.progress = progress
            self?.progressLbl.text = "\(progress * 100)%"
        }
    }
}
