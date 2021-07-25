//
//  SavedCollectionViewCell.swift
//  FckingGreatAdvice
//
//  Created by Mac on 13.07.2021.
//

import UIKit

protocol CellSubclassDelegate: AnyObject {
    func buttonTapped(cell: SavedCollectionViewCell)
}

class SavedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var textViewCell: UITextView!
    @IBOutlet weak var idLabelCell: UILabel!
    @IBOutlet weak var deleteButtonOutlet: UIButton!
    
    weak var delegate: CellSubclassDelegate?
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.delegate = nil
        
        
        
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        
        self.delegate?.buttonTapped(cell: self)
    }
    
}



