//
//  DQBUtil.m
//  DQBUtil
//
//  Created by DQB on 16/2/3.
//  Copyright © 2016年 DQB. All rights reserved.
//

#import "DQBUtil.h"

@implementation DQBUtil

// 获取当前app version 版本号
+ (NSString *)getCurrentVersion
{
    return [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
}

/** NSUserDefaults **/
+ (void)saveToUserDefaults:(NSString *)key value:(id)value
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        [standardUserDefaults setObject:value forKey:key];
        [standardUserDefaults synchronize];
    }
}

+ (id)retrieveFromUserDefaults:(NSString *)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *val = nil;
    if (standardUserDefaults){
        val = [standardUserDefaults objectForKey:key];
    }
    return val;
}

+ (void)resetUserDefaults:(NSString *)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        [standardUserDefaults removeObjectForKey:key];
        [standardUserDefaults synchronize];
    }
}

/** 根据字号返回字符串尺寸 **/
+ (CGSize)sizeWithString:(NSString *)text font:(UIFont *)font
{
    return [text sizeWithAttributes:@{NSFontAttributeName:font}];
}

+ (CGSize)sizeWithString:(NSString *)text font:(UIFont *)font size:(CGSize)size
{
    return [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

//去掉首尾空格，返回处理后的字符串
+ (NSString *)stringByTrimmingWhiteSpaceInString:(NSString *)string
{
    NSString *str = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return str;
}

/** 根据十六进制字符串获取颜色值 **/
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    return [self colorWithHexString:stringToConvert alpha:1.0];
}

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert alpha:(CGFloat)alpha
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

+ (UIImage *)compressImage:(UIImage *)image withSize:(CGSize)size
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = size.height;
    float maxWidth = size.width;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression
    
    NSData *tepImageData = UIImageJPEGRepresentation(image, 1);
    NSUInteger iImageSize = [tepImageData length];
    
    if (iImageSize < 1024 * 300) {
        compressionQuality = 1;
    }
    
    
    if (actualHeight > maxHeight || actualWidth > maxWidth){
        if(imgRatio < maxRatio){
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio){
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else{
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    
    return [UIImage imageWithData:imageData];
}



/**
 *  获取一个类的属性列表

+ (NSArray *)propertyListOfClass:(Class)aClass
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(aClass, &outCount);
    
    NSMutableArray *propertyList = [NSMutableArray array];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        [propertyList addObject:propertyName];
    }
    free(properties);
    
    if ([aClass superclass] != [NSObject class]) {
        NSArray *superClassPropertyList = [self propertyListOfClass:[aClass superclass]];
        [propertyList addObjectsFromArray:superClassPropertyList];
    }
    return propertyList;
}

+ (NSDictionary *)propertyNameTypeDictOfClass:(Class)aClass
{
    NSMutableDictionary *propertyDict = [NSMutableDictionary dictionary];
    unsigned int outCount = 0, i = 0;
    objc_property_t *properties = class_copyPropertyList(aClass, &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        
        NSString *propertyType = [NSString stringWithUTF8String:property_getAttributes(property)];
        NSString* propertyClassName = nil;
        if ([propertyType hasPrefix:@"T@"]) {
            
            NSRange range = [propertyType rangeOfString:@","];
            if(range.location > 4 && range.location <= propertyType.length) {
                range = NSMakeRange(3,range.location - 4);
                propertyClassName = [propertyType substringWithRange:range];
                if([propertyClassName hasSuffix:@">"]) {
                    NSRange categoryRange = [propertyClassName rangeOfString:@"<"];
                    if (categoryRange.length>0) {
                        propertyClassName = [propertyClassName substringToIndex:categoryRange.location];
                    }
                }
            }
        } else if([propertyType hasPrefix:@"T{"]) {
            NSRange range = [propertyType rangeOfString:@"="];
            if(range.location > 2 && range.location <= propertyType.length) {
                range = NSMakeRange(2, range.location-2);
                propertyClassName = [propertyType substringWithRange:range];
            }
        } else {
            propertyType = [propertyType lowercaseString];
            if ([propertyType hasPrefix:@"ti"] || [propertyType hasPrefix:@"tb"]) {
                propertyClassName = @"int";
            } else if ([propertyType hasPrefix:@"tf"]) {
                propertyClassName = @"float";
            } else if([propertyType hasPrefix:@"td"]) {
                propertyClassName = @"double";
            } else if([propertyType hasPrefix:@"tl"] || [propertyType hasPrefix:@"tq"]) {
                propertyClassName = @"long";
            } else if ([propertyType hasPrefix:@"tc"]) {
                propertyClassName = @"char";
            } else if([propertyType hasPrefix:@"ts"]) {
                propertyClassName = @"short";
            }
        }
        if (propertyClassName.length == 0) {
            DLog(@"[hahahahhahhaahahh]");
        } else {
            propertyDict[propertyName] = propertyClassName;
        }
        
    }
    
    return propertyDict;
}

 */


@end
