//
//  Student.m
//  UITableViewSearchHW
//
//  Created by Ivan Kozaderov on 21.07.2018.
//  Copyright © 2018 n1ke71. All rights reserved.
//

#import "Student.h"

#define ONESECOND 1
#define ONEMINUTE ONESECOND*60
#define ONEHOUR   ONEMINUTE*60
#define ONEDAY    ONEHOUR*24
#define ONEYEAR   ONEDAY*365

@implementation Student

static NSString* firstNames[] = {
    @"Tran", @"Lenore", @"Bud", @"Fredda", @"Katrice",
    @"Clyde", @"Hildegard", @"Vernell", @"Nellie", @"Rupert",
    @"Billie", @"Tamica", @"Crystle", @"Kandi", @"Caridad",
    @"Vanetta", @"Taylor", @"Pinkie", @"Ben", @"Rosanna",
    @"Eufemia", @"Britteny", @"Ramon", @"Jacque", @"Telma",
    @"Colton", @"Monte", @"Pam", @"Tracy", @"Tresa",
    @"Willard", @"Mireille", @"Roma", @"Elise", @"Trang",
    @"Ty", @"Pierre", @"Floyd", @"Savanna", @"Arvilla",
    @"Whitney", @"Denver", @"Norbert", @"Meghan", @"Tandra",
    @"Jenise", @"Brent", @"Elenor", @"Sha", @"Jessie"
};

static NSString* lastNames [] = {
    
    @"Farrah", @"Laviolette", @"Heal", @"Sechrest", @"Roots",
    @"Homan", @"Starns", @"Oldham", @"Yocum", @"Mancia",
    @"Prill", @"Lush", @"Piedra", @"Castenada", @"Warnock",
    @"Vanderlinden", @"Simms", @"Gilroy", @"Brann", @"Bodden",
    @"Lenz", @"Gildersleeve", @"Wimbish", @"Bello", @"Beachy",
    @"Jurado", @"William", @"Beaupre", @"Dyal", @"Doiron",
    @"Plourde", @"Bator", @"Krause", @"Odriscoll", @"Corby",
    @"Waltman", @"Michaud", @"Kobayashi", @"Sherrick", @"Woolfolk",
    @"Holladay", @"Hornback", @"Moler", @"Bowles", @"Libbey",
    @"Spano", @"Folson", @"Arguelles", @"Burke", @"Rook"
};

+ (Student *)randomStudent{
    
    static unsigned int countFirstNames = sizeof(firstNames) / sizeof(firstNames[0]);
    static unsigned int countlastNames  = sizeof(lastNames) / sizeof(lastNames[0]);
    Student *student = [[Student alloc]init];
    student.name = firstNames[arc4random_uniform(countFirstNames)];
    student.lastName = lastNames[arc4random_uniform(countlastNames)];
    double timeInterval = arc4random_uniform(ONEYEAR);
    student.birthDate = [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
    return student;
}

- (NSString *)stringFromDate:(NSDate *)date{

    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    return [formatter stringFromDate:date];
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@ %@", self.name,self.lastName];
}
@end
