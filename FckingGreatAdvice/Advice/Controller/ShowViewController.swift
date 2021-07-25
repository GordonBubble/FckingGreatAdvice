//
//  ViewController.swift
//  FckingGreatAdvice
//
//  Created by Mac on 12.07.2021.
//

import UIKit
import RealmSwift

class ShowViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    
    var buttonIsActive = false
    
    let realm = try? Realm()
    var array: Results<ModelDB>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.layer.cornerRadius = 10
        textView.layer.cornerRadius = 10
        textView.clipsToBounds = true
        mainView.clipsToBounds = true
        
        get()
    }
    
    func get() {
        NetworkService.shared.getData { json in
            self.textView.text = json.text
            self.idLabel.text = "№ цитаты: \(json.id)"
        }
    }
    @IBAction func nextArrow(_ sender: UIButton) {
        
        if textView.text.isEmpty == true {
            networkFailureAlert()
            get()
        } else {
            textView.text = ""
            idLabel.text = "№ цитаты:"
            get()
        }
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        
        if textView.text.isEmpty == true {
            networkFailureAlert()
        } else {
            let object = ModelDB(value: [idLabel.text, textView.text])
            try! realm?.write {
                realm?.add(object)
                
            }
            nextArrow(sender)
        }
        

    }
    func networkFailureAlert() {
        let alert = UIAlertController(title: "Уп-с", message: "Дружище, у тебя что-то не так с интернетом, проверь его, а", preferredStyle: .alert)
        let action = UIAlertAction(title: "Закрыть", style: .default, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}


