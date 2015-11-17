//
//  MapVC.swift
//  Shellphone
//
//  Created by Jonathan Sandness on 11/15/15.
//  Copyright © 2015 sandness. All rights reserved.
//

import UIKit

class MapVC: UIViewController {

    @IBOutlet weak var majdImage: UIImageView!
    
    @IBOutlet weak var brittanyImage: UIImageView!
    
    @IBOutlet weak var anneImage: UIImageView!
    @IBOutlet weak var jonImage: UIImageView!
    
    var imageMapping:[UIImageView]?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        SinchConnector.sharedInstance.mapVC = self
    }
    
    override func viewDidAppear(animated: Bool) {
        self.imageMapping = [self.majdImage,self.jonImage,self.brittanyImage,self.anneImage]
    }
    
    func resetImages(){
        for image:UIImageView in self.imageMapping!{
            image.image = UIImage(named: "finalOvalGray")
        }
    }
    
    func selectUser(index:Int){
        self.imageMapping![index].image = UIImage(named: "finalOval")
    }
    
    
}
