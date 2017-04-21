//
//  LogonViewController.swift
//  FirebaseDemo
//
//  Created by Simon Ng on 14/12/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.title = "Log In"
        emailTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = ""
    }

    @IBAction func login(_ sender: AnyObject) {
        
        //Validar los datos
        guard let emailAddress = emailTextField.text, emailAddress != "",
            let password = passwordTextField.text, password != "" else {
                let alertController = UIAlertController(title: "Error de login", message: "Rellena los campos", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
                return
        }
        
        //Conectamos con Firebase para autenticación
        //Esto es para hacerlo con google, facebook twiter..
        //FIRAuth.auth()?.signIn(with: <#T##FIRAuthCredential#>, completion: <#T##FIRAuthResultCallback?##FIRAuthResultCallback?##(FIRUser?, Error?) -> Void#>)
        
        FIRAuth.auth()?.signIn(withEmail: emailAddress, password: password, completion: { (user, error) in
            if let error = error {
            
                let alertController = UIAlertController(title: "Error de login", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
        }
            
            //Comprobar que el email ha sido verificado
            guard let currentUser = user, currentUser.isEmailVerified else {
                let alertController = UIAlertController(title: "Login Error", message: "No has confirmado tu correo electronico. Hazlo", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Reenviar email", style: .default, handler: { (action) in
                    user?.sendEmailVerification(completion: nil)
                })
                let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
                return

            }
            
            
            
            //Ocultar el teclado
            self.view.endEditing(true)
            
            //Le enviamos a la pantalla principal
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
            //Con esta linea de codigo le decimos a la aplicacion que cambie el view controller principal
            //
            UIApplication.shared.keyWindow?.rootViewController = viewController //Como tenemos un Navigation COntroller que no está enlazado utilizamos
            self.dismiss(animated: true, completion: nil)
        }
    })


    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
