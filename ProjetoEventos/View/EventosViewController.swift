//
//  EventosViewController.swift
//  ProjetoEventos
//
//  Created by Horr on 12/03/21.
//

import UIKit
import Kingfisher

class EventosViewController: UIViewController {
    // MARK: - variaveis
    var eventos = [Eventos]()
    let button = UIButton()
    
    //MARK: outlets
    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //-- deixa sempre no modo claro
        overrideUserInterfaceStyle = .light
        
        self.buscarEventosViaApi()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Voltar",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(dismissSelf))
        
        collectionView?.register(UINib(nibName: "EventosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EventosCollectionViewCell")
    }

    
    //MARK: funcoes swift
    private func buscarEventosViaApi () {
        //-- url para buscar os eventos, estava com http mas so aceita https
        let urlString = "https://5f5a8f24d44d640016169133.mockapi.io/api/events"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                //let str = String(decoding: data, as: UTF8.self)
                //let data2 = Data(str.utf8)
                parseJSON(quoteData: data)
            }
        }
    }

    //-- decodificar o json para usar na array
    func parseJSON(quoteData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([Eventos].self, from: quoteData)
            
            eventos = decodedData
            print(decodedData[0].title)
            
        } catch {
            print(error)
        }
    }
    
    //MARK: funções do objective c
    @objc private func chamarDetalhesdoEvento(idEvento: String) {
        
        let vc = DetalhesEventoViewController()
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
        return eventos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventosCollectionViewCell", for: indexPath) as! EventosCollectionViewCell
        let dict = eventos[indexPath.row]

        cell.labelTituloEvento.text = dict.title

        //if (dict.id == "4"){
            var strImagem = dict.image
            let subStrIMagem = String(strImagem.prefix(5))
            
            if (subStrIMagem == "http:") {
                strImagem = strImagem.replacingOccurrences(of: "http", with: "https")
            }
            
            //https://www.fernaogaivota.com.br/documents/10179/1665610/feira-troca-de-livros.jpg
            //http://lproweb.procempa.com.br/pmpa/prefpoa/seda_news/usu_img/Papel%20de%20Parede.png
            let url = URL(string: strImagem)
            cell.imageEvento.kf.setImage(with: url)
        //}
        
        if cell.imageEvento.image == nil{
            cell.imageEvento.image = UIImage(named: "nofoto.jpg")
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
        
        if eventos.count > 0 {
            
            let dict = self.eventos[indexPath.row]
            let id = dict.id
            self.chamarDetalhesdoEvento(idEvento: id)
            
        }
    }
}
