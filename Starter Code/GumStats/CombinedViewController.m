//
//  CombinedViewController.m
//  GumStats
//
//  Created by Perry on 14-7-14.
//  Copyright (c) 2014年 Hollance. All rights reserved.
//

#import "CombinedViewController.h"
#import "DaysViewController.h"
#import "GraphViewController.h"

#import "Record.h"

@interface CombinedViewController ()

@property (nonatomic, weak) DaysViewController *daysViewController;
@property (nonatomic, weak) GraphViewController *graphViewController;

@end

@implementation CombinedViewController
{
    NSArray *_records;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder]))
	{
		// Fill up the array with Record objects, and sort by date.
		_records =
        [@[
           [self makeFakeRecord],
           [self makeFakeRecord],
           [self makeFakeRecord],
           [self makeFakeRecord],
           [self makeFakeRecord],
           ]
         sortedArrayUsingComparator:^NSComparisonResult(Record *record1, Record *record2)
         {
             return [record1.date compare:record2.date];
         }];
	}
	return self;
}



//- (IBAction)cancel:(UIStoryboardSegue *)segue
//{
//    
//}

- (Record *)makeFakeRecord
{
	// A Record contains a date and up to 24 NSNumber objects (one for each
	// hour in the day). We first calculate a random fake date in the past,
	// and then create NSNumber objects with random values between 0 and 100.
    
	NSTimeInterval timeInterval = (int)arc4random_uniform(10000000) * -1;
	NSDate *date = [NSDate dateWithTimeIntervalSinceNow:timeInterval];
    
	NSMutableArray *values = [NSMutableArray array];
	for (int t = 0; t < 24; ++t)
	{
		[values addObject:@(arc4random_uniform(100))];
	}
    
	return [[Record alloc] initWithDate:date values:values];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.daysViewController.graphViewController = self.graphViewController;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"EmbedDays"]) {
        self.daysViewController = segue.destinationViewController;
        self.daysViewController.records = _records;
    } else if ([segue.identifier isEqualToString:@"EmbedGraph"]) {
        self.graphViewController = segue.destinationViewController;
    }
}


@end
