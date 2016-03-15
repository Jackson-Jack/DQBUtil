# DQBUtil
Some utility methods apply for iOS apps

## Some utility methods
```
/**
 *  get current app version (获取当前app version 版本号)
 */
+ (NSString *)getCurrentVersion;

/** some methods about NSUserDefaults **/
+ (void)saveToUserDefaults:(NSString *)key value:(id)value;
+ (id)retrieveFromUserDefaults:(NSString *)key;
+ (void)resetUserDefaults:(NSString *)key;

/** return the CGSize of certain style string (根据字号返回字符串尺寸) **/
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

```

More convenient methods to be added!

## How to install
### 1. From CocoaPods

```
	pod 'DQBUtil'
```

### 2. Manually

1. Drag the files under floder DQBUtil to your project.
2. Import the header file：#import "DQBUtil.h"
