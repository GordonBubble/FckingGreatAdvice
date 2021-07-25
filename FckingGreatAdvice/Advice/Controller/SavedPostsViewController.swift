//
//  SavedPostsViewController.swift
//  FckingGreatAdvice
//
//  Created by Mac on 13.07.2021.
//

import UIKit
import RealmSwift

class SavedPostsViewController: UIViewController, CellSubclassDelegate {
    
    
    
    let realm = try? Realm()
    var array: Results<ModelDB>!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        array = realm?.objects(ModelDB.self)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func buttonTapped(cell: SavedCollectionViewCell) {
        guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                
        let editingItem = array.reversed()[indexPath.item]
        try! self.realm?.write {
            self.realm?.delete(editingItem)
            collectionView.deleteItems(at: [indexPath])
            collectionView.reloadData()
        }
    }
    
    @IBAction func closeVcButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension SavedPostsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SavedCollectionViewCell
        
        cell.delegate = self
        
        let object = array.reversed()[indexPath.item]
        
        cell.idLabelCell.text = object.id
        cell.textViewCell.text = object.text
        
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = (collectionView.bounds.width) / 2
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

}

