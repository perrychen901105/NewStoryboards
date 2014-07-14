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

@interface CombinedViewController ()

@property (nonatomic, weak) DaysViewController *daysViewController;
@property (nonatomic, weak) GraphViewController *graphViewController;

@end

@implementation CombinedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
        UINavigationController *navigationController = segue.destinationViewController;
        self.daysViewController = (DaysViewController *)navigationController.topViewController;
    } else if ([segue.identifier isEqualToString:@"EmbedGraph"]) {
        self.graphViewController = segue.destinationViewController;
    }
}


@end
