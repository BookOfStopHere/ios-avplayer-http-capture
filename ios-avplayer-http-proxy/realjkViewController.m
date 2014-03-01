//
//  realjkViewController.m
//  ios-avplayer-http-proxy
//
//  Created by Joseph Kiok on 2/28/14.
//  Copyright (c) 2014 RealJK. All rights reserved.
//

#import "realjkViewController.h"

@interface realjkViewController ()

@end

@implementation realjkViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    avPlayer = nil;
}

- (IBAction)btnUpdateLogPressed:(id)sender {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    aslmsg q, m;
    int i;
    const char *key, *val;
    
    q = asl_new(ASL_TYPE_QUERY);
    asl_set_query(q, ASL_KEY_SENDER, "AVPlayerHTTPProxy", ASL_QUERY_OP_EQUAL);
    NSString *myString = [NSString stringWithFormat:@"%f", [[[NSDate date] dateByAddingTimeInterval:86400] timeIntervalSince1970]];
    asl_set_query(q, ASL_KEY_TIME, [myString UTF8String], ASL_QUERY_OP_LESS);
    
    aslresponse r = asl_search(NULL, q);
    NSString *str = @"AVPlayerHTTPProxy";

    while (NULL != (m = aslresponse_next(r)))
    {
        NSMutableDictionary *tmpDict = [NSMutableDictionary dictionary];
        
        for (i = 0; (NULL != (key = asl_key(m, i))); i++)
        {
            NSString *keyString = [NSString stringWithUTF8String:(char *)key];
            
            val = asl_get(m, key);
            
            NSString *string = val?[NSString stringWithUTF8String:val]:@"";
            [tmpDict setObject:string forKey:keyString];
        }
        [array addObject:tmpDict];
        NSString *timeStamp = [tmpDict valueForKey:@"Time"];

        timeStamp = [dateFormatter stringFromDate:[[NSDate alloc] initWithTimeIntervalSince1970:[timeStamp doubleValue]]];

        NSString *message = [tmpDict valueForKey:@"Message"];
        
        str = [[NSString stringWithFormat:@"%@ - %@ \n",timeStamp,message] stringByAppendingString:str];
    }
    
    logTextView.text = str;
    aslresponse_free(r);
}

- (IBAction)btnPlayPressed:(id)sender {

    if (avPlayer != NULL) {
        
        // Stop the player first
        [avPlayer pause];
        avPlayer = nil;
    }

    NSURL* contentURL = [NSURL URLWithString:urlTextField.text];
    avPlayer = [AVPlayer playerWithURL:contentURL];
    AVPlayerLayer* playerLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
    [playerLayer setBackgroundColor:[UIColor blackColor].CGColor];
    playerLayer.frame = playerView.bounds;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    playerLayer.needsDisplayOnBoundsChange = YES;
    [playerView.layer addSublayer:playerLayer];
    [avPlayer play];
}

@end
