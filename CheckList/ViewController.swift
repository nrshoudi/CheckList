//
//  ViewController.swift
//  CheckList
//
//  Created by Noura Aziz on 1/21/19.
//  Copyright © 2019 Noura Aziz. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CheckBox {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var button: UIButton!
    
    
    var days: [Days] = []
    var array = ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    var checkedDays = [String]()
    
    override func viewDidLoad() {
        
        // Add array data to the collection view
        for x in array {
            addDay(name: x)
        }
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        // Set the layout of collection view cell
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width - 20)/2, height: self.collectionView.frame.size.height/5)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection_cell", for: indexPath) as! CollectionViewCell
        
        cell.label.text = days[indexPath.row].name
        
        // Change the button background to (check or uncheck) based on selected items of collection view.
        if days[indexPath.row].checked {
            cell.checkOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxFILLED "), for: UIControl.State.normal)
            checkedDays.append(days[indexPath.row].name)
        } else {
            cell.checkOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxOUTLINE "), for: UIControl.State.normal)
            if(checkedDays.contains(days[indexPath.row].name)) {
                checkedDays = checkedDays.filter { $0 != days[indexPath.row].name }
            }
        }
        
        print(checkedDays)
        
        // Change the button title based on selected items of collection view.
        if !(self.checkedDays.isEmpty) {
            self.button.setTitle(checkedDays.joined(separator:","), for: UIControl.State.normal)
        }
        else {
            self.button.setTitle("Select", for: UIControl.State.normal)
        }
        
        cell.delegate = self
        cell.days = days
        cell.indexP = indexPath.row
        
        return cell
    }
    
    
    @IBAction func listButton(_ sender: Any) {
        // Hide and present collection view based on clicking the button
        if(collectionView.isHidden) {
            UIView.animate(withDuration: 0.8) {
                self.collectionView.isHidden = false
            }
        }
        else {
            UIView.animate(withDuration: 0.8) {
                self.collectionView.isHidden = true
            }
        }
    }
    
    
    // To add cell to the collection view
    func addDay(name: String) {
        days.append(Days(name: name))
        collectionView.reloadData()
    }
    
    // Function of CollectionViewCell's delegate
    func checkBox(state: Bool, index: Int?) {
        days[index!].checked = state
        collectionView.reloadItems(at: [IndexPath(row: index!, section: 0)])
    }
    
    
    
}

class Days {
    var name = ""
    var checked = false
    
    convenience init (name: String) {
        self.init()
        self.name = name
    }
}

