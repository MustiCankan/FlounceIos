//
//  MiddleViewController.swift
//  FlounceFinal
//
//  Created by Mustafa Cankan Balcı on 9.05.2020.
//  Copyright © 2020 Mustafa Cankan Balcı. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Vision

class MiddleViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, GADInterstitialDelegate {

    @IBOutlet weak var statelabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    var interstitial: GADInterstitial!
     var state = ""
     var state2 = false
     var state3 = false
     var image2:UIImage!
     var selectedImage  = CIImage()
     var selectedImage2  = CIImage()
     var dictionary3 =  [Int:String]()
    let picker = UIImagePickerController()
    
    var rewardedAd: GADRewardedAd?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(state)
        if state == "Camera" {
            statelabel.text = "Image Processing"
            analyzse(image: selectedImage2)
            
        }
        else if state == "image" {

            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .photoLibrary
            present(picker, animated: true, completion: nil)
            statelabel.text = "Select a Image"
        }
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3655879237196779/5563850190")
        let request = GADRequest()
        interstitial.load(request)
        interstitial.delegate = self
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      // Local variable inserted by Swift 4.2 migrator.
      let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

    image2 = (info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage)!
     
              self.dismiss(animated: true, completion: nil)
              
     if let ciImage = CIImage(image: image2!) {
             self.selectedImage = ciImage
         
         
         analyzse(image: self.selectedImage)
         
         
                         }
           
          }
     func analyzse(image: CIImage){
         self.statelabel.text = "Waiting..."

        guard let model = try? VNCoreMLModel(for: FlounceModel_12().model) else{return}
               let request = VNCoreMLRequest(model: model){ (finishedReq, err) in
                   
                   print(finishedReq.results!)
                   
                   guard let results = finishedReq.results as? [VNClassificationObservation] else{return}
                
                let firstobserve = results[0...10].filter({ $0.confidence > 0.01 })
                
                
     
                DispatchQueue.main.async {
               for  observation in firstobserve {
                   
                   //HERE: I need to display popup with observation name
                   self.state2 = true
                   let confidenecescore = Int(observation.confidence * 100)
                   self.dictionary3.updateValue(observation.identifier, forKey: confidenecescore)
                   print(self.dictionary3)
               }
                 let value = self.dictionary3.count
                  print(value)
                 
                  if value >= 3{
                 self.statelabel.text = "Shake it"
                 self.progressView.isHidden = false
                 UIView.animate(withDuration: 2.50) {
                  self.progressView.setProgress(1.0, animated: true)
                     }
                 
                 }
                 else{
                    self.statelabel.text = "There is not enough results."
                    
                 }
               }
        }
        
               let requesthandler = VNImageRequestHandler(ciImage: image, options: [:])
               try? requesthandler.perform([request])
           }
     
     
     override func becomeFirstResponder() -> Bool {
         return true
     }
     
     override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
         if state2 == true{
         if motion == .motionShake{
             
            play()
         }
       else{
             
         }
     }
     }
     
     func play(){
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        }else{
            self.performSegue(withIdentifier: "showResult", sender: nil)
        }
}
    
        
    
   

    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
      print("interstitialDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
      print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
      print("interstitialWillPresentScreen")
    }

    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
      print("interstitialWillDismissScreen")
    }

    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
      print("interstitialDidDismissScreen")
    self.performSegue(withIdentifier: "showResult", sender: nil)
    }

    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
      print("interstitialWillLeaveApplication")
    }
    
   
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showResult" {
            if self.image2 == nil{
               print("error")
           }else{
       let destination = segue.destination as! ImageViewController
               destination.imageviewImage2 = self.image2
               destination.dictionary2 = self.dictionary3
        }
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

