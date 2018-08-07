//
//  Section.h
//  UITableViewSearchHW
//
//  Created by Ivan Kozaderov on 21.07.2018.
//  Copyright © 2018 n1ke71. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Section : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray *items;

@end
