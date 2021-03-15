//
//  DetalhesTableViewCell.swift
//  ProjetoEventos
//
//  Created by Chardson Miranda on 13/03/21.
//

import UIKit
import ProgressHUD

class DetalhesTableViewCell: UITableViewCell {

    //MARK: variavel
    weak var viewController: UIViewController!
    var idEvento = ""

    //MARK: outlet
    @IBOutlet weak var imageEvento: UIImageView!
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelDataEvento: UILabel!
    @IBOutlet weak var textViewDescricaoEvento: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        ProgressHUD.dismiss()

    }

    @IBOutlet weak var viewCabecalho: UIView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    @IBAction func touchBtnShare(_ sender: Any) {
        
        let img = imageEvento.image
        let messageStr = labelTitulo.text!
        let messageStrData = "Data: " + labelDataEvento.text!
        let messageStrDescr = "Descrição: " + textViewDescricaoEvento.text!
        //let activityViewController:UIActivityViewController = UIActivityViewController(activityItems:  [imageToShare, messageStr, messageStrData, messageStrDescr], applicationActivities: nil)
        
        let activities: [AnyObject] = [img as AnyObject, messageStr as AnyObject, messageStrData as AnyObject, messageStrDescr as AnyObject  ]
        
        let activityViewController = UIActivityViewController(activityItems: activities, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self // so that iPads won't crash

        viewController.present(activityViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func touchBtnInscrever(_ sender: Any) {
        
        let vc = InscreverViewController()
        vc.idEvento = idEvento
        vc.tituloEvento = labelTitulo.text!
        vc.view.backgroundColor = .white
        
        viewController.present(vc, animated: true, completion: nil)
        
    }
    
    
}
