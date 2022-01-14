//
//  FullImageVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 17/10/21.
//

import UIKit

class FullImageVC: UIViewController {

    @IBOutlet weak var imgFull: UIImageView!
    
    var imgUrl : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UtilityManager.shared.setImage(image: self.imgFull, urlString: self.imgUrl)
    }
    
    @IBAction func btnCloseAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
