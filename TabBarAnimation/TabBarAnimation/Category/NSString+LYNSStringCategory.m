//
//  NSString+LYNSStringCategory.m
//  LYNSStringCategory
//
//  Created by liyang on 16/3/29.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "NSString+LYNSStringCategory.h"
#import <CommonCrypto/CommonDigest.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation NSString (LYNSStringCategory)

#pragma mark - 利用正则表达式获取url中的参数对应的key
+ (instancetype)ly_stringGetValueFromUrlStr:(NSString *)webaddress WithKey:(NSString *)CS
{
    NSError *error;
    NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)",CS];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *matches = [regex matchesInString:webaddress
                                      options:0
                                        range:NSMakeRange(0, [webaddress length])];
    for (NSTextCheckingResult *match in matches) {
        NSString *tagValue = [webaddress substringWithRange:[match rangeAtIndex:2]];
        return tagValue;
    }
    return nil;
}

#pragma mark -- 时间戳转年龄
+ (instancetype)ly_stringGetAgeByTime:(long)totoal
{
    NSDate *selectDate = [NSDate dateWithTimeIntervalSince1970:totoal];
    //选择的日期到现在日期的距离(算年龄)
    NSTimeInterval dateDiff = [selectDate timeIntervalSinceNow];
    int ageDate = trunc(dateDiff/(60*60*24))/365;
    NSString *ageString = [NSString stringWithFormat:@"%d",abs(ageDate)];
    return ageString;
}

#pragma mark -- 时间戳转星座
+ (instancetype)ly_stringGetConstellationByTime:(long)totoal
{
    
    NSDate *selectDate = [NSDate dateWithTimeIntervalSince1970:totoal];
    //算出选择的月份
    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"MM"];//设置样式
    NSString *month = [monthFormatter stringFromDate:selectDate];//选择日期
    
    //算出选择的哪天
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setDateFormat:@"dd"];//设置样式
    NSString *day = [dayFormatter stringFromDate:selectDate];
    //根据年月日来判断星座
    NSString *constellation = @"魔羯座水瓶座双鱼座白羊座金牛座双子座巨蟹座狮子座处女座天秤座天蝎座射手座魔羯座";
    NSString *astroFormat = @"102123444543";
    NSString *result = [NSString stringWithFormat:@"%@",[constellation substringWithRange:NSMakeRange([month intValue] * 3 - ([day intValue] < [[astroFormat substringWithRange:NSMakeRange(([month intValue] - 1), 1)] intValue] - ( - 19)) * 3,3)]];
    return result;
}

