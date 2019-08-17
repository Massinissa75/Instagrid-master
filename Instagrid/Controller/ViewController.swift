//
//  ViewController.swift
//  stack view
//
//  Created by Massinissa_theking on 06/06/2019.
//  Copyright © 2019 Massinissa_theking. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imagePick = UIImagePickerController()
    var currentButton: UIButton?
    var imgView = UIImage?.self

    // Differents outlets

    @IBOutlet weak var arrowIcon: UIImageView!
  
    @IBOutlet weak var layout1: UIButton!
    @IBOutlet weak var layout2: UIButton!
    @IBOutlet weak var layout3: UIButton!

    @IBOutlet weak var labelShare: UILabel!

    @IBOutlet weak var gridView: UIView!

    @IBOutlet weak var butn1: UIButton!
    @IBOutlet weak var butn2: UIButton!
    @IBOutlet weak var butn3: UIButton!
    @IBOutlet weak var butn4: UIButton!
  
    var currentLayout: Int = 2

  //ViewDidLoad
  override func viewDidLoad() {
        self.currentLayout = 2
        setLayout(layout: 2)
  }
  
  @IBAction func chooseLayout(_sender: UIButton) {
    
    setLayout(layout: _sender.tag)
  }
  /// SetLayout function
  private func setLayout(layout: Int) {
    self.currentLayout = layout
    if (layout == 0) {
      butn1.isHidden = true
      butn2.isHidden = false
      butn3.isHidden = false
      butn4.isHidden = false
      
      layout1.setImage(UIImage(named: "Selected"), for: .normal)
      layout2.setImage(nil, for: .normal)
      layout3.setImage(nil, for: .normal)
      
    } else if (layout == 1) {
      butn3.isHidden = true
      butn1.isHidden = false
      butn2.isHidden = false
      butn4.isHidden = false
      
      layout2.setImage(UIImage(named: "Selected"), for: .normal)
      layout1.setImage(nil, for: .normal)
      layout3.setImage(nil, for: .normal)
      
    } else {
      butn1.isHidden = false
      butn2.isHidden = false
      butn3.isHidden = false
      butn4.isHidden = false
      
      layout3.setImage(UIImage(named: "Selected"), for: .normal)
      layout2.setImage(nil, for: .normal)
      layout1.setImage(nil, for: .normal)
    }
  }
  
  ///Select and add an image from library
  @IBAction func addImageButton(_ sender: UIButton) {
    
    currentButton = sender
    let image = UIImagePickerController()
    image.delegate = self
    image.sourceType = UIImagePickerController.SourceType.photoLibrary
    image.allowsEditing = true
    self.present(image, animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
    if let button = currentButton {
      button.setImage(image, for: .normal)
      button.imageView?.contentMode = .scaleAspectFill
    }
    self.dismiss(animated: true, completion: nil)
  }
  
  /// Device orientation & message share
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    if UIDevice.current.orientation.isLandscape {
      labelShare.text = "Swipe left to share"
      arrowIcon.image = UIImage(named: "Arrow Left")
    } else {
      labelShare.text = "Swipe up to share"
      arrowIcon.image = UIImage(named: "Arrow Up")
    }
  }
  
  //Swipe to share
  @IBAction func swipeToShare(_ sender: UISwipeGestureRecognizer) {
    if (UIDevice.current.orientation.isPortrait && sender.direction == .up) || (UIDevice.current.orientation.isLandscape && sender.direction == . left)
    {
      sharing(_sender: UISwipeGestureRecognizer.self)
    }
  }
  /// Sharing function
  private func sharing(_sender: Any) {
     if self.isAllImageSet() {
        let imageShare = [gridView.image]
        let activityVC = UIActivityViewController(activityItems: imageShare as [Any], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
  }
  /// Check if layout's all images are set
  private func checkLayoutIsOk () -> Bool{
    var isOk = true
    switch self.currentLayout {
    case 0:
      if self.butn2.image(for: .normal) == nil {isOk = false}
      if self.butn3.image(for: .normal) == nil {isOk = false}
      if self.butn4.image(for: .normal) == nil {isOk = false}
    case 1:
      if self.butn1.image(for: .normal) == nil {isOk = false}
      if self.butn2.image(for: .normal) == nil {isOk = false}
      if self.butn4.image(for: .normal) == nil {isOk = false}
    case 2:
      if self.butn1.image(for: .normal) == nil {isOk = false}
      if self.butn2.image(for: .normal) == nil {isOk = false}
      if self.butn3.image(for: .normal) == nil {isOk = false}
      if self.butn4.image(for: .normal) == nil {isOk = false}
    default:
      isOk = false
    }
    return isOk
  }
    /// Alerte message if checklayout is not ok
    private func isAllImageSet() -> Bool{
      if !self.checkLayoutIsOk() {
      
        let shareAlert = UIAlertController(title: "You must to set all image before share !",message: "",
        preferredStyle: .alert
        )
        shareAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(shareAlert, animated: true)
        return false
      }
      return true
    }
}
