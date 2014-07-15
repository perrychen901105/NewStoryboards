
#import "EditViewController.h"

@interface EditViewController ()<UIActionSheetDelegate>
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@end

@implementation EditViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.textField.text = [NSString stringWithFormat:@"%d", self.value];
//	[self.textField becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.presentingViewController != nil) {
        [self.textField becomeFirstResponder];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)delete:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Really delete?"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:@"Delete"
                                                    otherButtonTitles: nil];
    [actionSheet showFromRect:self.deleteButton.frame inView:self.view animated:YES];
}

#pragma mark - UIActionsheet methods
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        [self performSegueWithIdentifier:@"DeleteValue" sender:nil];
    }
}

//
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"DoneEdit"]) {
        if ([self.textField.text length] > 0) {
            int value = [self.textField.text intValue];
            if (value >= 0 && value <= 100) {
                return YES;
            }
            [[[UIAlertView alloc] initWithTitle:nil
                                       message:@"Value must be between 0 and 100"
                                      delegate:nil cancelButtonTitle:@"OK"
                              otherButtonTitles: nil] show];
            return NO;
        }
        return YES;
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DoneEdit"]) {
        self.value = [self.textField.text intValue];
    } else if ([segue.identifier isEqualToString:@"CancelEdit"]) {
        NSLog(@"b");
    }
}

@end
