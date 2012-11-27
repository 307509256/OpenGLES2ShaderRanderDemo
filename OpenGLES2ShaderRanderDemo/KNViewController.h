//
//  KNViewController.h
//  OpenGLES2ShaderRanderDemo
//
//  Created by cyh on 12. 11. 26..
//  Copyright (c) 2012년 cyh3813. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNGLView.h"

@interface KNViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIView* viewVideo;
@property (retain, nonatomic) KNGLView* glView;
- (IBAction)render:(id)sender;
@end
