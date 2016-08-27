//
//  ViewController.swift
//  Filter-Sampler
//
//  Created by ShinokiRyosei on 2016/08/23.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var filterCollectionView: UICollectionView!
    
    var editedImages: [UIImage] = []
    
    var originalImage: UIImage?
    
    let filterNameArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        filterCollectionView.registerNib(UINib(nibName: "FilterCollectionCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSelectPickerBtn() {
        let imagePicker: UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.originalImage = image
        }
        imageView.image = originalImage
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func editOriginalImage() {
        for i in 0 ... 3 {
            guard let original: UIImage = originalImage else { return }
            let image: UIImage = FilterUtil().switchFilters(originaal: original, index: i)
            editedImages.append(image)
        }
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.editedImages.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        imageView.image = editedImages[indexPath.row]
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! FilterCollectionCell
        cell.filterImageView.image = editedImages[indexPath.row]
        cell.filterNameLabel.text = ""
        
        return cell
    }
}
