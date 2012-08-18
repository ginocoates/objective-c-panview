//
//  ViewController.m
//  PanViewSample
//
//  Created by Gino Coates on 18/08/12.
//  Copyright (c) 2012 Awesomeness. All rights reserved.
//

#import "ViewController.h"
#import "PanView.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize panView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString* pathToImageFile = [[NSBundle mainBundle] pathForResource:@"bikes" ofType:@"jpg"];
    UIImage* image = [UIImage imageWithContentsOfFile:pathToImageFile];
    self.panView.image = image;
    panView.duration = 5.0f;
    [panView animateImage];
}

- (void)viewDidUnload
{
    [self setPanView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)animate:(id)sender {
    [panView animateImage];
}
@end
