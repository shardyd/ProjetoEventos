//
//  ViewController.swift
//  ProjetoEventos
//
//  Created by Horr on 12/03/21.
//

import UIKit
import ProgressHUD

class ViewController: UIViewController {
    let button = UIButton()
    let imageBack = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        //definicao imagem
        let frame = view.frame
        view.addSubview(imageBack)
        imageBack.frame = frame
        imageBack.image = UIImage(named: "entrada.png")
        imageBack.translatesAutoresizingMaskIntoConstraints = false

        //-- ajusta constraints pra posicionar a imagem de entrada
        let horizontalConstraintimageBack = NSLayoutConstraint(item: imageBack, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraintimageBack = NSLayoutConstraint(item: imageBack, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 30)
        let widthConstraintimageBack = NSLayoutConstraint(item: imageBack, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 300)
        let heightConstraintimageBack = NSLayoutConstraint(item: imageBack, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 300)
        view.addConstraints([horizontalConstraintimageBack, verticalConstraintimageBack, widthConstraintimageBack, heightConstraintimageBack])


        //definicao botao
        view.backgroundColor = .white
        button.setTitle("Ver Eventos", for: .normal)
        view.addSubview(button)
        button.backgroundColor = UIColor(red: 11 / 255, green: 210 / 255 , blue: 0, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x: 100, y: 150, width: 200, height: 52)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(chamarTelaEventos), for: .touchUpInside)
     
        //-- ajusta constraints pra posicionar o botao de entrada
        button.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -30)
        let widthConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 200)
        let heightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 52)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
    }

    @objc private func chamarTelaEventos() {
        
        ProgressHUD.show()
        
        //-- verifica se tem acesso a internet para chamar os webservices
        if Reachability.isConnectedToNetwork(){
            let rootVC = EventosViewController()
            let navVC = UINavigationController(rootViewController: rootVC)
            navVC.modalPresentationStyle = .fullScreen
            present(navVC, animated: true)
        }else{
            print("Internet Connection not Available!")
            ProgressHUD.showError("Você não está conectado a internet, cheque sua rede e tente novamente!")
        }
    }
    
    
}

