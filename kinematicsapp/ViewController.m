#import "ViewController.h"

@interface ViewController()
@property (nonatomic, strong) NSLayoutConstraint *constraint;
@end

@implementation ViewController
{
    UIGestureRecognizer *tap;
    int numberOfDataFields;
    NSMutableArray *textFields;
    NSMutableArray *labels;
    UIView *answerCategoryView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.portraitAnswersView.hidden = YES;
    
    problem = [[Problem alloc] initWithdisplacement:NAN andAcceleration:NAN andInitialVelocity:NAN andFinalVelocity:NAN andTime:NAN];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:tap];
    
    textFields = [NSMutableArray arrayWithObjects: self.displacementTextField, self.accelerationTextField, self.initialVeloctiyTextField, self.finalVelocityTextField, self.timeTextField, nil];
    
    for (UITextField *textField in textFields)
        [textField setDelegate: self];
    
    labels = [NSMutableArray arrayWithObjects: self.displacement, self.acceleration, self.initialVelocity, self.finalVelocity, self.time, nil];
    
    bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner origin: CGPointMake(0, self.view.frame.size.width - kGADAdSizeBanner.size.height)];

    bannerView.adUnitID = @"ca-app-pub-7230276946752412/2398185687";
    bannerView.rootViewController = self;
    [self.view addSubview: bannerView];
    [bannerView loadRequest: [GADRequest request]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL enoughData = [self checkNumberOfData];
    if (enoughData)
    {
        [textField resignFirstResponder];
        return YES;
    }
    
    if (textField == self.displacementTextField)
    {
        [textField resignFirstResponder];
        [self.accelerationTextField becomeFirstResponder];
    }
    
    else if (textField == self.accelerationTextField)
    {
        [textField resignFirstResponder];
        [self.initialVeloctiyTextField becomeFirstResponder];
    }
    
    else if (textField == self.initialVeloctiyTextField)
    {
        [textField resignFirstResponder];
        [self.finalVelocityTextField becomeFirstResponder];
    }
    
    else if (textField == self.finalVelocityTextField)
    {
        [textField resignFirstResponder];
        [self.timeTextField becomeFirstResponder];
    }
    
    else if (textField == self.timeTextField)
        [textField resignFirstResponder];
    return YES;
}

- (void)dismissKeyboard:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
    [self checkNumberOfData];
}

- (BOOL)checkNumberOfData
{
    BOOL isEnoughDataEntered = [self enoughDataEntered];
    
    if (isEnoughDataEntered)
    {
        for (UITextField *textField in textFields)
        {
            if ([textField.text isEqualToString: @""])
            {
                textField.enabled = NO;
                textField.text = @"-";
            }
        }
        return YES;
    }
    return NO;
}

- (BOOL)enoughDataEntered
{
    numberOfDataFields = 0;
    for (UITextField *textField in textFields)
    {
        if (![textField.text isEqualToString: @""])
            numberOfDataFields++;
        if (numberOfDataFields >= 3)
            return true;
    }
    
    return false;
}

- (IBAction)clear
{
    for (UITextField *textField in textFields)
    {
        textField.text = @"";
        textField.enabled = YES;
    }
    
    for (UILabel *label in labels)
        label.text = @"";
    
    numberOfDataFields = 0;
    
    [problem clear];
}

- (void)isEmpty:(UITextField *)textField
{
    if (![textField.text isEqualToString: @""])
        return;
   
    for (UITextField *textField in textFields)
    {
        textField.enabled = YES;
        if ([textField.text isEqualToString: @""] || [textField.text isEqualToString: @"-"])
        {
            if (textField == self.displacementTextField)
            {
                self.displacement.text = @"";
                self.displacementTextField.text = @"";
                problem.displacement = NAN;
            }
            
            else if (textField == self.accelerationTextField)
            {
                self.acceleration.text = @"";
                self.accelerationTextField.text = @"";
                problem.acceleration = NAN;
            }
            
            else if (textField == self.initialVeloctiyTextField)
            {
                self.initialVelocity.text = @"";
                self.initialVeloctiyTextField.text = @"";
                problem.initialVelocity = NAN;
            }
            
            else if (textField == self.finalVelocityTextField)
            {
                self.finalVelocity.text = @"";
                self.finalVelocityTextField.text = @"";
                problem.finalVelocity = NAN;
            }
            
            else if (textField == self.timeTextField)
            {
                self.time.text = @"";
                self.timeTextField.text = @"";
                problem.time = NAN;
            }
        }
    }
}

