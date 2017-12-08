//
//  SecondViewController.m
//  ELEC2660 Project
//
//  Created by Angus Moore on 20/11/2017.
//  Copyright © 2017 Leeds.ac.uk. All rights reserved.
//
// Implementation of EZAudio RollingFFT adapted from example code on github https://github.com/syedhali/EZAudio/tree/master/EZAudioExamples/iOS/FFT

#import "TunerViewController.h"
#import "TunerData.h"

// set window size for FFR
static vDSP_Length const FFTViewControllerFFTWindowSize = 4096;

@interface TunerViewController ()

@end

@implementation TunerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Set delgate/datasource, initialise tuner data, set up audio and declare pitch playing as FALSE
    self.Notepicker.delegate = self;
    self.Notepicker.dataSource = self;
    self.tunerdata = [[TunerData alloc]init];
    [self setupAudioPlayers];
    self.pitchplaying = FALSE;
    
    // Set picker at C6 and make the selected note C^
    [self.Notepicker selectRow:12 inComponent:0 animated:NO];
    self.selectednote = @"C6";
    
    // Set up audio session and microphone
    AVAudioSession *tuner = [AVAudioSession sharedInstance];
    NSError *error;
    [tuner setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    if (error)
    {
        NSLog(@"Error setting up audio session category: %@", error.localizedDescription);
    }
    [tuner setActive:YES error:&error];
    if (error)
    {
        NSLog(@"Error setting up audio session active: %@", error.localizedDescription);
    }
    
    // Set microphone delegate
    self.microphone = [EZMicrophone microphoneWithDelegate:self];
    
    // Set up rolling FFT analysis
    self.fft = [EZAudioFFTRolling fftWithWindowSize:FFTViewControllerFFTWindowSize
                                         sampleRate:self.microphone.audioStreamBasicDescription.mSampleRate
                                           delegate:self];
    
    // Set stop button alpha and draw breakline layer
    self.StopButtonImage.alpha = 0.5;
    CALayer *breakline = [CALayer layer];
    breakline.backgroundColor = [UIColor blackColor].CGColor;
    breakline.frame = CGRectMake(0, 382, self.view.frame.size.width, 4);
    [self.view.layer addSublayer:breakline];
    
    // Set anchor point for rotation of indicator arrow image
    self.Indicator.layer.anchorPoint = CGPointMake(0.5, 0.83);
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Picker delegate methods

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{
    return [self.tunerdata.pickertonearray objectAtIndex:row];
}


- (void) pickerView:(UIPickerView *)pickerView
       didSelectRow:(NSInteger)row
        inComponent:(NSInteger)component{
    
    // Update selected note depending on chosen row in picker
    self.tunerdata.pickerdatanote = [self.Notepicker selectedRowInComponent:0];
    self.selectednote = self.tunerdata.getpickernote;
    NSLog(@"Selected Note %@", self.selectednote);
    
    // If pitch is currently playing correct the play and stop button alpha
    if (self.pitchplaying == TRUE){
        self.PlayButtonImage.alpha = 1.0;
        self.StopButtonImage.alpha = 0.5;
    }
    
    // Stop all audio samples
    [self.C5AudioPlayer stop];
    [self.Csharp5AudioPlayer stop];
    [self.D5AudioPlayer stop];
    [self.Dsharp5AudioPlayer stop];
    [self.E5AudioPlayer stop];
    [self.F5AudioPlayer stop];
    [self.Fsharp5AudioPlayer stop];
    [self.G5AudioPlayer stop];
    [self.Gsharp5AudioPlayer stop];
    [self.A5AudioPlayer stop];
    [self.Asharp5AudioPlayer stop];
    [self.B5AudioPlayer stop];
    [self.C6AudioPlayer stop];
    [self.Csharp6AudioPlayer stop];
    [self.D6AudioPlayer stop];
    [self.Dsharp6AudioPlayer stop];
    [self.E6AudioPlayer stop];
    [self.F6AudioPlayer stop];
    [self.Fsharp6AudioPlayer stop];
    [self.G6AudioPlayer stop];
    [self.Gsharp6AudioPlayer stop];
    [self.A6AudioPlayer stop];
    [self.Asharp6AudioPlayer stop];
    [self.B6AudioPlayer stop];
    
}

#pragma mark - Picker data methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 23;
    
}

