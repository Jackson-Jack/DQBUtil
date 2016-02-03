//
//  DQBUtil.h
//  DQBUtil
//
//  Created by DQB on 16/2/3.
//  Copyright © 2016年 DQB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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
