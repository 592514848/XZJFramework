//
//  NSString+DataFormat.m
//  Giivv
//
//  Created by Xiong, Zijun on 16/4/24.
//  Copyright © 2016 Youdar . All rights reserved.
//

#import "NSString+DataFormat.h"

@implementation NSString (DataFormat)
#pragma mark - price string formation
+ (NSString *)stringWithPriceFormate: (double) price{
    return  [NSString stringWithFormat: @"$%.0f", price];
}

#pragma mark- validate email data format
- (BOOL)isEmail{
    if(IsStrEmpty(self)){
        return NO;
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject: self];
}

#pragma mark - password length is legal
- (BOOL)isLegalPasswordLength{
    if([self length] >= 6 && [self length] <= 16){
        return YES;
    }
    return NO;
}

#pragma mark - validate phone formate (USA phone)
- (BOOL)isUSAPhone{
    if(IsStrEmpty(self)){
        return NO;
    }
//    NSString *phoneRegex = @"([+]?\\d{1,2}[-\\s]?|)\\d{3}[-\\s]?\\d{3}[-\\s]?\\d{4}";
    NSString *phoneRegex = @"^(1)?[-. ]?\\(?([0-9]{3})\\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject: self];
}

#pragma mark - formate phone with (USA phone)
- (NSString *)formateWithUSAPhone{
    if([self length] == 10){
        NSMutableString *string = [NSMutableString stringWithString: self];
        [string insertString: @"-" atIndex: 6];
        [string insertString: @") " atIndex: 3];
        [string insertString: @"(" atIndex: 0];
        return string;
    }
    return self;
}

#pragma mark - random file name
- (NSString *)randomFileName:(NSString *)externName{
    return [NSString stringWithFormat: @"%@%@%@",self, [[NSDate date] stringFormate: @"yyyyMMddHHmmssSSS"], externName];
}

#pragma mark - is int
- (BOOL)isPureInt{
    NSScanner *scan = [NSScanner scannerWithString: self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}
@end
