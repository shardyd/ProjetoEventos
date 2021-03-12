//
//  DatalhesEventoViewController.swift
//  ProjetoEventos
//
//  Created by Horr on 12/03/21.
//

import UIKit

class DetalhesEventoViewController: UIViewController {

    //MARK: variaveis
    public var idEvento: String = ""
    
    //MARK: outlet
    @IBOutlet var viewCabecalho: UIView!

    //MARK: ciclo da view
    override func viewDidLoad() {

        super.viewDidLoad()

        setupView()
        setupBackgrounds()
    }

    //MARK: funções
    private func setupView(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Voltar",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(dismissSelf))
    }

    private func setupBackgrounds() {
        viewCabecalho.clipsToBounds = true
        viewCabecalho.layer.cornerRadius = 100
        viewCabecalho.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }

    //MARK: funcoes objective c
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }

    
}
