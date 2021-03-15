//
//  DatalhesEventoViewController.swift
//  ProjetoEventos
//
//  Created by Horr on 12/03/21.
//

import UIKit
import Kingfisher
import ProgressHUD
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class DetalhesEventoViewController: UIViewController {

    //MARK: variaveis
    public var idEvento: String = ""
    var eventoDetalhe = [EventoDetalhe]()
    var dateText = ""

    //MARK: outlet
    @IBOutlet var viewCabecalho: UIView!
    @IBOutlet var imageEvento: UIImageView!
    @IBOutlet var labelTitulo: UILabel!
    @IBOutlet var labelData: UILabel!
    @IBOutlet var labelPreco: UILabel!
    @IBOutlet var textViewDescricao: UITextView!
    @IBOutlet weak var btnMarcarPresenca: UIButton!
    //MARK: ciclo da view
    override func viewDidLoad() {

        super.viewDidLoad()

        setupView()
        setupBackgrounds()
        
        self.buscarEventosViaApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Detalhes do Evento"
    }
    

    //MARK: funções
    private func setupView(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Voltar",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(dismissSelf))

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "share",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(compartilhar))
        
        btnMarcarPresenca.layer.cornerRadius = 10
        btnMarcarPresenca.clipsToBounds = true

        
    }

    private func setupBackgrounds() {
        viewCabecalho.clipsToBounds = true
        viewCabecalho.layer.cornerRadius = 40
        viewCabecalho.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }

    
    //MARK: funcoes API
    private func buscarEventosViaApi () {
        //-- url para buscar os eventos, estava com http mas so aceita https
        let urlString = "https://5f5a8f24d44d640016169133.mockapi.io/api/events/\(idEvento)"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parseJSON(quoteData: data)
            }
        }
    }

    //-- decodificar o json para usar na array
    func parseJSON(quoteData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(EventoDetalhe.self, from: quoteData)
            
            self.setupView(detalhes: decodedData)
            
        } catch {
            print(error)
        }
    }

    private func setupView(detalhes: EventoDetalhe){
        
        var strImagem = detalhes.image
        let subStrIMagem = String(strImagem.prefix(5))
        
        if (subStrIMagem == "http:") {
            strImagem = strImagem.replacingOccurrences(of: "http", with: "https")
        }
        let url = URL(string: strImagem)
        self.imageEvento.kf.setImage(with: url)
        
        if self.imageEvento.image == nil{
            self.imageEvento.image = UIImage(named: "nofoto2.jpg")
        }

        self.labelTitulo.text = detalhes.title
        self.textViewDescricao.text = detalhes.description
        
        //--- tranforma data em inteiro para date e depois formata com a extensao
        let timeInterval = TimeInterval(detalhes.date)
        let myNSDate = Date(timeIntervalSince1970: timeInterval)

        dateText = myNSDate.longDateAndTime()
        self.labelData.text = "\(dateText)"

        //---formata preco
        let tipAmount = detalhes.price
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: tipAmount as NSNumber) {
            self.labelPreco.text = "Preço: \(formattedTipAmount)"
        }

        
    }
    
    //MARK: funcoes objective c
    @objc private func dismissSelf() {
        //dismiss(animated: true, completion: nil)
        
        let vc = EventosViewController()
        vc.view.backgroundColor = .white
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func compartilhar() {
        let img = imageEvento.image
        let messageStr = labelTitulo.text!
        let messageStrData = "Data: " + labelData.text!
        let messageStrDescr = "Descrição: " + textViewDescricao.text!
        //let activityViewController:UIActivityViewController = UIActivityViewController(activityItems:  [imageToShare, messageStr, messageStrData, messageStrDescr], applicationActivities: nil)
        
        let activities: [AnyObject] = [img as AnyObject, messageStr as AnyObject, messageStrData as AnyObject, messageStrDescr as AnyObject  ]
        
        let activityViewController = UIActivityViewController(activityItems: activities, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func btnMarcarPresencaTouched(_ sender: Any) {
        ProgressHUD.show()
        
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: "https://5f5a8f24d44d640016169133.mockapi.io/api/checkin?eventId=\(idEvento)&name=chard&email=shardyd@hotmail.com")!,timeoutInterval: Double.infinity)
        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          print(String(data: data, encoding: .utf8)!)
            
            ProgressHUD.showError(String(data: data, encoding: .utf8)!)
            
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()


    }
}
