//
//  ViewController.swift
//  ProjetoEventos
//
//  Created by Horr on 12/03/21.
//

import UIKit

class ViewController: UIViewController {
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemBlue
        button.setTitle("Ver Eventos", for: .normal)
        view.addSubview(button)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 52)
        button.addTarget(self, action: #selector(chamarTelaEventos), for: .touchUpInside)
        
    }

    @objc private func chamarTelaEventos() {
        let rootVC = EventosViewController()
        rootVC.title = "Eventos Ativos"
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
        
    }
    
    
}

