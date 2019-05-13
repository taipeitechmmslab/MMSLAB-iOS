//
//  MRTModel.h
//  Lab13-API
//
//  Created by 張力元 on 2019/4/29.
//  Copyright © 2019 張力元. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface results : NSObject
@property (strong, nonatomic) NSString *Station;
@property (strong, nonatomic) NSString *Destination;
@end

@interface result : NSObject
@property (strong, nonatomic) NSArray<results *> *results;
@end

@interface MRTModel : NSObject
@property (strong, nonatomic) result *result;
@end



NS_ASSUME_NONNULL_END
