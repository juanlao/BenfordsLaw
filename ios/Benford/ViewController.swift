//
//  ViewController.swift
//  Benford
//
//  Created by Juan Maria Lao Ramos on 27/4/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func analyzeButton(_ sender: Any) {
        let benford = Benford()
        let result = benford.analyze(string: textView.text)
        
        resultLabel.text = "\(result)"
    }
    
}

