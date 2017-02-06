//
//  PrimeNumberHelper.m
//  SimpleNumberSearcher
//
//  Created by Nazar Yavornytskyy on 2/6/17.
//  Copyright © 2017 @NazarYavornytskyy. All rights reserved.
//

#import "PrimeNumberHelper.h"

@implementation PrimeNumberHelper

+(instancetype)sharedInstance{
    static PrimeNumberHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PrimeNumberHelper alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (BOOL)isPrime:(int)number{
    BOOL isPrime = YES;
    
    if (number <= 1) {
        isPrime = YES;
    }
    
    if (number != 2 && number != 1){
        
        for (int i = 2; i < number; i++){
            
            if (number % i == 0) {
                isPrime = NO;
            }
        }
    }
    return isPrime;
}

@end
