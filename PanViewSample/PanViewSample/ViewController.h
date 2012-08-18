//
//  ViewController.h
//  PanViewSample
//
//  Created by Gino Coates on 18/08/12.
//  Copyright (c) 2012 Awesomeness. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PanView;
@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet PanView *panView;
- (IBAction)animate:(id)sender;
@end
