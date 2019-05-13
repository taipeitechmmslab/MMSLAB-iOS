//
//  BookTable.h
//  Lab12-BookStore
//
//  Created by 張力元 on 2019/4/25.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookTable : RLMObject
@property NSString *bookName;   //書名
@property int price;            //售價
@end

NS_ASSUME_NONNULL_END
