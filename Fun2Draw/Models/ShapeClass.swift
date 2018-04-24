//
//  ShapeClass.swift
//  Fun2Draw
//
//  Created by Akshay Deshmukh on 31/03/18.
//  Copyright © 2018 Akshay Deshmukh. All rights reserved.
//

import Foundation
import UIKit

class shapeClass {
    
    
    func drawLine(startPoint: CGPoint, endPoint: CGPoint)
        ->UIBezierPath{
            
            let linePath = UIBezierPath()
            
            linePath.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
            
            linePath.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
            
            return linePath
    }
    
    
    // function to draw triangle shape
    func triangle(startPoint: CGPoint, translationPoint: CGPoint) -> UIBezierPath {
        let rect = CGRect(x: startPoint.x, y: startPoint.y,
                          width: translationPoint.x, height: translationPoint.y)
        let trianglePath = UIBezierPath()
        
        trianglePath.move(to: CGPoint(x: rect.minX, y: rect.minY))
        
        trianglePath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        trianglePath.addLine(to: CGPoint(x: (2 * rect.minX - rect.maxX), y: rect.maxY))
        
        trianglePath.close()
        return trianglePath
    }
    
    
    
    // function save image to camera roll
    func saveImage(view: UIView){
        
        UIGraphicsBeginImageContext(CGSize(width: view.frame.size.width, height: view.frame.size.height))
        
        view.drawHierarchy(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }
    
    
    
    
    
    // Function to Clear the board
    func ClearAll(viewController: UIViewController, view: UIView, linepath: UIBezierPath, linepath1: UIBezierPath)
    {
        
        let alert = UIAlertController(title: "Clear All", message: "Are you sure you want to Clear the screen?.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive, handler: {action in

            view.layer.sublayers?.forEach { (layer) in
                layer.removeFromSuperlayer()

            }
            linepath.removeAllPoints()
            linepath1.removeAllPoints()
        }))


        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))

       viewController.present(alert, animated: true, completion: nil)
        
    }
    
   
   
    
}

