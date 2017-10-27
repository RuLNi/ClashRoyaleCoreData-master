//
//  ViewController.swift
//  ClashRoyale
//
//  Created by Jorge MR on 22/10/17.
//  Copyright © 2017 none. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imagen: UIImageView!
    @IBOutlet var nombre: UILabel!
    @IBOutlet var descripcion: UILabel!
    
    var managedContext : NSManagedObjectContext!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // Do any additional setup after loading the view, typically from a nib.
        //button.titleLabel?.numberOfLines = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Agregar(_ sender: UIButton) {
        //image picker para accesar a la galeria
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    //para hacer la fiuncion de que hacer cuando agreguemos imagen
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imagen = info[UIImagePickerControllerOriginalImage] as? UIImage{
            picker.dismiss(animated: true, completion: {
                //funcion para que se guarde en la base de datos
                self.crearPersonaje(imagen: imagen)
            })
        }
    }
    func crearPersonaje(imagen: UIImage){
        //antes de crear personaje hay que crear la base de datos usando el coreData
        
        let alertControler = UIAlertController(title:"Nuevo personaje", message: "Ingresa sus datos", preferredStyle: .alert)
        alertControler.addTextField{(textField:UITextField) in textField.placeholder = "Nombre..."}
        alertControler.addTextField{(textField:UITextField) in textField.placeholder = "Descripcion.."}
        let alertAction = UIAlertAction(title:"Guardar", style: .default) {(action: UIAlertAction) in
            let nombreTextField = alertControler.textFields?[0]
            let descripcionTextField = alertControler.textFields?[1]
            
            if nombreTextField?.text != "" && descripcionTextField?.text != ""{
                self.nombre.text = nombreTextField?.text
                self.descripcion.text = descripcionTextField?.text
                self.imagen.image = imagen
                
                //CORE DATA INSERT primero crear un contexto que sera la variable managedContext
                //asi mismo tenemos que impiortar coredata
                
                //crearemos una entidad
                let entity = NSEntityDescription.entity(forEntityName: "Personaje", in:
                    self.managedContext)
                let personaje = NSManagedObject(entity: entity!, insertInto:self.managedContext)
                personaje.setValue(nombreTextField?.text, forKey: "nombre")
                personaje.setValue(descripcionTextField?.text, forKey: "descripcion")
                personaje.setValue(NSData(data: UIImageJPEGRepresentation(imagen, 0.3)!), forKey: "imagen")
                do{
                    try self.managedContext.save()
                }catch{
                    print(error)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancelar",style: .destructive, handler : nil)
        alertControler.addAction(alertAction)
        alertControler.addAction(cancelAction)
        present(alertControler,animated: true, completion: nil)
    }
    @IBAction func Buscar(_ sender: UIButton) {
    }
    
    @IBAction func Coleccion(_ sender: UIButton) {
    }
    
    @IBAction func Borrar(_ sender: UIButton) {
    }
    
}

