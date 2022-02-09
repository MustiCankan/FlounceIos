//
//  ViewController.swift
//  FlounceFinal
//
//  Created by Mustafa Cankan Balcı on 9.05.2020.
//  Copyright © 2020 Mustafa Cankan Balcı. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController,GADBannerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var banner: GADBannerView!
    @IBOutlet weak var waitingLabel: UILabel!
    
    var state = ""
    var image1:UIImage!
    @IBOutlet weak var label: UILabel!
    var selectedImage  = CIImage()
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        button1.isHidden = false
         button2.isHidden = false
         button3.isHidden = false
        
        waitingLabel.isHidden = true 
        banner.isHidden = true
                         
        banner.delegate = self
        banner.adUnitID = "ca-app-pub-3655879237196779/4582387150"
        banner.adSize = kGADAdSizeSmartBannerPortrait
        banner.rootViewController = self
        banner.load(GADRequest())
    }
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {

    banner.isHidden = false
            
    }
           
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
    banner.isHidden = true
    }
    @IBAction func photoButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
              picker.delegate = self
              picker.allowsEditing = true
              picker.sourceType = .camera
              self.state = "Camera"
              self.present(picker, animated: true, completion: nil)
              }

        
    }
    @IBAction func imageButton(_ sender: Any) {
        self.state = "image"
        jump()
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         // Local variable inserted by Swift 4.2 migrator.
         let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

       image1 = (info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage)!
        
                
           self.selectedImage = CIImage(image: image1!)!
                
             self.dismiss(animated: true, completion: nil)
          
       
       
                 jump()
              
             }
    func jump()  {
        self.performSegue(withIdentifier: "goAnalyze", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "goAnalyze"{
      let vc = segue.destination as! MiddleViewController
      vc.state = self.state
      vc.selectedImage2 = self.selectedImage
      vc.image2 = self.image1
        }
       
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
     return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
 }

 // Helper function inserted by Swift 4.2 migrator.
 fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
     return input.rawValue
 }
