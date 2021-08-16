//
//  ViewController.swift
//  StoryBoardTutorial
//
//  Created by 박종훈 on 2021/08/10.
//

import UIKit

class ViewController: UIViewController {
    var pageCount = [1, 2, 3]
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = pageCount.count
        pageControl.currentPage = 0
    }
    @IBAction func pageChanged(_ sender: UIPageControl) {
        label.text = "\(pageCount[pageControl.currentPage])"
    }
}
