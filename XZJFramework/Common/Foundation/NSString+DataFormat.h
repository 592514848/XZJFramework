//
//  NSString+DataFormat.h
//  Giivv
//
//  Created by Xiong, Zijun on 16/4/24.
//  Copyright © 2016 Youdar . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DataFormat)
/**
 *  initization price formation
 *
 *  @param price price value
 *
 *  @return after formate string
 */
+ (NSString *)stringWithPriceFormate: (double) price;

/**
 *  validate email format
 *
 *  @return result
 */
- (BOOL)isEmail;

/**
 *  password length is legal
 *
 *  @return result
 */
- (BOOL)isLegalPasswordLength;

/**
 *  validate phone formate (USA phone)
 *
 *  @return result
 */
- (BOOL)isUSAPhone;

/**
 *  formate phone with (USA phone)
 *
 *  @return string after formate
 */
- (NSString *)formateWithUSAPhone;

- (NSString *)randomFileName:(NSString *)externName;

- (BOOL)isPureInt;
@end
