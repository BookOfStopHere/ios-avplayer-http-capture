//
//  realjkViewController.h
//  ios-avplayer-http-proxy
//
//  Created by Joseph Kiok on 2/28/14.
//  Copyright (c) 2014 RealJK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <asl.h>

@interface realjkViewController : UIViewController {

    IBOutlet UITextView *logTextView;
    IBOutlet UIButton *playButton;
    IBOutlet UIView *playerView;
    IBOutlet UITextField *urlTextField;
    
    AVPlayer *avPlayer;
}


@end
