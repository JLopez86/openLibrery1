//
//  ViewController.swift
//  openLibrery
//
//  Created by Jose Lopez on 19/11/17.
//  Copyright © 2017 Jose Lopez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var portadaLibro: UIImageView!
    @IBOutlet weak var isbnTextField: UITextField!

    @IBOutlet weak var autorLabel: UILabel!
    @IBOutlet weak var tituloLabel: UILabel!
    var titulo : String = ""
    var portada : String = ""
    var autor : String = "- "
    var progreso : UIActivityIndicatorView = UIActivityIndicatorView()
/*
    
    func buscarISBNsincrono() {
        let isbn : String =  (isbnTextField.text)!
        let urls : String = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(isbn)"
        
        let url = URL(string : urls)
        let datos : Data? = NSData(contentsOf: url! as URL)! as Data
        let texto = String( data: datos!, encoding : String.Encoding.utf8)

        resultado = texto!
        
    }
    
    func buscarISBNAsincrono() {
//       prueba ISBN 978-84-376-0494-7   978-07-802-5996-6
        let isbn : String =  (isbnTextField.text)!
        let urls : String = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(isbn)"
        
        let url = URL(string : urls)
        let sesion = URLSession.shared
        let bloque = { (datos : Data?, resp : URLResponse?, error : Error?) -> Void in
            let texto = String(data: datos!, encoding : String.Encoding.utf8)
            print(texto!)
            
            if error != nil {
                print("ocurrio un error")
            }

        }
       
        
        
        let dt = sesion.dataTask(with: url!, completionHandler: bloque)
        dt.resume()
        print("listo")

        
    }
    
    
    func leeJson() {
        let isbn : String =  (isbnTextField.text)!
        let urls : String = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(isbn)"
        let url = URL(string : urls)
        
        do {
            let datos = try Data(contentsOf: url! as URL)
            print(datos)
            
            let json = try JSONSerialization.jsonObject(with: datos, options: .mutableLeaves)
            let dic1 = json as! NSDictionary
//            let dic2 = dic1["title"] as! NSDictionary
//            let dic3 = dic1["authors"] as! NSDictionary
            
            isbnTextView.text = dic1["title"] as! NSString as String
            
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func leeISBN() {
        
        
//        var autor : String
        let isbn : String =  (isbnTextField.text)!
        let urls : String = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(isbn)"
        
        let url = URL(string : urls)

        do {
            let datos = try Data(contentsOf: url! as URL )
            print(datos)
            
            let json = try JSONSerialization.jsonObject(with: datos, options: .mutableLeaves)
            
            let dico1 = json as! NSDictionary
            let dico2 = dico1["ISBN:\(isbn)"] as! NSDictionary
            titulo = dico2["title"] as! NSString as String
            let dico3 = dico2["authors"] as! NSArray
 
            for i in dico3 {
                let autorDictionario = i as! NSDictionary
                print(autorDictionario["name"] as! NSString as String)
                
                self.autor += (autorDictionario["name"] as! NSString as String)
                
                
                }
            
            let dico4 = dico2["cover"] as! NSDictionary
            
            self.portada = dico4["large"] as! NSString as String
           
            tituloLabel.text = titulo
            autorLabel.text = autor
            print(self.portada)
//            print(autor)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func mostrarImagen(_ uri : String, inView: UIImageView){
        
        let url = URL(string: uri)
        
        let task = URLSession.shared.dataTask(with: url!) {responseData,response,error in
            if error == nil{
                if let data = responseData {
                    
                    DispatchQueue.main.async {
                        inView.image = UIImage(data: data)
                    }
                    
                }else {
                    print("no data")
                }
            }else{
                print(error!)
            }
        }
        
        task.resume()
        pararProgreso()
        
    }

    func inicioProgreso() {
        self.progreso.center = self.view.center
        self.progreso.hidesWhenStopped = true
        self.progreso.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        view.addSubview(progreso)
        
        self.progreso.startAnimating()
    }
    
    func pararProgreso() {
        self.progreso.stopAnimating()
    }
    @IBAction func isbnEnter(_ sender: UITextField) {
        inicioProgreso()
        leeISBN()
        mostrarImagen(portada, inView: portadaLibro)
        
    }
    

}

