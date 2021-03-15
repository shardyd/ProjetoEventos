//
//  EventosViewController.swift
//  ProjetoEventos
//
//  Created by Horr on 12/03/21.
//

import UIKit
import Kingfisher
import ProgressHUD

class EventosViewController: UIViewController {
    // MARK: - variaveis
    var eventos = [Eventos]()
    let button = UIButton()
    let labelErro = UILabel()
    let chamada = ChamaAPI()
    
    //MARK: outlets
    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //-- deixa sempre no modo claro
        overrideUserInterfaceStyle = .light
        
        self.buscarEventos()

        //-- cria o botao pra voltar para pagina inicial
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Voltar",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(dismissSelf))
        
        //-- registra a xib pra usar na collection view
        collectionView?.register(UINib(nibName: "EventosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EventosCollectionViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Eventos"
    }
    
    
    //MARK: funcoes swift
    private func buscarEventos () {
        eventos = chamada.buscarEventosViaApi()
        
        // inverti a array pra mostrar os eventos com foto primeiro
        eventos = eventos.sorted { (first, second) -> Bool in
            return first.id > second.id
        }

        collectionView.reloadData()
    }

    //MARK: funções do objective c
    @objc private func chamarDetalhesdoEvento(idEvento: String) {
        ProgressHUD.show()
        let vc = DetalhesEventoTableViewController()
        vc.idEvento = idEvento
        vc.view.backgroundColor = .white
        navigationController?.pushViewController(vc, animated: true)

    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK: collection view delegate e datasource
extension EventosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //tira o icone da tela assim que for montar a collection
        ProgressHUD.dismiss()
        
        if eventos.count == 0 {
            
            labelErro.text = "Algo deu errado, cheque seu acesso a internet e tente novamente!"
            view.addSubview(labelErro)
            labelErro.textColor = .white
            labelErro.font = labelErro.font.withSize(24)
            labelErro.numberOfLines = 4
            labelErro.textAlignment = .center
            labelErro.frame = CGRect(x: 100, y: 150, width: 200, height: 152)
            
        }
        
        return eventos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventosCollectionViewCell", for: indexPath) as! EventosCollectionViewCell
        let dict = eventos[indexPath.row]

        cell.labelTituloEvento.text = dict.title

        let strImagem = dict.image

        //let subStrIMagem = String(strImagem.prefix(5))
        //if (subStrIMagem == "http:") {
            //strImagem = strImagem.replacingOccurrences(of: "http", with: "https")
        //}
        let url = URL(string: strImagem)
        cell.imageEvento.kf.setImage(with: url)
        
        if cell.imageEvento.image == nil{
            cell.imageEvento.image = UIImage(named: "nofoto2.jpg")
        }
        
        cell.imageEvento.layer.cornerRadius = 15
        cell.imageEvento.clipsToBounds = true

        cell.viewCell.layer.cornerRadius = 15
        cell.viewCell.clipsToBounds = true

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 400)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension EventosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if Reachability.isConnectedToNetwork(){
            if eventos.count > 0 {
                let dict = self.eventos[indexPath.row]
                let id = dict.id
                self.chamarDetalhesdoEvento(idEvento: id)
                
            }
        }else{
            print("Internet Connection not Available!")
            ProgressHUD.showError("Você não está conectado a internet, cheque sua rede e tente novamente!")
        }
    }
}
