//
//  ViewController.swift
//  openLibrery
//
//  Created by Jose Lopez on 19/11/17.
//  Copyright © 2017 Jose Lopez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var isbnTextField: UITextField!
    @IBOutlet weak var isbnTextView: UITextView!
    var resultado : String = "veamo si cambia"
    
    func buscarISBNsincrono() {
        let isbn : String =  (isbnTextField.text)!
        let urls : String = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(isbn)"
        
        let url = URL(string : urls)
        let datos : Data? = NSData(contentsOf: url! as URL)! as Data
        let texto = String( data: datos!, encoding : String.Encoding.utf8)

        resultado = texto!
        
    }
    
    func buscarISBNAsincrono() {
//        prueba ISBN 978-84-376-0494-7
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func isbnEnter(_ sender: UITextField) {
        buscarISBNsincrono()
        isbnTextView.text = resultado
    }
    
    
    
}

