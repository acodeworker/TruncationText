//
//  LMDrawView.swift
//  BSTextDemo
//
//  Created by jeremy on 2024/4/6.
//  Copyright © 2024 GeekBruce. All rights reserved.
//

import UIKit
import CoreText

class YTCTLine:NSObject{
  var position:CGPoint
  var ctLine:CTLine
  
  
  init(position: CGPoint, ctLine: CTLine) {
    self.position = position
    self.ctLine = ctLine
  }
}

public class CTDrawView:UIView{
  
  var numberOfLines:Int = 2
  
  var ctframe:CTFrame? = nil
  
  var lineArray:[YTCTLine] = []
  var attriString:NSAttributedString? {
    didSet{
      guard let attriString = attriString else {
        return
      }
      let frameSetter = CTFramesetterCreateWithAttributedString(attriString)
      var size = CGSize(width:self.bounds.size.width, height: CGFloat(MAXFLOAT))
      size =  CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRange(location: 0, length: 0), nil, size, nil)
      let path = CGPath(rect: CGRect(origin: CGPoint(x: 0, y: 0), size: size), transform: nil)
      let frame = CTFramesetterCreateFrame(frameSetter,CFRange(location: 0, length: attriString.length), path, nil)
      
      var lines = CTFrameGetLines(frame)
      var lineCount = CFArrayGetCount(lines)
      var lineOriginArray = UnsafeMutablePointer<CGPoint>.allocate(capacity: lineCount)
      CTFrameGetLineOrigins(frame, CFRange(location: 0, length: lineCount), lineOriginArray)
      
      guard self.numberOfLines != 0 && lineCount > self.numberOfLines else{
        self.ctframe = frame
        return
      }
      
      for i in (0..<self.numberOfLines).reversed(){
        let ctLine = unsafeBitCast(CFArrayGetValueAtIndex(lines, i), to: CTLine.self)
        let runs = CTLineGetGlyphRuns(ctLine)
        if CFArrayGetCount(runs) == 0{
          continue
        }
        let range = CTLineGetStringRange(ctLine)
        if i == 0 {
         let ytctLine = YTCTLine.init(position: CGPoint(x: 0, y: 0), ctLine: ctLine)
          self.lineArray.insert(ytctLine, at: 0)
        }else{
          let tokenString = NSAttributedString(string: "\u2026",attributes:nil)
          let tokenSize = tokenString.boundingRect(with: CGSize(width: CFloat(MAXFLOAT), height: CFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, context: nil).size
          
          
        }
      }

      
      
    }
  }
  
  public override func draw(_ rect: CGRect) {
    
  }
  
}
