//
//  DZRParsableObject.h
//  DeezerExercice
//
//  Created by CHEN Bin on 17/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZRParsable.h"

@interface DZRParsableObject : NSObject <DZRParsable>

@property (nonatomic, strong) NSString *identifier;

@end
