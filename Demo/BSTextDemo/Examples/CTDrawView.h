//
//  CTDrawView.h
//  BSTextDemo
//
//  Created by jeremy on 2024/4/7.
//  Copyright © 2024 GeekBruce. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTDrawView : UIView

@property (nonatomic, assign) NSInteger numberOfLines; ///<行数

@property(nonatomic, strong)UIColor *textColor;

- (void)setText:(NSString*)text;

- (NSDictionary*)getStirngAttributes;

@end


NS_ASSUME_NONNULL_END
