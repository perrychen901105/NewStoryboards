
@class EditViewController;

@protocol EditViewControllerDelegate <NSObject>

- (void)editViewControllerDidCancel:(EditViewController *)controller;
- (void)editViewController:(EditViewController *)controller didChangeValue:(int)newValue;

@end

@interface EditViewController : UIViewController

@property (nonatomic, weak) id <EditViewControllerDelegate> delegate;
@property (nonatomic, assign) int value;

@end
