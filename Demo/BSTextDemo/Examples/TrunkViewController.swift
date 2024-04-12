//
//  TrunkViewController.swift
//  BSTextDemo
//
//  Created by jeremy on 2024/4/6.
//  Copyright © 2024 GeekBruce. All rights reserved.
//

import UIKit

class TrunkViewController:UIViewController{
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = .center
    var drawView = CTDrawView(frame: CGRect(origin: CGPoint(x: 10, y: 100), size: CGSizeMake(250,100)))
    let string = "You can copy image from browser or photo album and past.You can copy image from browser or photo album and pastYou can copy image from browser or photo album and past.You can copy image from browser or photo album and past";
    drawView.numberOfLines = 2
    drawView.textColor = UIColor.red
    drawView.setText(string)
    drawView.backgroundColor = UIColor.lightGray
    self.view.addSubview(drawView)
    
    
//    drawView = CTDrawView(frame: CGRect(origin: CGPoint(x:CGRectGetMaxX(drawView.frame)+2, y: 100), size: CGSizeMake(150, 100)))
//    drawView.numberOfLines = 0
//    drawView.setText(string)
//    drawView.backgroundColor = UIColor.white
//    self.view.addSubview(drawView)
    
    let texts = [
                "1.You can copy image from browser or photo album and past.You can copy image from browser or photo album and pastYou can copy image from browser or photo album and past.You can copy image from browser or photo album and past",
                 "2.You can copy image from browser.",
                 "3.You can copy image from browser or photo album and past.You can copy image from browser or photo album and pastYou can copy image from browser or photo album and past.You can copy image from browser or photo album and past",
                  "2.You can copy image from browser."]
   let timer = Timer(timeInterval: 2, repeats: true) { timer in
      let randomInt = Int.random(in: 0..<4)
      print("-----:\(randomInt)")
      drawView.setText(texts[randomInt])
    }
    RunLoop.current.add(timer, forMode: .default)
    timer.fire()
  }
}

 
