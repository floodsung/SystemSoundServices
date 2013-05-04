//
//  RotekViewController.m
//  SystemSoundServices
//
//  Created by Rotek on 12-10-26.
//  Copyright (c) 2012年 Rotek. All rights reserved.
//

#import "RotekViewController.h"

@interface RotekViewController ()
@property (nonatomic,readwrite) CFURLRef soundFileURLRef;
@property (nonatomic,readonly) SystemSoundID soundFileObject;
@end

@implementation RotekViewController
@synthesize soundFileURLRef = _soundFileURLRef;
@synthesize soundFileObject = _soundFileObject;

#pragma mark - Actions

- (IBAction)vibratePressed:(id)sender
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (IBAction)playSoundPressed:(id)sender
{
    AudioServicesPlaySystemSound(self.soundFileObject);
}

- (IBAction)playSoundAndVibratePressed:(id)sender
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"win"
                                                     ofType:@"wav"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID(
                                     (__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
    AudioServicesPlayAlertSound(soundID);   //播放音频加震动
    AudioServicesPlaySystemSound(soundID);  //仅播放音频
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Create the URL for the source audio file
    NSURL *tapSound = [[NSBundle mainBundle] URLForResource:@"tap" withExtension:@"aif"];
    // Store the URL as a CFURLRef instance
    self.soundFileURLRef = (__bridge CFURLRef)tapSound;
    // Create a system sound object representing the sound file
    AudioServicesCreateSystemSoundID(self.soundFileURLRef, &_soundFileObject);
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
