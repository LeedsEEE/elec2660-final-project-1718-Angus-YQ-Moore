//
//  MetronomeViewController.h
//  ELEC2660 Project
//
//  Created by Angus Moore on 20/11/2017.
//  Copyright © 2017 Leeds.ac.uk. All rights reserved.
//


//play and stop button images taken from https://www.shareicon.net/stop-next-fast-forward-button-interface-play-button-arrows-skip-701691
// tuning fork icon https://thenounproject.com/term/tuning-fork/77256/
//metronome icon https://thenounproject.com/term/metronome/118052/

#import <UIKit/UIKit.h>
#import "MetronomeData.h"
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>

@interface MetronomeViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *MetreTempoPicker;
@property (strong, nonatomic) MetronomeData *metronomedata;
@property (weak, nonatomic) IBOutlet UITextField *bpmtextfield;
@property (weak, nonatomic) IBOutlet UIStepper *bpmstepper;
@property (strong, nonatomic) NSTimer *metronometimer;
@property float bpm;
@property NSString *metre;
@property NSInteger beatnumber;

@property AVAudioPlayer *UpClickAudioPlayer;
@property AVAudioPlayer *DownClickAudioPlayer;


- (IBAction)bmpentered:(UITextField *)sender;
- (IBAction)bpmincremented:(UIStepper *)sender;
- (IBAction)Playpressed:(UIButton *)sender;
- (IBAction)Stoppressed:(UIButton *)sender;

@end
