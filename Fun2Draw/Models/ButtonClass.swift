//
//  ButtonClass.swift
//  Fun2Draw
//
//  Created by Akshay Deshmukh on 04/04/18.
//  Copyright © 2018 Akshay Deshmukh. All rights reserved.
//

import Foundation
import UIKit


class ButtonClass: UIButton
{
    
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        if let image = UIImage(named: "tickImage")
        {
            self.setImage(image, for: .highlighted)
        }

    }
    
  
    
}
