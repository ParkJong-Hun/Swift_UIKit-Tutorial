//
//  ViewController.swift
//  StoryBoardTutorial
//
//  Created by 박종훈 on 2021/08/10.
//

import UIKit

class ViewController: UIViewController {
    
    var current_image:Int = 0
    var images:[Int:String] = [
        0:"tiger",
        1:"eagle",
        2:"mountain"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var image_view: UIImageView!
    @IBAction func prev_button(_ sender: Any) {
        if current_image > 0 {
            current_image -= 1
        } else {
            current_image = get_count()
        }
        image_view.image = UIImage(named: images[current_image]!)
    }
    @IBAction func next_button(_ sender: Any) {
        if current_image < images.count - 1 {
            current_image += 1
        } else {
            current_image = 0
        }
        image_view.image = UIImage(named: images[current_image]!)
    }
    
    func get_count() -> Int {
        return images.count - 1
    }
}
