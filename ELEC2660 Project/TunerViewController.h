//
//  SecondViewController.h
//  ELEC2660 Project
//
//  Created by Angus Moore on 20/11/2017.
//  Copyright © 2017 Leeds.ac.uk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TunerData.h"
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#include <EZAudio/EZAudio.h>




@interface TunerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, EZMicrophoneDelegate, EZAudioFFTDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *Notepicker;


@property (strong, nonatomic) TunerData *tunerdata;
@property (strong, nonatomic) NSString *selectednote;
@property float dB;
@property float indicatorangle;
@property BOOL pitchplaying;
@property (strong, nonatomic) AVAudioPlayer *C5AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *Csharp5AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *D5AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *Dsharp5AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *E5AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *F5AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *Fsharp5AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *G5AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *Gsharp5AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *A5AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *Asharp5AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *B5AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *C6AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *Csharp6AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *D6AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *Dsharp6AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *E6AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *F6AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *Fsharp6AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *G6AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *Gsharp6AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *A6AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *Asharp6AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *B6AudioPlayer;

@property (weak, nonatomic) IBOutlet UILabel *closestnote;
@property (weak, nonatomic) IBOutlet UILabel *currentfrequency;
@property (nonatomic, strong) EZMicrophone *microphone;
@property (nonatomic, strong) EZAudioFFTRolling *fft;
@property (weak, nonatomic) IBOutlet UIImageView *Indicator;
@property (weak, nonatomic) IBOutlet UIButton *PlayButtonImage;
@property (weak, nonatomic) IBOutlet UIButton *StopButtonImage;



- (IBAction)Tunerswitch:(UISwitch *)sender;
- (IBAction)Playpressed:(UIButton *)sender;
- (IBAction)Stoppressed:(UIButton *)sender;

@end

