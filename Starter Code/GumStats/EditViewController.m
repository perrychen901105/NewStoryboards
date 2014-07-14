
#import "EditViewController.h"

@interface EditViewController ()
@property (nonatomic, weak) IBOutlet UITextField *textField;
@end

@implementation EditViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.textField.text = [NSString stringWithFormat:@"%d", self.value];
	[self.textField becomeFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancel:(id)sender
{
	[self.delegate editViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender
{
	int newValue = [self.textField.text intValue];
	[self.delegate editViewController:self didChangeValue:newValue];
}

@end
