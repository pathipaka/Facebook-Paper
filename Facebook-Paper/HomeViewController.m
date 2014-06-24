//
//  HomeViewController.m
//  Facebook-Paper
//
//  Created by Om Pathipaka on 6/22/14.
//  Copyright (c) 2014 Om Pathipaka. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *HeadlineBkgImageView;
- (IBAction)onSectionDrag:(UIPanGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UIView *sectionsView;
@property (weak, nonatomic) IBOutlet UIView *headlinesView;

@property (assign,nonatomic) CGPoint offset;

@end

@implementation HomeViewController

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
    
    self.HeadlineBkgImageView.image = [UIImage imageNamed:@"headline"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSectionDrag:(UIPanGestureRecognizer *)sender {

    CGPoint touchPosition = [sender locationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];
    
    if (sender.state == UIGestureRecognizerStateBegan ) {
        
        //NSLog(@"Pan started! %f %f", touchPosition.x, touchPosition.y);
        //NSLog(@"SelectionsView center %f %f", self.sectionsView.center.x, self.sectionsView.center.y);
        self.offset = CGPointMake(touchPosition.x - self.sectionsView.center.x, touchPosition.y - self.sectionsView.center.y);
        
        
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        //NSLog(@"Pan moved %f %f", touchPosition.x + self.offset.x , touchPosition.y + self.offset.y);
        //NSLog(@"Panning .... new touch position %f %f", touchPosition.x, touchPosition.y);
        //NSLog(@"SelectionsView center %f %f", self.sectionsView.center.x, self.sectionsView.center.y);
        NSLog(@"New Y velocity %f", velocity.y);
        float endPosition = touchPosition.y - self.offset.y;
        
        if (self.sectionsView.center.y < 284) {
            endPosition = self.sectionsView.center.y - 1; // dampen effect to 1/10th of movement
        }
        
        self.sectionsView.center = CGPointMake(self.sectionsView.center.x , endPosition);
        
    
        
        } else if (sender.state == UIGestureRecognizerStateEnded){
    NSLog(@"drag ended. Animate the sections area");
    
        //check if going down or up & velocity
        // if going down move to the final spot
        // if going up move to top position
    
        if (self.sectionsView.center.y >= 400 && velocity.y > 0){
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.sectionsView.center = CGPointMake(self.sectionsView.center.x,810);
            
        } completion:^(BOOL finished) {
            //NSLog(@"animation completed");
        }
         ];
        } else {
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.sectionsView.center = CGPointMake(self.sectionsView.center.x,284);
                
            } completion:^(BOOL finished) {
                //NSLog(@"animation completed");
            }
             ];
        }
    
    
    }
}

@end