- (IBAction)displacementInput:(UITextField *)sender
{
    self.displacement.text = sender.text;
    problem.displacement = [sender.text doubleValue];
    [problem solve];
    [self isEmpty: sender];
    [self updateLabels];
}

- (IBAction)accelerationInput:(UITextField *)sender
{
    self.acceleration.text = sender.text;
    problem.acceleration = [sender.text doubleValue];
    [problem solve];
    [self isEmpty: sender];
    [self updateLabels];
}

- (IBAction)initialVelocityInput:(UITextField *)sender
{
    self.initialVelocity.text = sender.text;
    problem.initialVelocity = [sender.text doubleValue];
    [problem solve];
    [self isEmpty: sender];
    [self updateLabels];
}

- (IBAction)finalVelocityInput:(UITextField *)sender
{
    self.finalVelocity.text = sender.text;
    problem.finalVelocity = [sender.text doubleValue];
    [problem solve];
    [self isEmpty: sender];
    [self updateLabels];
}

- (IBAction)timeInput:(UITextField *)sender
{
    self.time.text = sender.text;
    problem.time = [sender.text doubleValue];
    [problem solve];
    [self isEmpty: sender];
    [self updateLabels];
}

- (void)updateLabels
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.positiveFormat = @"0.###";
    
    self.displacement.text = [formatter stringFromNumber: [NSNumber numberWithDouble: problem.displacement]];
    self.displacement.text = [self.displacement.text stringByAppendingString: @" m"];
    
    self.acceleration.text = [formatter stringFromNumber: [NSNumber numberWithDouble: problem.acceleration]];
    self.acceleration.text = [self.acceleration.text stringByAppendingString: @" m/s^2"];
    
    self.initialVelocity.text = [formatter stringFromNumber: [NSNumber numberWithDouble: problem.initialVelocity]];
    self.initialVelocity.text = [self.initialVelocity.text stringByAppendingString: @" m/s"];
    
    self.finalVelocity.text = [formatter stringFromNumber: [NSNumber numberWithDouble: problem.finalVelocity]];
    self.finalVelocity.text = [self.finalVelocity.text stringByAppendingString: @" m/s"];
    

    NSMutableString *timeString = [NSMutableString stringWithString: [formatter stringFromNumber: [NSNumber numberWithDouble: problem.time]]];
    [timeString appendString: @" s"];
    if (!isnan(problem.time) && problem.time < 0)
        [timeString deleteCharactersInRange: NSMakeRange(0, 1)];
    
    
    self.time.text = timeString;
    
    for (UITextField *label in labels)
    {
        if ( !([label.text rangeOfString: @"NaN"].location == NSNotFound))
            label.text = @"";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
     
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self updateForOrientation];
}

- (void)updateForOrientation
{
    CGRect frame;
    if (UIInterfaceOrientationIsPortrait([self interfaceOrientation])) // became portrait
    {
        self.portraitAnswersView.hidden = NO;
        frame = self.displacement.frame;
        
        if ([[UIScreen mainScreen] bounds].size.height == 480) //iPhone 4
        {
            self.portraitAnswersView.frame = CGRectMake(20, 230, 80, 219);

            frame.origin.x = 90;
            frame.origin.y = 245; //answer labels for iPhone 4
            self.clearButton.frame = CGRectMake(250, 200, 45, 30);
        }
        
        else //iPhone 5+
        {
            frame.origin.x = 90;
            frame.origin.y = 297; //answer labels for iPhone 5
            self.clearButton.frame = CGRectMake(250, 250, 45, 30);
        }
    
        for (UILabel *label in labels)
        {
            label.frame = frame;
            frame.origin.y += 40;
        }
        
        bannerView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - kGADAdSizeBanner.size.height, kGADAdSizeBanner.size.width, kGADAdSizeBanner.size.height);
        
    }
    
    else //became horiztontal
    {
        self.clearButton.frame = CGRectMake(self.view.frame.size.height - 73, 25, 45, 30);
        
        self.portraitAnswersView.hidden = YES;
        
        frame = CGRectMake(self.displacementTextField.frame.origin.x + 188, 42, 149, 21);
        for (UILabel *label in labels)
        {
            label.frame = frame;
            frame.origin.y += 40;
        }

        bannerView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.width - kGADAdSizeBanner.size.height, kGADAdSizeBanner.size.width, kGADAdSizeBanner.size.height);
    }
}

- (BOOL)shouldAutorotate
{
    return true;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - <MPAdViewDelegate>
- (UIViewController *)viewControllerForPresentingModalView {
    return self;
} 

@end
