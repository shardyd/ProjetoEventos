//
//  DetalhesEventoTableViewController.swift
//  ProjetoEventos
//
//  Created by Chardson Miranda on 13/03/21.
//

import UIKit

class DetalhesEventoTableViewController: UITableViewController {
        
    let chamada = ChamaAPI()
    public var idEvento: String = ""
    var eventoDetalhe: EventoDetalhe?
    var dateText = ""

    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.register(UINib(nibName: "DetalhesTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")

        eventoDetalhe = chamada.buscarDetalheEventosViaApi(idEvento: idEvento)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Detalhes do Evento"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? DetalhesTableViewCell

        cell?.viewCabecalho.clipsToBounds = true
        cell?.viewCabecalho.layer.cornerRadius = 40
        cell?.viewCabecalho.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        cell?.viewCabecalho.backgroundColor = UIColor(red: 3 / 255, green: 74 / 255 , blue: 30 / 255, alpha: 1)

        cell!.viewController = self

        if eventoDetalhe != nil {
            
            let strImagem = eventoDetalhe!.image
            //let subStrIMagem = String(strImagem.prefix(5))
            
            //if (subStrIMagem == "http:") {
            //    strImagem = strImagem.replacingOccurrences(of: "http", with: "https")
            //}
            let url = URL(string: strImagem)
            cell?.imageEvento.kf.setImage(with: url)
            
            if cell?.imageEvento.image == nil{
                cell?.imageEvento.image = UIImage(named: "nofoto2.jpg")
            }

            cell?.labelTitulo.text = eventoDetalhe?.title
            cell?.textViewDescricaoEvento.text = eventoDetalhe?.description
            
            //--- tranforma data em inteiro para date e depois formata com a extensao
            let timeInterval = TimeInterval(eventoDetalhe!.date)
            let myNSDate = Date(timeIntervalSince1970: timeInterval)

            dateText = myNSDate.longDateAndTime()
            cell?.labelDataEvento.text = "\(dateText)"
            
        }
        
        
        return cell!
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
