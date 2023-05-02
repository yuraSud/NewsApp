//
//  StarterViewController.swift
//  NewsAppCollections
//
//  Created by YURA																			 on 19.04.2023.
//

import UIKit

class StarterViewController: UIViewController {

    let startButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        title = "Exchange container"
        setupButton()
        
    }
    
    @objc func toNews(){
        let vc = NewsViewController()
        let nav = UINavigationController(rootViewController: vc)
       // navigationController?.modalPresentationStyle = .pageSheet
       // navigationController?.viewControllers.append(vc)
        
        navigationController?.present(nav, animated: true)
       
        
     
//        present(nav, animated: true) {
//            print(vc.ttttt)
//            vc.completion = { text in
//                print(text)
//            }
//        }
    }
    
    fileprivate func setupButton() {
        view.addSubview(startButton)
        startButton.frame = .init(x: 100, y: 300, width: 250, height: 45)
        startButton.setTitle("to News", for: .normal)
        startButton.addTarget(self, action: #selector(toNews), for: .touchUpInside)
    }
}
