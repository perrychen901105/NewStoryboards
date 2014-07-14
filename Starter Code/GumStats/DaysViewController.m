
#import "DaysViewController.h"
#import "GraphViewController.h"
#import "Record.h"

@implementation DaysViewController
{
	NSArray *_records;
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

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	// Redraw after we come back from the Measurements View Controller,
	// because the total may have changed.
	[self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"ShowGraph"])
	{
		NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
		GraphViewController *controller = segue.destinationViewController;
		Record *record = _records[indexPath.row];
		controller.record = record;
	}
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_records count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

	Record *record = _records[indexPath.row];
	cell.textLabel.text = [record dateForDisplay];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"Total: %d", record.total];

	return cell;
}

@end
