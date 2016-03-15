//
//  DQBUtil.h
//  DQBUtil
//
//  Created by DQB on 16/2/3.
//  Copyright © 2016年 DQB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define WEAK(point) __weak __typeof(point) weak##point = point;

#define kViewWidth      (self.view.frame.size.width)
#define kViewHeight     (self.view.frame.size.height)

#define kWindowWidth    ([UIScreen mainScreen].bounds.size.width)
#define kWindowHeight   ([UIScreen mainScreen].bounds.size.height)

#define kScaleFrom_iPhone5(_X_) (_X_ * (kWindowWidth/320))
#define kScaleFrom_iPhone6(_X_) (_X_ * (kWindowWidth/375))

@interface DQBUtil : NSObject

/**
 *  获取当前app version 版本号
 */
+ (NSString *)getCurrentVersion;

/** NSUserDefaults **/
+ (void)saveToUserDefaults:(NSString *)key value:(id)value;
+ (id)retrieveFromUserDefaults:(NSString *)key;
+ (void)resetUserDefaults:(NSString *)key;

/** 根据字号返回字符串尺寸 **/
+ (CGSize)sizeWithString:(NSString *)text font:(UIFont *)font;
+ (CGSize)sizeWithString:(NSString *)text font:(UIFont *)font size:(CGSize)size;

/**
 *  去掉首尾空格，返回处理后的字符串 
 */
+ (NSString *)stringByTrimmingWhiteSpaceInString:(NSString *)string;

/** 根据十六进制字符串获取颜色值 **/
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha;

/**
 *  根据指定大小压缩图片
 */
+ (UIImage *)compressImage:(UIImage *)image withSize:(CGSize)size;

@end
