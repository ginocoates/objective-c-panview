//
//  PanView.h
//  fishingapp
//
//  Created by Gino Coates on 16/08/12.
//  Copyright (c) 2012 Awesomeness. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum AnimationTypes {
    kPanLeft = 0,
    kPanRight = 1,
    kZoomIn = 2,
    kZoomOut = 4
} AnimationType;

@interface PanView : UIView
{
    UIImageView* _imageView;
}
@property(nonatomic, copy) UIImage* image;
@property(nonatomic) int duration;
-(void) animateImage;
@end

typedef void(^AnimationBlock)(void);

@interface AnimationOptions : NSObject
{
    AnimationBlock animation;
    CGRect frame;
    int interval;
}
@property (nonatomic, strong) AnimationBlock animation;
@property (nonatomic) CGRect frame;
@property (nonatomic) int duration;

-(id) initWithFrame:(CGRect)aFrame andDuration:(int)aDuration andAnimation:(AnimationBlock)anAnimation;
@end
