 //
 //  ResetPasswordViewController.swift
 //  FirebaseDemo
 //
 //  Created by Simon Ng on 5/1/2017.
 //  Copyright © 2017 AppCoda. All rights reserved.
 //
 
 import UIKit
 import Firebase
 
 class ResetPasswordViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Forgot Password"
        emailTextField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetPassBtn(_ sender: AnyObject) {
        //Validar el correo
        guard let emailAddress = emailTextField.text, emailAddress != "" else {
            let alertController = UIAlertController(title: "Error de registro", message: "Rellena los campos", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        //Enviar el email para resetear
        FIRAuth.auth()?.sendPasswordReset(withEmail: emailAddress, completion: { (error) in
            let title = (error == nil) ? "Password reset OK" : "Password reset Error"
            let message = (error == nil) ? "Te hemos mandado un email" : error?.localizedDescription
            
            let alerController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                if error == nil {
                    //Ocultamos el teclado
                    self.view.endEditing(true)
                    
                    //Volvemos a la vista de inicio
                    if let navController = self.navigationController {
                        //popViewController
                        
                        //popToRootViewController
                        
                        navController.popToRootViewController(animated: true)
                        
                    }
                }
            })
            alerController.addAction(okAction)
            self.present(alerController, animated: true, completion: nil)
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