#pragma  mark - EZMicrophoneDelegate method

-(void)    microphone:(EZMicrophone *)microphone
     hasAudioReceived:(float **)buffer
       withBufferSize:(UInt32)bufferSize
 withNumberOfChannels:(UInt32)numberOfChannels
{
    // Method is triggered everytime an audio sample is analyzed
    
    // Calculate the FFT, triggers EZAudioFFTDelegate
    [self.fft computeFFTWithBuffer:buffer[0] withBufferSize:bufferSize];
   
    // Decibel Calculation. Taken from git hub user JeanRintoul https://github.com/syedhali/EZAudio/issues/84
    float one       = 1.0;
    float meanVal   = 0.0;
    vDSP_vsq(buffer[0], 1, buffer[0], 1, bufferSize);
    vDSP_meanv(buffer[0], 1, &meanVal, bufferSize);
    vDSP_vdbcon(&meanVal, 1, &one, &meanVal, 1, 1, 0);
    
    self.dB = meanVal;
    NSLog(@"%f dB", self.dB);
  
}

#pragma mark - EZAudioFFTDelegate method

- (void)        fft:(EZAudioFFT *)fft
 updatedWithFFTData:(float *)fftData
         bufferSize:(vDSP_Length)bufferSize
{
    float maxFrequency = [fft maxFrequency];
    NSString *noteName = [EZAudioUtilities noteNameStringForFrequency:maxFrequency
                                                        includeOctave:YES];
    // Update data values for current frequency and closet note
    self.tunerdata.currentfrequencydata = maxFrequency;
    self.tunerdata.closestnotedata = noteName;
    // Multiply returned ratio by 90 in order to get an angle between -90 and 90
    self.indicatorangle = self.tunerdata.getindictorratio*90;
    // Log to console the angle in degrees
    NSLog(@"angle = %f", self.indicatorangle);
    // Convert angle to radians
    self.indicatorangle = GLKMathDegreesToRadians(self.indicatorangle);
    
    __weak typeof (self) weakSelf = self; //update labels and indicator angle on seperate thread
    dispatch_async(dispatch_get_main_queue(), ^{
        // Update labels and indicator angle on seperate thread
        if(self.dB > -50.00){
            // Threshold decibel level to avoid analysis of non-prominent sound
            weakSelf.currentfrequency.text = [NSString stringWithFormat:@"%.2f Hz", maxFrequency];
            weakSelf.closestnote.text = [NSString stringWithFormat:@"%@",noteName];
            self.Indicator.transform = CGAffineTransformMakeRotation(self.indicatorangle);
        } else {
            weakSelf.currentfrequency.text = [NSString stringWithFormat:@"-"];
            weakSelf.closestnote.text = [NSString stringWithFormat:@"-"];
            self.Indicator.transform = CGAffineTransformMakeRotation(0);
        }
    });
    
}



- (IBAction)Tunerswitch:(UISwitch *)sender {
    // Start and stop fetching audio from the microphone input.
    // Reset labels and indicator when switch is turned off
    if(sender.on){
    [self.microphone startFetchingAudio];
    } else {
    [self.microphone stopFetchingAudio];
    self.currentfrequency.text = [NSString stringWithFormat:@"-"];
    self.closestnote.text = [NSString stringWithFormat:@"-"];
        self.Indicator.transform = CGAffineTransformMakeRotation(0);
}
}

#pragma mark - IBAction methods

