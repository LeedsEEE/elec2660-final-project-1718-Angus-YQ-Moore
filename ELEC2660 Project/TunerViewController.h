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
#include <EZAudio/EZAudio.h>



@interface TunerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, EZMicrophoneDelegate, EZAudioFFTDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *Notepicker;


@property (strong, nonatomic) TunerData *tunerdata;
@property (strong, nonatomic) NSString *selectednote;
@property (strong, nonatomic) AVAudioPlayer *C4AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *D4AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *E4AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *F4AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *G4AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *A4AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *B4AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *C5AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *D5AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *E5AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *F5AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *G5AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *A5AudioPlayer;
@property (strong, nonatomic) AVAudioPlayer *B5AudioPlayer;

@property (nonatomic, weak) IBOutlet EZAudioPlot *audioPlotFreq;
@property (nonatomic, weak) IBOutlet EZAudioPlot *audioPlotTime;

@property (weak, nonatomic) IBOutlet UILabel *closestnote;
@property (weak, nonatomic) IBOutlet UILabel *currentfrequency;
@property (nonatomic, strong) EZMicrophone *microphone;
@property (nonatomic, strong) EZAudioFFTRolling *fft;


- (IBAction)Tunerswitch:(UISwitch *)sender;

- (IBAction)Playpressed:(UIButton *)sender;
- (IBAction)Stoppressed:(UIButton *)sender;

@end