#pragma mark - 判断字符串中是否有中文
+ (BOOL)ly_stringIsContainChineseWithStr:(NSString *)string
{
    for(int i=0; i< [string length];i++){
        int a = [string characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

#pragma mark -- 判断是否为QQ号
+ (BOOL)ly_stringIsQQNumber:(NSString *)string
{
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]{5,15}$" options:0 error:nil];
    if (regex) {
        NSTextCheckingResult * resulte = [regex firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
        if (resulte) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return NO;
}

#pragma mark -- 判断是否为手机号
+ (BOOL)ly_stringIsPhoneNumber:(NSString *)string;
{
    //手机号筛选
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"^[1][358][0-9]{9}" options:0 error:nil];
    if (regex) {
        NSTextCheckingResult * resulte = [regex firstMatchInString:string options:0 range:NSMakeRange(0,string.length)];
        if (resulte) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return NO;
}

#pragma mark -- 判断是否为数字
+ (BOOL)ly_stringIsNumber:(NSString *)string
{
    //设置筛选条件
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]*$" options:0 error:nil];
    if (regex) {
        NSTextCheckingResult * resulte = [regex firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
        if (resulte) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return NO;
}

#pragma mark - 判断是否是邮箱号
+ (BOOL)ly_stringIsValidEmail:(NSString *)string
{
    NSString *phoneRegex = @"^[0-8]\\d{5}(?!\\d)$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

#pragma mark - 判断是否是车牌号
+ (BOOL)ly_stringIsValidCarNo:(NSString *)string
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:string];
}

#pragma mark - 是否是有效网址
+ (BOOL)ly_stringIsValidUrl:(NSString *)string
{
    NSString *regex = @"^((http)|(https))+:[^\\s]+\\.[^\\s]*$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pre evaluateWithObject:string];
}

#pragma mark - 邮政编码
+ (BOOL)ly_stringIsValidPostalcode:(NSString *)string
{
    NSString *phoneRegex = @"^[0-8]\\d{5}(?!\\d)$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:string];
}

#pragma mark - 检查密码强度
+ (BOOL)ly_stringIsValidWithMinLenth:(NSInteger)minLenth
                            maxLenth:(NSInteger)maxLenth
                      containChinese:(BOOL)containChinese
                       containDigtal:(BOOL)containDigtal
                       containLetter:(BOOL)containLetter
               containOtherCharacter:(NSString *)containOtherCharacter
                 firstCannotBeDigtal:(BOOL)firstCannotBeDigtal
                           ly_string:(NSString *)string
{
    // 判断密码最大长度和最小长度
    NSString *lengthRegex = [NSString stringWithFormat:@"(?=^.{%@,%@}$)", @(minLenth), @(maxLenth)];
    
    // 是否包含汉字
    NSString *hanzi = containChinese ? @"\u4e00-\u9fa5" : @"";
    
    // 是否包含数字
    NSString *digtalRegex = containDigtal ? @"(?=(.*\\d.*){1})" : @"";
    
    // 是否包字母
    NSString *letterRegex = containLetter ? @"(?=(.*[a-zA-Z].*){1})" : @"";
    
    // 首字母大写
    NSString *first = firstCannotBeDigtal ? @"^[a-zA-Z_]" : @"";
    
    // 是否包含其他字符
    NSString *characterRegex = [NSString stringWithFormat:@"(?:%@[%@A-Za-z0-9%@]+)", first, hanzi, containOtherCharacter ? containOtherCharacter : @""];
    
    // 设置谓词检查密码
    NSString *regex = [NSString stringWithFormat:@"%@%@%@%@", lengthRegex, digtalRegex, letterRegex, characterRegex];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:string];
}

#pragma mark - 去掉两端空格和换行符
+ (instancetype)ly_stringRemoveBlank:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark - 去掉html格式
+ (instancetype)ly_stringRemoveHtmlFormat:(NSString *)string
{
    NSString *str = [NSString stringWithFormat:@"%@", string];
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<[^>]*>" options:NSRegularExpressionCaseInsensitive error:&error];
    if (!error) {
        str = [regex stringByReplacingMatchesInString:str options:0 range:NSMakeRange(0, str.length) withTemplate:@"$2$1"];
    } else {
        NSLog(@"%@", error);
    }
    
    NSArray *html_code = @[
                           @"\"", @"'", @"&", @"<", @">",
                           @"", @"¡", @"¢", @"£", @"¤",
                           @"¥", @"¦", @"§", @"¨", @"©",
                           @"ª", @"«", @"¬", @"", @"®",
                           @"¯", @"°", @"±", @"²", @"³",
                           
                           @"´", @"µ", @"¶", @"·", @"¸",
                           @"¹", @"º", @"»", @"¼", @"½",
                           @"¾", @"¿", @"×", @"÷", @"À",
                           @"Á", @"Â", @"Ã", @"Ä", @"Å",
                           @"Æ", @"Ç", @"È", @"É", @"Ê",
                           
                           @"Ë", @"Ì", @"Í", @"Î", @"Ï",
                           @"Ð", @"Ñ", @"Ò", @"Ó", @"Ô",
                           @"Õ", @"Ö", @"Ø", @"Ù", @"Ú",
                           @"Û", @"Ü", @"Ý", @"Þ", @"ß",
                           @"à", @"á", @"â", @"ã", @"ä",
                           
                           @"å", @"æ", @"ç", @"è", @"é",
                           @"ê", @"ë", @"ì", @"í", @"î",
                           @"ï", @"ð", @"ñ", @"ò", @"ó",
                           @"ô", @"õ", @"ö", @"ø", @"ù",
                           @"ú", @"û", @"ü", @"ý", @"þ",
                           
                           @"ÿ", @"∀", @"∂", @"∃", @"∅",
                           @"∇", @"∈", @"∉", @"∋", @"∏",
                           @"∑", @"−", @"∗", @"√", @"∝",
                           @"∞", @"∠", @"∧", @"∨", @"∩",
                           @"∪", @"∫", @"∴", @"∼", @"≅",
                           
                           @"≈", @"≠", @"≡", @"≤", @"≥",
                           @"⊂", @"⊃", @"⊄", @"⊆", @"⊇",
                           @"⊕", @"⊗", @"⊥", @"⋅", @"Α",
                           @"Β", @"Γ", @"Δ", @"Ε", @"Ζ",
                           @"Η", @"Θ", @"Ι", @"Κ", @"Λ",
                           
                           @"Μ", @"Ν", @"Ξ", @"Ο", @"Π",
                           @"Ρ", @"Σ", @"Τ", @"Υ", @"Φ",
                           @"Χ", @"Ψ", @"Ω", @"α", @"β",
                           @"γ", @"δ", @"ε", @"ζ", @"η",
                           @"θ", @"ι", @"κ", @"λ", @"μ",
                           
                           @"ν", @"ξ", @"ο", @"π", @"ρ",
                           @"ς", @"σ", @"τ", @"υ", @"φ",
                           @"χ", @"ψ", @"ω", @"ϑ", @"ϒ",
                           @"ϖ", @"Œ", @"œ", @"Š", @"š",
                           @"Ÿ", @"ƒ", @"ˆ", @"˜", @"",
                           
                           @"", @"", @"", @"", @"",
                           @"", @"–", @"—", @"‘", @"’",
                           @"‚", @"“", @"”", @"„", @"†",
                           @"‡", @"•", @"…", @"‰", @"′",
                           @"″", @"‹", @"›", @"‾", @"€",
                           
                           @"™", @"←", @"↑", @"→", @"↓",
                           @"↔", @"↵", @"⌈", @"⌉", @"⌊",
                           @"⌋", @"◊", @"♠", @"♣", @"♥",
                           @"♦",
                           ];
    NSArray *code = @[
                      @"&quot;", @"&apos;", @"&amp;", @"&lt;", @"&gt;",
                      @"&nbsp;", @"&iexcl;", @"&cent;", @"&pound;", @"&curren;",
                      @"&yen;", @"&brvbar;", @"&sect;", @"&uml;", @"&copy;",
                      @"&ordf;", @"&laquo;", @"&not;", @"&shy;", @"&reg;",
                      @"&macr;", @"&deg;", @"&plusmn;", @"&sup2;", @"&sup3;",
                      
                      @"&acute;", @"&micro;", @"&para;", @"&middot;", @"&cedil;",
                      @"&sup1;", @"&ordm;", @"&raquo;", @"&frac14;", @"&frac12;",
                      @"&frac34;", @"&iquest;", @"&times;", @"&divide;", @"&Agrave;",
                      @"&Aacute;", @"&Acirc;", @"&Atilde;", @"&Auml;", @"&Aring;",
                      @"&AElig;", @"&Ccedil;", @"&Egrave;", @"&Eacute;", @"&Ecirc;",
                      
                      @"&Euml;", @"&Igrave;", @"&Iacute;", @"&Icirc;", @"&Iuml;",
                      @"&ETH;", @"&Ntilde;", @"&Ograve;", @"&Oacute;", @"&Ocirc;",
                      @"&Otilde;", @"&Ouml;", @"&Oslash;", @"&Ugrave;", @"&Uacute;",
                      @"&Ucirc;", @"&Uuml;", @"&Yacute;", @"&THORN;", @"&szlig;",
                      @"&agrave;", @"&aacute;", @"&acirc;", @"&atilde;", @"&auml;",
                      
                      @"&aring;", @"&aelig;", @"&ccedil;", @"&egrave;", @"&eacute;",
                      @"&ecirc;", @"&euml;", @"&igrave;", @"&iacute;", @"&icirc;",
                      @"&iuml;", @"&eth;", @"&ntilde;", @"&ograve;", @"&oacute;",
                      @"&ocirc;", @"&otilde;", @"&ouml;", @"&oslash;", @"&ugrave;",
                      @"&uacute;", @"&ucirc;", @"&uuml;", @"&yacute;", @"&thorn;",
                      
                      @"&yuml;", @"&forall;", @"&part;", @"&exists;", @"&empty;",
                      @"&nabla;", @"&isin;", @"&notin;", @"&ni;", @"&prod;",
                      @"&sum;", @"&minus;", @"&lowast;", @"&radic;", @"&prop;",
                      @"&infin;", @"&ang;", @"&and;", @"&or;", @"&cap;",
                      @"&cup;", @"&int;", @"&there4;", @"&sim;", @"&cong;",
                      
                      @"&asymp;", @"&ne;", @"&equiv;", @"&le;", @"&ge;",
                      @"&sub;", @"&sup;", @"&nsub;", @"&sube;", @"&supe;",
                      @"&oplus;", @"&otimes;", @"&perp;", @"&sdot;", @"&Alpha;",
                      @"&Beta;", @"&Gamma;", @"&Delta;", @"&Epsilon;", @"&Zeta;",
                      @"&Eta;", @"&Theta;", @"&Iota;", @"&Kappa;", @"&Lambda;",
                      
                      @"&Mu;", @"&Nu;", @"&Xi;", @"&Omicron;", @"&Pi;",
                      @"&Rho;", @"&Sigma;", @"&Tau;", @"&Upsilon;", @"&Phi;",
                      @"&Chi;", @"&Psi;", @"&Omega;", @"&alpha;", @"&beta;",
                      @"&gamma;", @"&delta;", @"&epsilon;", @"&zeta;", @"&eta;",
                      @"&theta;", @"&iota;", @"&kappa;", @"&lambda;", @"&mu;",
                      
                      @"&nu;", @"&xi;", @"&omicron;", @"&pi;", @"&rho;",
                      @"&sigmaf;", @"&sigma;", @"&tau;", @"&upsilon;", @"&phi;",
                      @"&chi;", @"&psi;", @"&omega;", @"&thetasym;", @"&upsih;",
                      @"&piv;", @"&OElig;", @"&oelig;", @"&Scaron;", @"&scaron;",
                      @"&Yuml;", @"&fnof;", @"&circ;", @"&tilde;", @"&ensp;",
                      
                      @"&emsp;", @"&thinsp;", @"&zwnj;", @"&zwj;", @"&lrm;",
                      @"&rlm;", @"&ndash;", @"&mdash;", @"&lsquo;", @"&rsquo;",
                      @"&sbquo;", @"&ldquo;", @"&rdquo;", @"&bdquo;", @"&dagger;",
                      @"&Dagger;", @"&bull;", @"&hellip;", @"&permil;", @"&prime;",
                      @"&Prime;", @"&lsaquo;", @"&rsaquo;", @"&oline;", @"&euro;",
                      
                      @"&trade;", @"&larr;", @"&uarr;", @"&rarr;", @"&darr;",
                      @"&harr;", @"&crarr;", @"&lceil;", @"&rceil;", @"&lfloor;",
                      @"&rfloor;", @"&loz;", @"&spades;", @"&clubs;", @"&hearts;",
                      @"&diams;",
                      ];
    
    NSInteger idx = 0;
    for (NSString *obj in code) {
        str = [str stringByReplacingOccurrencesOfString:(NSString *)obj withString:html_code[idx]];
        idx++;
    }
    return str;
}

#pragma mark - 工商税号
+ (BOOL)ly_stringIsValidTaxNo:(NSString *)string
{
    NSString *emailRegex = @"[0-9]\\d{13}([0-9]|X)$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:string];
}

#pragma mark - md5加密
+ (instancetype)ly_stringWithMD5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2]; // 32位加密
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]]; // 决定输出的大小写(x是小写，X是大写)
    }
    return output;
}