- (IBAction)Playpressed:(UIButton *)sender {
    
    // Reduce alpha to indicate visually that the sample is playing, will return to normal when stop butto is pressed
    self.PlayButtonImage.alpha = 0.5;
    self.StopButtonImage.alpha = 1;
    // Pitch is now playing
    self.pitchplaying = TRUE;
    
     //play selected audio sample and stop all others
    if ([self.selectednote isEqualToString:@"C5"]){
        [self.C5AudioPlayer play];
        
        [self.Csharp5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
        [self.B6AudioPlayer stop];
    } else if ([self.selectednote isEqualToString:@"C#5/Db5"]){
        [self.Csharp5AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
        [self.B6AudioPlayer stop];
    } else if ([self.selectednote isEqualToString:@"D5"]){
        [self.D5AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.Csharp5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
        [self.B6AudioPlayer stop];
    }else if ([self.selectednote isEqualToString:@"D#5/Eb5"]){
        [self.Dsharp5AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.Csharp5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
        [self.B6AudioPlayer stop];
        

    }else if ([self.selectednote isEqualToString:@"E5"]){
        [self.E5AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.Csharp5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
        [self.B6AudioPlayer stop];
        
    }else if ([self.selectednote isEqualToString:@"F5"]){
        [self.F5AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.Csharp5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
        [self.B6AudioPlayer stop];
        
        
    }else if ([self.selectednote isEqualToString:@"F#5/Gb5"]){
        
        [self.Fsharp5AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.Csharp5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
        [self.B6AudioPlayer stop];
        
        
    }else if ([self.selectednote isEqualToString:@"G5"]){
        [self.G5AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.Csharp5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
        [self.B6AudioPlayer stop];
        
        
    }else if ([self.selectednote isEqualToString:@"G#5/Ab5"]){
        [self.Gsharp5AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.Csharp5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
        [self.B6AudioPlayer stop];
        
        
    }else if ([self.selectednote isEqualToString:@"A5"]){
        [self.A5AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.Csharp5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
        [self.B6AudioPlayer stop];
        
       
    } else if ([self.selectednote isEqualToString:@"A#5/Bb5"]){
        [self.Asharp5AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.Csharp5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
        [self.B6AudioPlayer stop];
        
       
    } else if ([self.selectednote isEqualToString:@"B5"]){
        
        [self.B5AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.Csharp5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
        [self.B6AudioPlayer stop];
        
        
    } else if ([self.selectednote isEqualToString:@"C6"]){
        [self.C6AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.Csharp5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
        [self.B6AudioPlayer stop];
        
       
    } else if ([self.selectednote isEqualToString:@"C#6/Db6"]){
        [self.Csharp6AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.Csharp5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
        [self.B6AudioPlayer stop];
        
       
    } else if ([self.selectednote isEqualToString:@"D6"]){
        
        [self.D6AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.Csharp5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
        [self.B6AudioPlayer stop];
        
       
    } else if ([self.selectednote isEqualToString:@"D#6/Eb6"]){
        [self.Dsharp6AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.Csharp5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
        [self.B6AudioPlayer stop];
        
       
    } else if ([self.selectednote isEqualToString:@"E6"]){
        [self.E6AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.Csharp5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
        [self.B6AudioPlayer stop];
        
        
    } else if ([self.selectednote isEqualToString:@"F6"]){
        [self.F6AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.Csharp5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
        [self.B6AudioPlayer stop];
        
        
    } else if ([self.selectednote isEqualToString:@"F#6/Gb6"]){
        
        [self.Fsharp6AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.Csharp5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
        [self.B6AudioPlayer stop];
        
        
    } else if ([self.selectednote isEqualToString:@"G6"]){
        [self.G6AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.Csharp5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
        [self.B6AudioPlayer stop];
        
       
    } else if ([self.selectednote isEqualToString:@"G#6/Ab6"]){
        [self.Gsharp6AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.Csharp5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
        [self.B6AudioPlayer stop];
        
       
    } else if ([self.selectednote isEqualToString:@"A6"]){
        [self.A6AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.Csharp5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
        [self.B6AudioPlayer stop];
        
        
    } else if ([self.selectednote isEqualToString:@"A#6/Bb6"]){
        [self.Asharp6AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.Csharp5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.B6AudioPlayer stop];
        
        
    } else if ([self.selectednote isEqualToString:@"B6"]){
        [self.B6AudioPlayer play];
        
        [self.C5AudioPlayer stop];
        [self.Csharp5AudioPlayer stop];
        [self.D5AudioPlayer stop];
        [self.Dsharp5AudioPlayer stop];
        [self.E5AudioPlayer stop];
        [self.F5AudioPlayer stop];
        [self.Fsharp5AudioPlayer stop];
        [self.G5AudioPlayer stop];
        [self.Gsharp5AudioPlayer stop];
        [self.A5AudioPlayer stop];
        [self.Asharp5AudioPlayer stop];
        [self.B5AudioPlayer stop];
        [self.C6AudioPlayer stop];
        [self.Csharp6AudioPlayer stop];
        [self.D6AudioPlayer stop];
        [self.Dsharp6AudioPlayer stop];
        [self.E6AudioPlayer stop];
        [self.F6AudioPlayer stop];
        [self.Fsharp6AudioPlayer stop];
        [self.G6AudioPlayer stop];
        [self.Gsharp6AudioPlayer stop];
        [self.A6AudioPlayer stop];
        [self.Asharp6AudioPlayer stop];
    }
    
   
}

- (IBAction)Stoppressed:(UIButton *)sender { // stop all audio samples
    
    // Return play button alpha back to normal, and stop button to 0.5
    self.StopButtonImage.alpha = 0.5; 
    self.PlayButtonImage.alpha = 1;
    
    // Pitch is no longer playing
    self.pitchplaying = FALSE;
    
    // stop all audio samples
    [self.C5AudioPlayer stop];
    [self.Csharp5AudioPlayer stop];
    [self.D5AudioPlayer stop];
    [self.Dsharp5AudioPlayer stop];
    [self.E5AudioPlayer stop];
    [self.F5AudioPlayer stop];
    [self.Fsharp5AudioPlayer stop];
    [self.G5AudioPlayer stop];
    [self.Gsharp5AudioPlayer stop];
    [self.A5AudioPlayer stop];
    [self.Asharp5AudioPlayer stop];
    [self.B5AudioPlayer stop];
    [self.C6AudioPlayer stop];
    [self.Csharp6AudioPlayer stop];
    [self.D6AudioPlayer stop];
    [self.Dsharp6AudioPlayer stop];
    [self.E6AudioPlayer stop];
    [self.F6AudioPlayer stop];
    [self.Fsharp6AudioPlayer stop];
    [self.G6AudioPlayer stop];
    [self.Gsharp6AudioPlayer stop];
    [self.A6AudioPlayer stop];
    [self.Asharp6AudioPlayer stop];
    [self.B6AudioPlayer stop];
   
    
}

#pragma mark - Audio setup method

-(void) setupAudioPlayers{ //setup all audioplayer samples and set them to loop infinitely
    
    
    NSString *C5Path = [NSString stringWithFormat:@"%@/C5.wav",
                        [[NSBundle mainBundle] resourcePath]];
    NSURL *C5URL = [NSURL fileURLWithPath:C5Path];
    self.C5AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:C5URL error:nil];
    self.C5AudioPlayer.numberOfLoops = -1;
    
    NSString *Csharp5Path = [NSString stringWithFormat:@"%@/C#5:Db5.wav",
                             [[NSBundle mainBundle] resourcePath]];
    NSURL *Csharp5URL = [NSURL fileURLWithPath:Csharp5Path];
    self.Csharp5AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:Csharp5URL error:nil];
    self.Csharp5AudioPlayer.numberOfLoops = -1;
    
    NSString *D5Path = [NSString stringWithFormat:@"%@/D5.wav",
                        [[NSBundle mainBundle] resourcePath]];
    NSURL *D5URL = [NSURL fileURLWithPath:D5Path];
    self.D5AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:D5URL error:nil];
    self.D5AudioPlayer.numberOfLoops = -1;
    
    NSString *Dsharp5Path = [NSString stringWithFormat:@"%@/D#5:Eb5.wav",
                             [[NSBundle mainBundle] resourcePath]];
    NSURL *Dsharp5URL = [NSURL fileURLWithPath:Dsharp5Path];
    self.Dsharp5AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:Dsharp5URL error:nil];
    self.Dsharp5AudioPlayer.numberOfLoops = -1;
    
    NSString *E5Path = [NSString stringWithFormat:@"%@/E5.wav",
                        [[NSBundle mainBundle] resourcePath]];
    NSURL *E5URL = [NSURL fileURLWithPath:E5Path];
    self.E5AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:E5URL error:nil];
    self.E5AudioPlayer.numberOfLoops = -1;
    
    NSString *F5Path = [NSString stringWithFormat:@"%@/F5.wav",
                        [[NSBundle mainBundle] resourcePath]];
    NSURL *F5URL = [NSURL fileURLWithPath:F5Path];
    self.F5AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:F5URL error:nil];
    self.F5AudioPlayer.numberOfLoops = -1;
    
    NSString *Fsharp5Path = [NSString stringWithFormat:@"%@/F#5:Gb5.wav",
                             [[NSBundle mainBundle] resourcePath]];
    NSURL *Fsharp5URL = [NSURL fileURLWithPath:Fsharp5Path];
    self.Fsharp5AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:Fsharp5URL error:nil];
    self.Fsharp5AudioPlayer.numberOfLoops = -1;
    
    NSString *G5Path = [NSString stringWithFormat:@"%@/G5.wav",
                        [[NSBundle mainBundle] resourcePath]];
    NSURL *G5URL = [NSURL fileURLWithPath:G5Path];
    self.G5AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:G5URL error:nil];
    self.G5AudioPlayer.numberOfLoops = -1;
    
    NSString *Gsharp5Path = [NSString stringWithFormat:@"%@/G#5:Ab5.wav",
                             [[NSBundle mainBundle] resourcePath]];
    NSURL *Gsharp5URL = [NSURL fileURLWithPath:Gsharp5Path];
    self.Gsharp5AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:Gsharp5URL error:nil];
    self.Gsharp5AudioPlayer.numberOfLoops = -1;
    
    NSString *A5Path = [NSString stringWithFormat:@"%@/A5.wav",
                        [[NSBundle mainBundle] resourcePath]];
    NSURL *A5URL = [NSURL fileURLWithPath:A5Path];
    self.A5AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:A5URL error:nil];
    self.A5AudioPlayer.numberOfLoops = -1;
    
    NSString *Asharp5Path = [NSString stringWithFormat:@"%@/A#5:Bb5.wav",
                             [[NSBundle mainBundle] resourcePath]];
    NSURL *Asharp5URL = [NSURL fileURLWithPath:Asharp5Path];
    self.Asharp5AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:Asharp5URL error:nil];
    self.Asharp5AudioPlayer.numberOfLoops = -1;
    
    NSString *B5Path = [NSString stringWithFormat:@"%@/B5.wav",
                        [[NSBundle mainBundle] resourcePath]];
    NSURL *B5URL = [NSURL fileURLWithPath:B5Path];
    self.B5AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:B5URL error:nil];
    self.B5AudioPlayer.numberOfLoops = -1;
    
    NSString *C6Path = [NSString stringWithFormat:@"%@/C6.wav",
                        [[NSBundle mainBundle] resourcePath]];
    NSURL *C6URL = [NSURL fileURLWithPath:C6Path];
    self.C6AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:C6URL error:nil];
    self.C6AudioPlayer.numberOfLoops = -1;
    
    NSString *Csharp6Path = [NSString stringWithFormat:@"%@/C#6:Db6.wav",
                             [[NSBundle mainBundle] resourcePath]];
    NSURL *Csharp6URL = [NSURL fileURLWithPath:Csharp6Path];
    self.Csharp6AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:Csharp6URL error:nil];
    self.Csharp6AudioPlayer.numberOfLoops = -1;
    
    NSString *D6Path = [NSString stringWithFormat:@"%@/D6.wav",
                        [[NSBundle mainBundle] resourcePath]];
    NSURL *D6URL = [NSURL fileURLWithPath:D6Path];
    self.D6AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:D6URL error:nil];
    self.D6AudioPlayer.numberOfLoops = -1;
    
    NSString *Dsharp6Path = [NSString stringWithFormat:@"%@/D#6:Eb6.wav",
                             [[NSBundle mainBundle] resourcePath]];
    NSURL *Dsharp6URL = [NSURL fileURLWithPath:Dsharp6Path];
    self.Dsharp6AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:Dsharp6URL error:nil];
    self.Dsharp6AudioPlayer.numberOfLoops = -1;
    
    NSString *E6Path = [NSString stringWithFormat:@"%@/E6.wav",
                        [[NSBundle mainBundle] resourcePath]];
    NSURL *E6URL = [NSURL fileURLWithPath:E6Path];
    self.E6AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:E6URL error:nil];
    self.E6AudioPlayer.numberOfLoops = -1;
    
    NSString *F6Path = [NSString stringWithFormat:@"%@/F6.wav",
                        [[NSBundle mainBundle] resourcePath]];
    NSURL *F6URL = [NSURL fileURLWithPath:F6Path];
    self.F6AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:F6URL error:nil];
    self.F6AudioPlayer.numberOfLoops = -1;
    
    NSString *Fsharp6Path = [NSString stringWithFormat:@"%@/F#6:Gb6.wav",
                             [[NSBundle mainBundle] resourcePath]];
    NSURL *Fsharp6URL = [NSURL fileURLWithPath:Fsharp6Path];
    self.Fsharp6AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:Fsharp6URL error:nil];
    self.Fsharp6AudioPlayer.numberOfLoops = -1;
    
    NSString *G6Path = [NSString stringWithFormat:@"%@/G6.wav",
                        [[NSBundle mainBundle] resourcePath]];
    NSURL *G6URL = [NSURL fileURLWithPath:G6Path];
    self.G6AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:G6URL error:nil];
    self.G6AudioPlayer.numberOfLoops = -1;
    
    NSString *Gsharp6Path = [NSString stringWithFormat:@"%@/G#6:Ab6.wav",
                             [[NSBundle mainBundle] resourcePath]];
    NSURL *Gsharp6URL = [NSURL fileURLWithPath:Gsharp6Path];
    self.Gsharp6AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:Gsharp6URL error:nil];
    self.Gsharp6AudioPlayer.numberOfLoops = -1;
    
    NSString *A6Path = [NSString stringWithFormat:@"%@/A6.wav",
                        [[NSBundle mainBundle] resourcePath]];
    NSURL *A6URL = [NSURL fileURLWithPath:A6Path];
    self.A6AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:A6URL error:nil];
    self.A6AudioPlayer.numberOfLoops = -1;
    
    NSString *Asharp6Path = [NSString stringWithFormat:@"%@/A#6:Bb6.wav",
                             [[NSBundle mainBundle] resourcePath]];
    NSURL *Asharp6URL = [NSURL fileURLWithPath:Asharp6Path];
    self.Asharp6AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:Asharp6URL error:nil];
    self.Asharp6AudioPlayer.numberOfLoops = -1;
    
    NSString *B6Path = [NSString stringWithFormat:@"%@/B6.wav",
                        [[NSBundle mainBundle] resourcePath]];
    NSURL *B6URL = [NSURL fileURLWithPath:B6Path];
    self.B6AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:B6URL error:nil];
    self.B6AudioPlayer.numberOfLoops = -1;
    
    
    NSLog(@"Audio Setup");
    
}
@end

