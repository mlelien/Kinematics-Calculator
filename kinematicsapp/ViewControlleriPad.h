#import <UIKit/UIKit.h>
#import "Problem.h"
#import "GADBannerView.h"

@interface ViewControlleriPad : UIViewController <UITextFieldDelegate>
{
    Problem *problem;
    GADBannerView *bannerView;
}

@property (weak, nonatomic) IBOutlet UILabel *displacement;
@property (weak, nonatomic) IBOutlet UILabel *acceleration;
@property (weak, nonatomic) IBOutlet UILabel *initialVelocity;
@property (weak, nonatomic) IBOutlet UILabel *finalVelocity;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UITextField *displacementTextField;
@property (weak, nonatomic) IBOutlet UITextField *accelerationTextField;
@property (weak, nonatomic) IBOutlet UITextField *initialVeloctiyTextField;
@property (weak, nonatomic) IBOutlet UITextField *finalVelocityTextField;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;

@property (weak, nonatomic) IBOutlet UIButton *clearButton;

- (IBAction)clear;

- (IBAction)displacementInput:(UITextField *)sender;
- (IBAction)accelerationInput:(UITextField *)sender;
- (IBAction)initialVelocityInput:(UITextField *)sender;
- (IBAction)finalVelocityInput:(UITextField *)sender;
- (IBAction)timeInput:(UITextField *)sender;

- (BOOL)enoughDataEntered;

@end