#pragma mark - sha1加密
+ (instancetype)ly_stringWithsha1:(NSString *)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

#pragma mark - 获取客户端网络IP
+ (instancetype)ly_stringGetIP
{
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return address;
}

#pragma mark - 生成任意长度的随机数
+ (instancetype)ly_stringWithRandom:(NSInteger)random
{
    char data[random];
    for (NSInteger i = 0; i < random; i++) {
        data[i] = (char)('A' + (arc4random_uniform(26)));
    }
    return [[NSString alloc] initWithBytes:data length:random encoding:NSUTF8StringEncoding];
}

#pragma mark - 返回url能识别的字符串
+ (instancetype)ly_stringWithUTF8:(NSString *)urlStr
{
    return [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

#pragma mark - 返回字符串的宽高
+ (CGSize)ly_stringWithString:(NSString *)string fontSize:(CGFloat)fontSize size:(CGSize)size
{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGRect rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size;
}

#pragma mark - 返回回话中消息的时间
+ (instancetype)ly_conversationTime:(long long)time
{
    // 1.获取日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 2.获取当前时间
    NSDate *currentDate = [NSDate date];
    // 3.获取当前时间的年月日
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:currentDate];
    NSInteger currentYear = components.year;
    NSInteger currentMonth = components.month;
    NSInteger currentDay = components.day;
    
    // 4.获取发送时间
    NSDate *sendDate = [NSDate dateWithTimeIntervalSince1970:time/1000];
    // 5.获取发送时间的年月日
    NSDateComponents *sendComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:sendDate];
    NSInteger sendYear = sendComponents.year;
    NSInteger sendMonth = sendComponents.month;
    NSInteger sendDay = sendComponents.day;
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    
    if (currentYear == sendYear &&
        currentMonth == sendMonth &&
        currentDay == sendDay) {// 今天发送的
        fmt.dateFormat = @"今天 HH:mm";
    }else if(currentYear == sendYear &&
             currentMonth == sendMonth &&
             currentDay+1 == sendDay){// 昨天发的
        fmt.dateFormat = @"昨天 HH:mm";
    }else{// 前天以前发的
        fmt.dateFormat = @"MM月dd号";
    }
    
    return [fmt stringFromDate:sendDate];
}
@end
