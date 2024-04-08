//
//  CTDrawView.m
//  BSTextDemo
//
//  Created by jeremy on 2024/4/7.
//  Copyright © 2024 GeekBruce. All rights reserved.
//

#import "CTDrawView.h"
#import <CoreText/CoreText.h>

typedef enum : NSUInteger {
    YTDrawModeLines,
    YTDrawModeFrame,
} YTDrawMode;

@interface YTCTLine : NSObject

@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) CTLineRef ctLine;

@end

@implementation YTCTLine

- (void)setCtLine:(CTLineRef)ctLine{
  
  if (_ctLine) {
    CFRelease(_ctLine);
  }
  if (ctLine) {
    CFRetain(ctLine);
  }
  _ctLine = ctLine;
}

@end

@interface CTDrawView()

@property(nonatomic, strong)NSMutableArray<YTCTLine *> *linesToDraw;


/**
 绘制模式，使用CTFrame或者CTLine
 */
@property (nonatomic, assign) YTDrawMode drawMode;

@property (nonatomic, assign) CTFrameRef ctFrame;

@property(nonatomic, strong)NSAttributedString *attributeString;

@property (nonatomic, strong) NSAttributedString *truncationToken;///<截断的标识字符串，默认是"..."


@end

@implementation CTDrawView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.textColor = [UIColor redColor];
  }
  return self;
}

- (void)setText:(NSString*)text{
  [self.linesToDraw removeAllObjects];
  self.attributeString = [[NSAttributedString alloc]initWithString:text attributes:[self getStirngAttributes]];
}

- (void)setAttributeString:(NSAttributedString *)attributeString{
  _attributeString = attributeString;
  [self calculateTruncatedLinesWithBounds:self.bounds];
  [self setNeedsDisplay];
}

- (void)setCtFrame:(CTFrameRef)ctFrame{
  if(_ctFrame != nil){
    CFRelease(_ctFrame);
  }
  _ctFrame = ctFrame;
}

- (CTFrameRef)composeCTFrameWithAttributeString:(NSAttributedString *)attributeString frame:(CGRect)frame {
   
    // 使用NSMutableAttributedString创建CTFrame
    CTFramesetterRef ctFramesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributeString);
    CGSize size =  CTFramesetterSuggestFrameSizeWithConstraints(ctFramesetter, CFRangeMake(0, attributeString.length), NULL, CGSizeMake(frame.size.width, CGFLOAT_MAX), NULL);
  
    // 绘制区域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(frame.size.width/2.0 - size.width/2.0,frame.size.height-size.height, size.width, size.height));

    CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFramesetter, CFRangeMake(0, attributeString.length), path, NULL);
    
    CFRelease(ctFramesetter);
    CFRelease(path);
    
    return ctFrame;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);
    
    // 绘制文字
    [self drawTextInContext:context];
}



    - (void)calculateTruncatedLinesWithBounds:(CGRect)bounds {
      
      self.ctFrame = [self composeCTFrameWithAttributeString:self.attributeString frame:self.bounds];
      
      NSArray *lines = (NSArray *)CTFrameGetLines(self.ctFrame);
      NSUInteger lineCount = lines.count;
      
      if (self.numberOfLines >0 && lineCount>self.numberOfLines) {
        // need truncate
        self.drawMode = YTDrawModeLines;
        CGPoint lineOrigins[lineCount];
        CTFrameGetLineOrigins(self.ctFrame, CFRangeMake(0,lineCount), lineOrigins);
        for (NSUInteger i = lineCount-2; i<lineCount; i++) {
          CTLineRef line = (__bridge CTLineRef)(lines[i]);
          CGFloat ascent, descent;
          CGFloat lineWidth = CTLineGetTypographicBounds(line, &ascent, &descent, NULL);
          if (i == lineCount-2) {
            //next-to-last line
            NSAttributedString* tokenString = [[NSAttributedString alloc] initWithString:@"\u2026" attributes:[self getStirngAttributes]];
            CTLineRef truncationTokenLine = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)tokenString);
            CGFloat truncationTokenLineWidth = CTLineGetTypographicBounds(truncationTokenLine, NULL, NULL, NULL);
            //generate new lines
            CTLineRef lastLine = CTLineCreateTruncatedLine(line,lineWidth-truncationTokenLineWidth, kCTLineTruncationStart, truncationTokenLine);
            lineWidth = CTLineGetTypographicBounds(lastLine, &ascent, &descent,NULL);
            YTCTLine *ytLine = [YTCTLine new];
            ytLine.ctLine = lastLine;
            ytLine.position = CGPointMake(bounds.size.width/2-lineWidth/2,self.bounds.size.height-ascent);
            [self.linesToDraw addObject:ytLine];
            
          }else{
            //last line
            YTCTLine* ytline = [YTCTLine new];
            ytline.ctLine = line;
            ytline.position =  CGPointMake(bounds.size.width/2- lineWidth/2,self.bounds.size.height - (ascent+descent)-ascent);
            [self.linesToDraw addObject:ytline];
          }
        }
      }else{
        self.drawMode = YTDrawModeFrame;
      }
    }


- (NSAttributedString *)attributeStringToDraw {
    return self.attributeString;
}
  
  
  - (NSDictionary*)getStirngAttributes{
    NSMutableParagraphStyle* paraghStyle = [[NSMutableParagraphStyle alloc]init];
    paraghStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *tokenAttributes =@{NSForegroundColorAttributeName:self.textColor,NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:22],NSParagraphStyleAttributeName:paraghStyle};
    return  tokenAttributes;
}

/**
 绘制文字
 */
- (void)drawTextInContext:(CGContextRef)context {
    if (self.drawMode == YTDrawModeFrame) {
      CTFrameDraw(self.ctFrame, context);
    } else if (self.drawMode == YTDrawModeLines) {
        for (YTCTLine *line in self.linesToDraw) {
            // 设置Line绘制的位置
            CGContextSetTextPosition(context, line.position.x, line.position.y);
            CTLineDraw(line.ctLine, context);
        }
    }
}





- (NSMutableArray<YTCTLine *> *)linesToDraw {
    if (!_linesToDraw) {
        _linesToDraw = [NSMutableArray array];
    }
    return _linesToDraw;
}


@end
