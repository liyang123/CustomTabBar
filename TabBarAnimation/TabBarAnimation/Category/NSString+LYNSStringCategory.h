//
//  NSString+LYNSStringCategory.h
//  LYNSStringCategory
//
//  Created by liyang on 16/3/29.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (LYNSStringCategory)

/**
 *  利用正则表达式获取url中的参数对应的值
 *
 *  @param CS         url中需要解析的参数key
 *  @param webaddress url
 *
 *  @return key对应的value值
 */
+ (instancetype)ly_stringGetValueFromUrlStr:(NSString *)webaddress WithKey:(NSString *)CS;

/**
 *  时间戳转年龄
 *
 *  @param totoal 时间戳
 *
 *  @return 年龄string类型
 */
+ (instancetype)ly_stringGetAgeByTime:(long)totoal;

/**
 *  时间戳转星座
 *
 *  @param totoal 传入的时间戳
 *
 *  @return 返回结果字符串
 */
+ (instancetype)ly_stringGetConstellationByTime:(long)totoal;

/**
 判读是否有中文
 
 @param string 要被判断的字符串
 
 @return 结果
 */
+ (BOOL)ly_stringIsContainChineseWithStr:(NSString *)string;

/**
 判读是否是QQ号
 
 @param string 要被判断的字符串
 
 @return 结果
 */
+ (BOOL)ly_stringIsQQNumber:(NSString *)string;

/**
 判读是否是手机号
 
 @param string 要被判断的字符串
 
 @return 结果
 */
+ (BOOL)ly_stringIsPhoneNumber:(NSString *)string;

/**
 判读是否是数字
 
 @param string 要被判断的字符串
 
 @return 结果
 */
+ (BOOL)ly_stringIsNumber:(NSString *)string;

/**
 判读是否是邮箱号
 
 @param string 要被判断的字符串
 
 @return 结果
 */
+ (BOOL)ly_stringIsValidEmail:(NSString *)string;

/**
 判读是否是车牌号
 
 @param string 要被判断的字符串
 
 @return 结果
 */
+ (BOOL)ly_stringIsValidCarNo:(NSString *)string;

/**
 判读是否是有效网址
 
 @param string 要被判断的字符串
 
 @return 结果
 */
+ (BOOL)ly_stringIsValidUrl:(NSString *)string;

/**
 判读是否邮政编码

 @param string 要被判断的字符串

 @return 结果
 */
+ (BOOL)ly_stringIsValidPostalcode:(NSString *)string;

/**
 检查密码强度

 @param minLenth              账号最小长度
 @param maxLenth              账号最大长度
 @param containChinese        是否要包含中文
 @param containDigtal         是否要包含数字
 @param containLetter         是否要包含字母
 @param containOtherCharacter 是否要包含其他字符
 @param firstCannotBeDigtal   首字母是否要大写
 @param string                密码

 @return 结果
 */
+ (BOOL)ly_stringIsValidWithMinLenth:(NSInteger)minLenth
                            maxLenth:(NSInteger)maxLenth
                      containChinese:(BOOL)containChinese
                       containDigtal:(BOOL)containDigtal
                       containLetter:(BOOL)containLetter
               containOtherCharacter:(NSString *)containOtherCharacter
                 firstCannotBeDigtal:(BOOL)firstCannotBeDigtal
                           ly_string:(NSString *)string;

/**
 去掉两端空格和换行符

 @param string 被判断的字符串

 @return 结果
 */
+ (instancetype)ly_stringRemoveBlank:(NSString *)string;

/**
 去掉html格式
 
 @param string 要被判读的字符串
 
 @return 结果
 */
+ (instancetype)ly_stringRemoveHtmlFormat:(NSString *)string;

/**
 判读是否是工商税号

 @param string 要被判读的字符串

 @return 结果
 */
+ (BOOL)ly_stringIsValidTaxNo:(NSString *)string;

/**
 *  md5加密
 *
 *  @param str 要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+ (instancetype)ly_stringWithMD5:(NSString *)str;

/**
 *  sha1加密
 *
 *  @param str 要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+ (instancetype)ly_stringWithsha1:(NSString *)str;


/**
 *  获取客户端网络IP
 *
 *  @return 返回客户端网络IP
 */
+ (instancetype)ly_stringGetIP;

/**
 *  生成任意长度的随机数
 *
 *  @param random 长度
 *
 *  @return 随机数
 */
+ (instancetype)ly_stringWithRandom:(NSInteger)random;

/**
 *  返回url能识别的字符串
 */
+ (instancetype)ly_stringWithUTF8:(NSString *)urlStr;


/**
 返回字符串的宽高

 @param string     要判断的字符串
 @param fontSize   字体大小

 @return 结果
 */
+ (CGSize)ly_stringWithString:(NSString *)string fontSize:(CGFloat)fontSize size:(CGSize)size;

/**
 获取回话中当前消息的时间，根据时间情况返回

 @param time 回话中消息的时间

 @return 结果
 */
+ (instancetype)ly_conversationTime:(long long)time;

@end
