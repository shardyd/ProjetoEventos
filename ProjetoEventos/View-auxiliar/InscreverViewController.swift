//
//  InscreverViewController.swift
//  ProjetoEventos
//
//  Created by Chardson Miranda on 14/03/21.
//

import UIKit
import ProgressHUD

class InscreverViewController: UIViewController {

    //MARK: variavel
    var idEvento = ""
    var tituloEvento = ""
    
    //MARK: outlet
    @IBOutlet weak var labelTituloEvento: UILabel!
    @IBOutlet weak var textFieldNome: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var btnMarcarPresenca: UIButton!
    @IBOutlet weak var scrollViewPrincipal: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        labelTituloEvento.text = tituloEvento

        textFieldNome.attributedPlaceholder = NSAttributedString(string: "digite seu nome",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])

        textFieldEmail.attributedPlaceholder = NSAttributedString(string: "digite seu e-mail",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])

        btnMarcarPresenca.layer.cornerRadius = 10
        btnMarcarPresenca.clipsToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        setupBackgroundTouch()
    }

    
    private func setupBackgroundTouch () {
        scrollViewPrincipal.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))

        scrollViewPrincipal.addGestureRecognizer(tapGesture)
    }
    
    @objc private func backgroundTap () {
        dismissKeyboard()
    }
    
    //MARK: - helpers
    @objc func dismissKeyboard(){
        self.view.endEditing(false)
        //self.scrollViewPrincipal.frame.origin.y = 0
        self.view.frame.origin.y = 0
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        //self.scrollViewPrincipal.frame.origin.y = -100
        self.view.frame.origin.y = -100
    }

    @objc func keyboardWillHide(sender: NSNotification) {
        self.scrollViewPrincipal.frame.origin.y = 0
    }

    //MARK: acao
    
    @IBAction func touchBtnMarcarPresenca(_ sender: Any) {
        if textFieldNome.text == nil || textFieldNome.text == "" {
            ProgressHUD.showError("Digite seu nome")
        } else if textFieldEmail.text == nil || textFieldEmail.text == ""  {
            ProgressHUD.showError("Digite seu e-mail")
        } else {
            
            let string = textFieldEmail.text
            if string!.contains(".") && string!.contains("@") {
                self.submeterInscricao(nome: textFieldNome.text!, email: textFieldEmail.text!)
            } else {
                ProgressHUD.showError("E-mail inválido, corrija e tente novamente")
            }
            
        }
    }

    private func submeterInscricao (nome: String, email: String) {
     
        ProgressHUD.show()
        
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: "https://5f5a8f24d44d640016169133.mockapi.io/api/checkin?eventId=\(idEvento)&name=\(nome)&email=\(email)")!,timeoutInterval: Double.infinity)
        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          print(String(data: data, encoding: .utf8)!)
            
            ProgressHUD.showError("Ops! \nAlgo deu errado...\n\n" + String(data: data, encoding: .utf8)!)
            
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()



    }
}
