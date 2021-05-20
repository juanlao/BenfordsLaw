//
//  ImageAnalizerViewController.swift
//  Benford
//
//  Created by Juan Maria Lao Ramos on 20/5/21.
//

import UIKit

class ImageAnalizerViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Image Analysis"
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    
    @IBAction func selectImage(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
   
}

extension ImageAnalizerViewController: ImagePickerDelegate{
    func didSelect(image: UIImage?){
        self.imageView.image = image
    }
}
