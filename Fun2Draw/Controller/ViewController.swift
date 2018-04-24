//
//  ViewController.swift
//  Fun2Draw
//
//  Created by Akshay Deshmukh on 12/03/18.
//  Copyright © 2018 Akshay Deshmukh. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var boardView: UIView!
    var startPoint = CGPoint()
    var layer : CAShapeLayer?
    var Color : UIColor = UIColor.orange
    var selectedShape: String = "xyz"
    let white: UIColor = UIColor.white
    var linewidth: Double = 3.0
    var Opacity: Float = 0.1
    
    @IBOutlet weak var SliderLabel: UILabel!
    @IBOutlet weak var Slider: UISlider!
    
    enum shapes : Int
    {
       case square = 0
        case triangle
        case Line
        case FreeHandLine
        case Oval
        case RounedRect
        case Eraser
        
    }
   
    // Swtich case for shapes
    @IBAction func triangle(_ sender: UIButton) {
       let tag = sender.tag
        switch tag {
        case shapes.square.rawValue:
            selectedShape = "Square"
        case shapes.triangle.rawValue:
            selectedShape = "Triangle"
        case shapes.Line.rawValue:
            selectedShape = "Line"
        case shapes.FreeHandLine.rawValue:
            selectedShape = "FreeHandLine"
        case shapes.Oval.rawValue:
            selectedShape = "Oval"
        case shapes.RounedRect.rawValue:
            selectedShape = "RoundedRect"
        case shapes.Eraser.rawValue:
            selectedShape = "Eraser"
        default:
            selectedShape = "Square"
        
        }
    }
    
    //function to convert label if freehandline,line or eraser selected
    @IBAction func CheckForWidth(_ sender: UIButton) {
        SliderLabel.text = "Line Width"
        Slider.minimumValue = 0.5
        Slider.maximumValue = 3.0
        Slider.value = 2.0
        
    }
    
    //function to Convert Label if Shapes selected
    @IBAction func check(_ sender: UIButton) {
         SliderLabel.text = "Opactiy"
        Slider.minimumValue = 0.0
        Slider.maximumValue = 1.0
        Slider.value = 0.5
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ColoBtn(_ sender: UIButton) {
        let btn = sender as UIButton
        Color = btn.backgroundColor!
    }
    
   
    // SaveImage
    @IBAction func SaveImage(_ sender: UIButton) {
        let save = shapeClass()
        save.saveImage(view: boardView)
       
    }

    //Clear View
    @IBAction func Cleaer(_ sender: UIButton) {
      shapeClass().ClearAll(viewController: self, view: boardView, linepath: linePath, linepath1: linePath1)
    }
    
    
    // Function to draw freehandline
    var linePath = UIBezierPath()
    func freehandline(startPoint: CGPoint, EndPoint: CGPoint)
        ->UIBezierPath{
            linePath.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
            linePath.addLine(to: CGPoint(x: EndPoint.x, y: EndPoint.y))
            linePath.close()
            return linePath

    }
    
    
    //Eraser Function
     var linePath1 = UIBezierPath()
    func Eraser(startPoint: CGPoint, EndPoint: CGPoint)
        ->UIBezierPath{
            linePath1.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
            linePath1.addLine(to: CGPoint(x: EndPoint.x, y: EndPoint.y))
            linePath1.close()
            return linePath1
            
    }
    
    
    @IBAction func LineWidthSlider(_ sender: UISlider) {
        linewidth = Double(sender.value)
        Opacity = Float(sender.value)
    }
    
    @IBAction func PanGesture(_ sender: UIPanGestureRecognizer) {
        
        if sender.state == .began
        {
            linePath = UIBezierPath()
            linePath1 = UIBezierPath()
            startPoint = sender.location(in: sender.view)
            layer = CAShapeLayer()
            layer?.fillColor = Color.cgColor
            layer?.strokeColor = UIColor.black.cgColor
            self.boardView.layer.addSublayer(layer!)
    
        }
        else if sender.state == .changed
        {
         // Draw Square Shape
            if (selectedShape == "Square")
            {
            let translation = sender.translation(in: self.view)
                 layer?.opacity = Opacity
            layer?.path = (UIBezierPath(rect:CGRect(x:startPoint.x,
                                                      y: startPoint.y,
                                                      width: translation.x,
                                                      height: translation.y))).cgPath
            }
        
            // Draw Triangle Shape
            if (selectedShape == "Triangle")
            {
                let translation = sender.translation(in: self.view)
                 layer?.opacity = Opacity
                layer?.path = shapeClass().triangle(startPoint: startPoint, translationPoint: translation).cgPath
                
            }
            
            // Draw FreeHandLine
            if (selectedShape == "FreeHandLine")
            {
                let endPoint = sender.location(in: sender.view)
                layer?.lineWidth = CGFloat(linewidth)
                layer?.strokeColor = Color.cgColor
              layer?.path =
             freehandline(startPoint: startPoint, EndPoint: endPoint).cgPath
            startPoint = endPoint
               
            }
            
            // Draw Oval Shape
            if (selectedShape == "Oval")
            {
                let translation = sender.translation(in: self.view)
                 layer?.opacity = Opacity
                 layer?.path = (UIBezierPath(ovalIn:CGRect(x:startPoint.x,
                          y: startPoint.y,
                          width: translation.x,
                             height: translation.y))).cgPath
            }
            
            
            // Draw RoundedRect
        if (selectedShape == "RoundedRect")
        {
            let translation = sender.translation(in: self.view)
             layer?.opacity = Opacity
            layer?.path = (UIBezierPath(roundedRect: CGRect(x:startPoint.x,
                                                            y: startPoint.y,
                                                            width: translation.x,
                                                            height: translation.y), cornerRadius: 10.0)).cgPath
            
            }
            
            //Draw Line
            if (selectedShape == "Line")
            {
                let endPoint = sender.location(in: sender.view)
                layer?.lineWidth = CGFloat(linewidth)
                layer?.strokeColor = Color.cgColor
                layer?.path = shapeClass().drawLine(startPoint: startPoint, endPoint: endPoint).cgPath
             
                
            }
            
            
            //Eraser
            if(selectedShape == "Eraser")
            {
                let endPoint = sender.location(in: sender.view)
                layer?.lineWidth = CGFloat(linewidth)
                layer?.strokeColor = boardView.backgroundColor?.cgColor.copy()
                layer?.opacity = 1
                layer?.path =
                    Eraser(startPoint: startPoint, EndPoint: endPoint).cgPath
                startPoint = endPoint
            }
            
            }
        }
        
    }


