//
//  ImageViewController.swift
//  FlounceFinal
//
//  Created by Mustafa Cankan Balcı on 9.05.2020.
//  Copyright © 2020 Mustafa Cankan Balcı. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var percentage1: UILabel!
    @IBOutlet weak var percentage3: UILabel!
    @IBOutlet weak var percentage2: UILabel!
    
    @IBOutlet weak var result1: UILabel!
    @IBOutlet weak var result2: UILabel!
    @IBOutlet weak var result3: UILabel!
    
    
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    var selectedImage1  = CIImage()
     var imageviewImage2:UIImage?
     
    @IBOutlet weak var buttonlabel: UIButton!
    
     var dictionary2 =  [Int:String]()
     var listname = [String]()
     var listint = [String]()
    
     
     var state = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageview.layer.cornerRadius = 10
                   imageview.image = imageviewImage2
                   self.imageview.clipsToBounds = true
                   roundedcorner(view: view1)
                   roundedcorner(view: view2)
                   roundedcorner(view: view3)
                  
                 
                   let sorted = self.dictionary2.sorted { $0.key > $1.key }
                   
                   
                   print(sorted)
               
                   for item in sorted{
                       listname.append(item.value)
                       listint.append(String(item.key))
                   }
                   print(listname)
                   result1.text = self.listname[0]
                   result2.text = self.listname[1]
                   result3.text = self.listname[2]
                   
                   percentage1.text = "% \(self.listint[0])"
                   percentage2.text = "% \(self.listint[1])"
                   percentage3.text = "% \(self.listint[2])"
                   
                   
            image1.image = UIImage(named: self.listname[0])
                    image2.image = UIImage(named: self.listname[1])
                    image3.image = UIImage(named: self.listname[2])
                   
                   
                   
                   
                   buttonlabel.setTitle(" \(self.listname[0]),\(self.listname[1]),\(self.listname[2]) by Icons8", for: .normal)
    }
    func roundedcorner(view: UIView){
           
           view.layer.cornerRadius = 30
          
           view.layer.shadowColor = UIColor.black.cgColor
           view.layer.shadowOffset = CGSize(width: 1, height: 1)
           view.layer.shadowOpacity = 0.45
            view.layer.shadowRadius = 0.35
           
       }

    @IBAction func websiteButton(_ sender: Any) {
         UIApplication.shared.open(URL(string: "https://icons8.com")!, options: [:], completionHandler: nil)
    }
    @IBAction func deletebutton(_ sender: Any) {
          self.listint.removeAll()
          self.listname.removeAll()
    }
    
}
