//
//  PrimeNumberHelper.h
//  SimpleNumberSearcher
//
//  Created by Nazar Yavornytskyy on 2/6/17.
//  Copyright © 2017 @NazarYavornytskyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrimeNumberHelper : NSObject

+(instancetype)sharedInstance;

- (BOOL)isPrime:(int)number;

@end
