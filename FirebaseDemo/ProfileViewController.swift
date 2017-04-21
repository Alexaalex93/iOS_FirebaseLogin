//
//  ProfileViewController.swift
//  FirebaseDemo
//
//  Created by Simon Ng on 6/1/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Mi perfil"
        if let currentUser = FIRAuth.auth()?.currentUser{
            nameLabel.text = currentUser.displayName
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: AnyObject) {
        do {
            try FIRAuth.auth()?.signOut() //Lo hacemos con do catch porque la funcion lanza errores
        } catch  {
            
            let alertController = UIAlertController(title: "Error de Registro", message: error.localizedDescription, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        //Le enviamos a la pantalla principal
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeView") {
            //Con esta linea de codigo le decimos a la aplicacion que cambie el view controller principal
            //
            UIApplication.shared.keyWindow?.rootViewController = viewController //Como tenemos un Navigation COntroller que no está enlazado utilizamos
            self.dismiss(animated: true, completion: nil)

        }
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
