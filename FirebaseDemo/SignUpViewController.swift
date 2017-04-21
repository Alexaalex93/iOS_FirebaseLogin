//
//  SignUpViewController.swift
//  FirebaseDemo
//
//  Created by Simon Ng on 5/1/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Sign Up"
        nameTextField.becomeFirstResponder()
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
//    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
//    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func registarUsuario(_ sender: AnyObject) {
        //Validar el input del usuario
        
        guard let name = nameTextField.text, name != "",
        let emailAdress = emailTextField.text, emailAdress != "",
            let password = passwordTextField.text, password != "" else {
                //Al menos uno está vacío
                let alertController = UIAlertController(title: "Error de Registro", message: "Por favor rellena los 3 campos", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
                return
        }
        
        //Registramos al usuario
        
        FIRAuth.auth()?.createUser(withEmail: emailAdress, password: password, completion: { (user, error) in
            if let error = error {
                let alertController = UIAlertController(title: "Error de Registro", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
        
            //Guardar el nombre del usuario
            if let changeRequest = FIRAuth.auth()?.currentUser?.profileChangeRequest() {
                changeRequest.displayName = name
                
                
                changeRequest.commitChanges(completion: { (error) in
                    if let error = error {
                        print("Error al modificar el nombre: \(error.localizedDescription)")
                    }
                })
            }
            
            //Ocultar el teclado
            self.view.endEditing(true)
            
            
            //Enviar un email de verificacion
            user?.sendEmailVerification(completion: nil)
            let alertController = UIAlertController(title: "Verificacion de Email", message: "Te hemos enviado un correo. Debes verificarlo antes de poder acceder", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)

            
        })
    }

}
