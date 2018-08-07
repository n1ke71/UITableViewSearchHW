//
//  TableViewController.m
//  UITableViewSearchHW
//
//  Created by Ivan Kozaderov on 21.07.2018.
//  Copyright © 2018 n1ke71. All rights reserved.
//

#import "TableViewController.h"
#import "Student.h"
#import "Section.h"

@interface TableViewController () <UISearchBarDelegate>
- (IBAction)actonControl:(UISegmentedControl *)sender;
@property (weak,nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sortControl;
@property (strong, nonatomic) NSMutableArray *students;
@property (strong, nonatomic) NSMutableArray *sections;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sections = [NSMutableArray array];
    self.students = [NSMutableArray array];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < arc4random_uniform(5) + 40; i++) {
        
        Student *student = [Student randomStudent];
        [array addObject:student];
    }

    self.students = [self sortingArray:array];
    self.sections = [self generateSectionsFromArray:self.students withFilter:self.searchBar.text];
    [self.tableView reloadData];
    self.order = (SortingOrder)self.sortControl.selectedSegmentIndex;
    
}
#pragma mark - Methods

- (NSMutableArray *)generateSectionsFromArray:(NSMutableArray *)array withFilter:(NSString *)filterString{

     NSMutableArray *sectionsArray = [NSMutableArray array];
    
    if (self.order == DateNameLastName) {

        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"MMMM"];
        NSString *currentMonth = nil;
        
    for (Student *student in array) {
        NSString *month = [formatter stringFromDate:student.birthDate];
        NSString *name = student.name;
        NSString *lastName = student.lastName;
        Section *section = nil;
        
        if ([self filter:name withFilter:filterString]) {
            if ([self filter:lastName withFilter:filterString]){
                continue;
            }
        }

        if (![currentMonth isEqualToString:month]) {
            section = [[Section alloc]init];
            section.name = month;
            section.items = [NSMutableArray array];
            currentMonth = month;
            [sectionsArray addObject:section];
        }else{
            section = [sectionsArray lastObject];
        }
        
        [section.items addObject:student];
    }
}
    
    if (self.order == NameLastNameDate){
        
        NSString *currentLetter = nil;
        
        for (Student *student in array) {
            NSString *name = student.name;
            NSString *lastName = student.lastName;
            Section *section = nil;
            
            if ([self filter:name withFilter:filterString]) {
                if ([self filter:lastName withFilter:filterString]){
                    continue;
                }
            }

            if (![currentLetter isEqualToString:[name substringToIndex:1]]) {
                section = [[Section alloc]init];
                section.name = [name substringToIndex:1];
                section.items = [NSMutableArray array];
                currentLetter = [name substringToIndex:1];
                [sectionsArray addObject:section];
            }else{
                section = [sectionsArray lastObject];
            }
            
            [section.items addObject:student];
        }
    }

    if (self.order == LastNameDateName){
        
        NSString *currentLetter = nil;
        
        for (Student *student in array) {
            NSString *name = student.name;
            NSString *lastName = student.lastName;
            Section *section = nil;
            
            if ([self filter:lastName withFilter:filterString]) {
                if ([self filter:name withFilter:filterString]){
                    continue;
                }
            }
            
            if (![currentLetter isEqualToString:[lastName substringToIndex:1]]) {
                section = [[Section alloc]init];
                section.name = [lastName substringToIndex:1];
                section.items = [NSMutableArray array];
                currentLetter = [lastName substringToIndex:1];
                [sectionsArray addObject:section];
            }else{
                section = [sectionsArray lastObject];
            }
            
            [section.items addObject:student];
        }
    }
    return sectionsArray;
    
}

- (BOOL) filter:(NSString *)string withFilter:(NSString *)filterString{
   
    return [filterString length] > 0 && [string rangeOfString:filterString].location == NSNotFound;
}

- (NSMutableArray *)sortingArray:(NSMutableArray *)array{
 
    NSSortDescriptor *date = [[NSSortDescriptor alloc]initWithKey:@"birthDate" ascending:YES];
    NSSortDescriptor *name = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    NSSortDescriptor *lastName = [[NSSortDescriptor alloc]initWithKey:@"lastName" ascending:YES];
    
    switch (self.order) {
        case DateNameLastName:
            [array sortUsingDescriptors:@[date,name,lastName]];
            return array;
            break;
        case NameLastNameDate:
            [array sortUsingDescriptors:@[name,lastName,date]];
            return array;
            break;
        case LastNameDateName:
            [array sortUsingDescriptors:@[lastName,date,name]];
            return array;
            break;

    }

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    Section *sec =  [self.sections objectAtIndex:section]; 
    return [sec.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    Section *sec =  [self.sections objectAtIndex:indexPath.section];
    Student *student = [sec.items objectAtIndex:indexPath.row];
    cell.textLabel.text = [student description];
    cell.detailTextLabel.text = [student stringFromDate:student.birthDate];
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [[self.sections objectAtIndex:section] name];
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    NSMutableArray *array = [NSMutableArray array];
    if (self.order == DateNameLastName){
    for (Section *section in self.sections) {
        [array addObject:[section.name substringToIndex:1]];
    }
}
    return array;
}
#pragma mark - UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
     self.sections = [self generateSectionsFromArray:self.students withFilter:self.searchBar.text];
    [self.tableView reloadData];
}

- (IBAction)actonControl:(UISegmentedControl *)sender {
    
    self.order = (SortingOrder)sender.selectedSegmentIndex;
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.students = [self sortingArray:self.students];
            self.sections = [self generateSectionsFromArray:self.students withFilter:self.searchBar.text];
            [self.tableView reloadData];
            break;
        case 1:
            self.students = [self sortingArray:self.students];
            self.sections = [self generateSectionsFromArray:self.students withFilter:self.searchBar.text];
            [self.tableView reloadData];
            break;
        case 2:
            self.students = [self sortingArray:self.students];
            self.sections = [self generateSectionsFromArray:self.students withFilter:self.searchBar.text];
            [self.tableView reloadData];
            break;
        default:
            break;
    }

}
@end
