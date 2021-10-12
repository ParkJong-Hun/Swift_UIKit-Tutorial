//
//  ViewController.swift
//  StoryBoardTutorial
//
//  Created by 박종훈 on 2021/08/10.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //싱글톤인 AppDelegate에 만들어놓은 Container를 이용해 Context를 가져옴(AppDelegate는 앱이 설치된 순간부터 영구적으로 보존되는 데이터)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //코딩으로 테이블뷰를 작성
    let tableView:UITableView = {
        let table = UITableView()
        //테이뷸 뷰에 셀을 Identifier 이름 cell로써 생성.
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    //빈 CoreData 객체 배열 생성.
    private var models = [ToDoListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //앱의 제목 초기화
        title = "CoreData ToDoList"
        //동적으로 만든 테이블 뷰를 뷰에 서브뷰로 추가.
        view.addSubview(tableView)
        getAllItems()
        tableView.delegate = self
        tableView.dataSource = self
        //테이블 뷰의 크기를 뷰의 크기에 맞춤.
        tableView.frame = view.bounds
        //네비게이션 아이템에 누르면 didTapApp을 실행하는 오른쪽 버튼 아이템을 추가.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapApp))
    }
    
    //버튼을 눌렀을 때 액션 함수
    @objc private func didTapApp() {
        //Alert를 생성
        let alert = UIAlertController(title: "New Item", message: "Enter new Item", preferredStyle: .alert)
        //Alert에 텍스트필드 추가
        alert.addTextField(configurationHandler: nil)
        //약한 참조로 Submit 액션 추가
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: {[weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            //CoreData 생성
            self?.createItem(name: text)
        }))
        //화면에 보여줌.
        present(alert, animated: true)
    }
    
    
    
    
    
    //MARK: TableView
    //셀의 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    //각 셀의 형태
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //models(ToDoListItem)객체 배열에서 해당 셀 위치와 같은 인덱스의 객체 반환
        let model = models[indexPath.row]
        //TableView의 해당 index에 Identifer가 cell인 셀 생성
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //셀의 텍스트라벨을 model.name으로 변경
        cell.textLabel?.text = model.name
        return cell
    }
    //셀 선택했을 때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //선택 상태 취소
        tableView.deselectRow(at: indexPath, animated: true)
        let item = models[indexPath.row]
        //UIAlertController로 만들어진 sheet를 actionSheet스타일(하단부에 뜨는 알림창)로 생성. 제목은 Edit. 안내 메시지는 없음.
        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        //sheet에 취소 액션 추가
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        //sheet에 삭제 액션 추가
        sheet.addAction(UIAlertAction(title: "Delete", style: .default, handler: {[weak self] _ in
            //해당 코어 데이터 삭제
            self?.deleteItem(item: item)
        }))
        //sheet에 편집 액션 추가
        sheet.addAction(UIAlertAction(title: "Edit", style: .destructive, handler: { _ in
            //Alert스타일(일반적인 알림)의 Alert 생성.
            let alert = UIAlertController(title: "Edit Item", message: "Edit your Item", preferredStyle: .alert)
            //입력할 수 있는 뷰 생성.
            alert.addTextField(configurationHandler: nil)
            //원래 데이터의 name을 초기값으로.
            alert.textFields?.first?.text = item.name
            //Alert에 Save 액션 추가
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: {[weak self] _ in
                //버튼을 눌렀을 때 일어나는 핸들러 함수
                //텍스트 필드의 값을 newName으로 생성
                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else {
                    return
                }
                //원래 값을 입력한 값(newName)으로 업데이트
                self?.updateItem(item: item, newName: newName)
            }))
            //화면에 Alert를 띄움.
            self.present(alert, animated: true)
        }))
        //화면에 sheet를 띄움.
        present(sheet, animated: true)
    }
    
    
    
    
    
    //MARK: CoreData
    //Context에서 CoreData 조회
    func getAllItems() {
        do {
            //models 배열에 context에 요청한 ToDoListItem 데이터들을 넣음.
            models = try context.fetch(ToDoListItem.fetchRequest())
            //테이블 뷰 새로고침.
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            //error
        }
    }
    
    //Context에 새 CoreData 생성
    func createItem(name: String) {
        let newItem = ToDoListItem(context: context)
        //입력한 이름 값을 새 데이터의 이름으로
        newItem.name = name
        //현재 날자를 새 데이터의 날짜로
        newItem.createdAt = Date()
        
        do {
            //Context에 저장
            try context.save()
            //다시 조회(실시간 업데이트를 위해)
            getAllItems()
        } catch {
            
        }
    }
    
    //Context에서 CoreData 삭제
    func deleteItem(item: ToDoListItem) {
        //해당하는 데이터 삭제
        context.delete(item)
        
        do {
            try context.save()
            getAllItems()
        } catch {
            
        }
    }
    
    //Context에서 CoreData 수정
    func updateItem(item: ToDoListItem, newName: String) {
        //해당하는 데이터의 이름을 새 이름으로 수정
        item.name = newName
        
        do {
            try context.save()
            getAllItems()
        } catch {
            
        }
    }
}
