//
//  PanView.m
//  fishingapp
//
//  Created by Gino Coates on 16/08/12.
//  Copyright (c) 2012 Awesomeness. All rights reserved.
//

#import "PanView.h"
#import <QuartzCore/QuartzCore.h>

@implementation AnimationOptions
@synthesize duration, animation, frame;
    
-(id) initWithFrame:(CGRect)aFrame andDuration:(int)aDuration andAnimation:(AnimationBlock)anAnimation
{
    if((self = [super init])!=nil)
    {
        self.frame = aFrame;
        self.duration = aDuration;
        self.animation = anAnimation;
    }
    
    return self;
}

@end

@implementation PanView
@synthesize image, duration;

-(id) initWithFrame:(CGRect)aFrame
{
    if((self = [super initWithFrame:aFrame])!=nil)
    {
        [self setupImageView];
    }
    
    return self;
}

//--add the child image view
-(void) awakeFromNib
{
    [self setupImageView];
}

-(void) dealloc
{
    if(_imageView != nil)
    {
        [_imageView removeFromSuperview];
        _imageView = nil;
    }
}

-(void) setupImageView
{
    //--keep subviews within the bounds of the parent view
    self.clipsToBounds = YES;
    
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self addSubview:_imageView];
}

//--return a random animation type
-(AnimationType) randomAnimationType
{
    AnimationType types[] = {kPanLeft, kPanRight,kZoomIn, kZoomOut};
    return types[arc4random() % 4];
}

-(void) animateImage
{
    if(self.image==nil) return;
    
    [_imageView.layer removeAllAnimations];
    
    AnimationType animationType = [self randomAnimationType];

    AnimationOptions* options = [self optionsForAnimation:animationType withImageView:_imageView];
    _imageView.frame = options.frame;
    _imageView.image = self.image;
    
    [UIView animateWithDuration:options.duration 
                          delay:0 
                        options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionNone  
                     animations:options.animation completion:nil];
}

-(AnimationOptions*) optionsForAnimation:(AnimationType)animationType withImageView:(UIImageView*)imageView
{
    AnimationBlock animation = nil;
    CGRect frame;
    
    switch(animationType)
    {
        case kZoomOut:
        {
            frame = CGRectInset(self.bounds, 
                                -(self.bounds.size.width * .2), 
                                -(self.bounds.size.height * .2));
            animation = ^{
                imageView.bounds = self.bounds;
            };
        }
            break;
        case kZoomIn:
        {
            frame = self.bounds;
            animation = ^{
                imageView.bounds = CGRectInset(imageView.bounds, 
                                               -(imageView.bounds.size.width * .2), 
                                               -(imageView.bounds.size.height * .2));;
            };
        }
            break;
        case kPanLeft:
        {
            frame = CGRectOffset(CGRectInset(self.bounds, -(self.bounds.size.width * .2), 0),
                                 self.bounds.size.width * .2, 0);
            animation = ^{
                CGRect frame = imageView.frame;
                frame.origin.x -= (imageView.bounds.size.width - self.bounds.size.width);
                imageView.frame = frame;
            };
        }
            break;
        case kPanRight:
        {
            frame = CGRectOffset(CGRectInset(self.bounds, -(self.bounds.size.width * .2), 0),
                                 -self.bounds.size.width * .2, 0);
            animation = ^{
                CGRect frame = imageView.frame;
                frame.origin.x = 0;
                imageView.frame = frame;
            };
        }
            break;
    }
    
    return [[AnimationOptions alloc] initWithFrame:frame andDuration:self.duration andAnimation:animation];
}
@end
