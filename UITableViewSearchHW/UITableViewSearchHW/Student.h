//
//  Student.h
//  UITableViewSearchHW
//
//  Created by Ivan Kozaderov on 21.07.2018.
//  Copyright © 2018 n1ke71. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSDate *birthDate;
+ (Student *)randomStudent;
- (NSString *)stringFromDate:(NSDate *)date;
@end
