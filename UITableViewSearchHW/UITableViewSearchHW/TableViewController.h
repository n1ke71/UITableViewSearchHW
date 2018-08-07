//
//  TableViewController.h
//  UITableViewSearchHW
//
//  Created by Ivan Kozaderov on 21.07.2018.
//  Copyright © 2018 n1ke71. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    DateNameLastName,
    NameLastNameDate,
    LastNameDateName
} SortingOrder;

@interface TableViewController : UITableViewController
@property (assign,nonatomic) SortingOrder order;
@end
