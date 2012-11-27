//
//  KNViewController.m
//  ;
//
//  Created by cyh on 12. 11. 26..
//  Copyright (c) 2012년 cyh3813. All rights reserved.
//

#import "KNViewController.h"
#import "KNFFmpegFileReader.h"
#import "KNFFmpegDecoder.h"

@interface KNViewController ()
@end

@implementation KNViewController

@synthesize viewVideo = _viewVideo;
@synthesize glView = _glView;

- (void)dealloc {
    [_viewVideo release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    _glView = [[KNGLView alloc] initWithFrame:self.viewVideo.frame];
    _glView.contentMode = UIViewContentModeScaleAspectFit;
    [_viewVideo addSubview:_glView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (IBAction)render:(id)sender {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString* filepath = [[NSBundle mainBundle] pathForResource:@"snsd" ofType:@"mp4"];
        
        KNFFmpegFileReader* reader = [[KNFFmpegFileReader alloc] initWithFilepath:filepath];
        KNFFmpegDecoder* dec = [[KNFFmpegDecoder alloc] initWithCodecContext:reader.codecCtx
                                                            videoStreamIndex:reader.videoStreamIndex];
        
        [reader readFrame:^(AVPacket *packet) {
            [dec decodeFrame:packet completion:^(NSDictionary* frameData) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [frameData retain];
                    [_glView render:frameData];
                    [frameData release];
                });
            }];
        }];
        [dec endDecode];
        [dec release];
        [reader release];
    });
}

@end
