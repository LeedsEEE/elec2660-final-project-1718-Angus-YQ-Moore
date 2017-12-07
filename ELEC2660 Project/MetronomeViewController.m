#import "MetronomeViewController.h"


@interface MetronomeViewController ()


@end

@implementation MetronomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.MetreTempoPicker.delegate = self;
    self.MetreTempoPicker.dataSource = self;
    self.bpmtextfield.delegate = self;
    self.metronomedata = [[MetronomeData alloc] init];
    self.bpmtextfield.text = @"120";                          //
    self.bpm = 120;                                           // set initial bpm and beat number
    self.bpmstepper.value = 120;                              //
    self.beatnumber = 0;                                      //
    self.metre = @"4/4";                                      // set inital metre to 4/4
    [self setupaudio];                                        // setup audio
    [self drawmetronomegraphic];                              // display initial graphic (4/4)
    CALayer *breakline = [CALayer layer];                     // draw the breakline
    breakline.backgroundColor = [UIColor blackColor].CGColor;
    breakline.frame = CGRectMake(0, 380, 425, 4);
    [self.view.layer addSublayer:breakline];
    
    [self.MetreTempoPicker selectRow:2 inComponent:0 animated:NO]; // start metre picker component at 4/4
    [self.MetreTempoPicker selectRow:7 inComponent:1 animated:NO]; // start tempo picker component at Moderato
   

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

#pragma picker delegate methods

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{
    NSString *selection ;
    if (component == 0){
        selection = [self.metronomedata.MetreArray objectAtIndex:row];
    } else if (component == 1) {
        selection = [self.metronomedata.TempoArray objectAtIndex:row];
    }
    return selection;
}


- (void) pickerView:(UIPickerView *)pickerView
       didSelectRow:(NSInteger)row
        inComponent:(NSInteger)component{
    
    if (component == 0){
        self.metronomedata.SelectedMetre = [self.MetreTempoPicker selectedRowInComponent:0];
        self.metre = self.metronomedata.getmetre;
        NSLog(@"Metre = %@", self.metre);
        [self drawmetronomegraphic];
        
    } else if (component == 1){
        self.metronomedata.SelectedTempo = [self.MetreTempoPicker selectedRowInComponent:1];
        self.bpm = self.metronomedata.gettempobpm;
        NSString *bpmstring = [NSString stringWithFormat:@"%li", (long)self.bpm];
        self.bpmtextfield.text = bpmstring;
        self.bpmstepper.value = self.bpm;
        NSLog(@"bpm = %f", self.bpm);
        NSLog(@"stepper value = %f", self.bpmstepper.value);
    }
     // stop timer and reset beat images
    [self.metronometimer invalidate];
    self.beatone.image = [UIImage imageNamed:@"beat1"];
    self.beattwo.image = [UIImage imageNamed:@"beat2"];
    self.beatthree.image = [UIImage imageNamed:@"beat3"];
    self.beatfour.image = [UIImage imageNamed:@"beat4"];
    self.beatfive.image = [UIImage imageNamed:@"beat5"];
    self.beatsix.image = [UIImage imageNamed:@"beat6"];
    self.beatseven.image = [UIImage imageNamed:@"beat7"];
    self.beateight.image = [UIImage imageNamed:@"beat8"];
    self.beatnine.image = [UIImage imageNamed:@"beat9"];
}

#pragma picker data methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    NSInteger rows = 0;
    if(component == 0){
        rows = 5;
    } else if (component == 1){
        rows = 13;
    }
    return rows;
}

//Remove keypad when touching main view

- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event {
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]])
            [view resignFirstResponder];
    }
}


- (BOOL)textField:(UITextField *)textField //taken from stack overflow, restricting UITextfield values https://stackoverflow.com/questions/27916943/how-to-not-allow-the-user-to-enter-a-value-more-than-190-in-uitextfield
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    NSString *checkstring = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if([checkstring intValue] > 300){
        return NO;
    }
    return YES;
}

- (void)drawmetronomegraphic{
    
    
    if ([self.metre isEqualToString:@"2/4"]){
        
        [self.beatone setFrame:CGRectMake(105, 175, self.beatone.frame.size.width, self.beatone.frame.size.height)];
        [self.beattwo setFrame:CGRectMake(205, 175, self.beattwo.frame.size.width, self.beattwo.frame.size.height)];
     
        self.beatone.hidden = FALSE;
        self.beattwo.hidden = FALSE;
        self.beatthree.hidden = TRUE;
        self.beatfour.hidden = TRUE;
        self.beatfive.hidden = TRUE;
        self.beatsix.hidden = TRUE;
        self.beatseven.hidden = TRUE;
        self.beateight.hidden = TRUE;
        self.beatnine.hidden = TRUE;
        
        NSLog(@"2/4 drawn");
        
    } else if ([self.metre isEqualToString:@"3/4"]){
        
        [self.beatone setFrame:CGRectMake(55, 175, self.beatone.frame.size.width, self.beatone.frame.size.height)];
        [self.beattwo setFrame:CGRectMake(155, 175, self.beattwo.frame.size.width, self.beattwo.frame.size.height)];
        [self.beatthree setFrame:CGRectMake(255, 175, self.beatthree.frame.size.width, self.beatthree.frame.size.height)];
        
        self.beatone.hidden = FALSE;
        self.beattwo.hidden = FALSE;
        self.beatthree.hidden = FALSE;
        self.beatfour.hidden = TRUE;
        self.beatfive.hidden = TRUE;
        self.beatsix.hidden = TRUE;
        self.beatseven.hidden = TRUE;
        self.beateight.hidden = TRUE;
        self.beatnine.hidden = TRUE;
    
        
        NSLog(@"3/4 drawn");
    } else if ([self.metre isEqualToString:@"4/4"]){
        
        [self.beatone setFrame:CGRectMake(30, 175, self.beatone.frame.size.width, self.beatone.frame.size.height)];
        [self.beattwo setFrame:CGRectMake(115, 175, self.beattwo.frame.size.width, self.beattwo.frame.size.height)];
        [self.beatthree setFrame:CGRectMake(200, 175, self.beatthree.frame.size.width, self.beatthree.frame.size.height)];
        [self.beatfour setFrame:CGRectMake(285, 175, self.beatfour.frame.size.width, self.beatfour.frame.size.height)];
        
        self.beatone.hidden = FALSE;
        self.beattwo.hidden = FALSE;
        self.beatthree.hidden = FALSE;
        self.beatfour.hidden = FALSE;
        self.beatfive.hidden = TRUE;
        self.beatsix.hidden = TRUE;
        self.beatseven.hidden = TRUE;
        self.beateight.hidden = TRUE;
        self.beatnine.hidden = TRUE;
        
        NSLog(@"4/4 drawn");
     
    } else if ([self.metre isEqualToString:@"6/8"]){
        
        [self.beatone setFrame:CGRectMake(55, 130, self.beatone.frame.size.width, self.beatone.frame.size.height)];
        [self.beattwo setFrame:CGRectMake(155, 130, self.beattwo.frame.size.width, self.beattwo.frame.size.height)];
        [self.beatthree setFrame:CGRectMake(255, 130, self.beatthree.frame.size.width, self.beatthree.frame.size.height)];
        [self.beatfour setFrame:CGRectMake(55, 220, self.beatfour.frame.size.width, self.beatfour.frame.size.height)];
        [self.beatfive setFrame:CGRectMake(155, 220, self.beatfive.frame.size.width, self.beatfive.frame.size.height)];
        [self.beatsix setFrame:CGRectMake(255, 220, self.beatsix.frame.size.width, self.beatsix.frame.size.height)];
        
        
        self.beatone.hidden = FALSE;
        self.beattwo.hidden = FALSE;
        self.beatthree.hidden = FALSE;
        self.beatfour.hidden = FALSE;
        self.beatfive.hidden = FALSE;
        self.beatsix.hidden = FALSE;
        self.beatseven.hidden = TRUE;
        self.beateight.hidden = TRUE;
        self.beatnine.hidden = TRUE;
        
        NSLog(@"6/8 drawn");
        
        
    } else if ([self.metre isEqualToString:@"9/8"]){
        
        [self.beatone setFrame:CGRectMake(55, 70, self.beatone.frame.size.width, self.beatone.frame.size.height)];
        [self.beattwo setFrame:CGRectMake(155, 70, self.beattwo.frame.size.width, self.beattwo.frame.size.height)];
        [self.beatthree setFrame:CGRectMake(255, 70, self.beatthree.frame.size.width, self.beatthree.frame.size.height)];
        [self.beatfour setFrame:CGRectMake(55, 160, self.beatfour.frame.size.width, self.beatfour.frame.size.height)];
        [self.beatfive setFrame:CGRectMake(155, 160, self.beatfive.frame.size.width, self.beatfive.frame.size.height)];
        [self.beatsix setFrame:CGRectMake(255, 160, self.beatsix.frame.size.width, self.beatsix.frame.size.height)];
        [self.beatseven setFrame:CGRectMake(55, 250, self.beatseven.frame.size.width, self.beatseven.frame.size.height)];
        [self.beateight setFrame:CGRectMake(155, 250, self.beateight.frame.size.width, self.beateight.frame.size.height)];
        [self.beatnine setFrame:CGRectMake(255, 250, self.beatnine.frame.size.width, self.beatnine.frame.size.height)];
        
        
        self.beatone.hidden = FALSE;
        self.beattwo.hidden = FALSE;
        self.beatthree.hidden = FALSE;
        self.beatfour.hidden = FALSE;
        self.beatfive.hidden = FALSE;
        self.beatsix.hidden = FALSE;
        self.beatseven.hidden = FALSE;
        self.beateight.hidden = FALSE;
        self.beatnine.hidden = FALSE;
        
        NSLog(@"9/8 drawn");
    }
    
}

- (IBAction)Playpressed:(UIButton *)sender {
    [self.metronometimer invalidate];
    self.beatnumber = 0;
    self.metronometimer = [NSTimer scheduledTimerWithTimeInterval:60/self.bpm target:self selector:@selector(timerfire:) userInfo:nil repeats:YES];
}

- (IBAction)Stoppressed:(UIButton *)sender {
    self.beatnumber = 0;
    [self.metronometimer invalidate];
    self.metronometimer = nil;

    self.beatone.image = [UIImage imageNamed:@"beat1"];
    self.beattwo.image = [UIImage imageNamed:@"beat2"];
    self.beatthree.image = [UIImage imageNamed:@"beat3"];
    self.beatfour.image = [UIImage imageNamed:@"beat4"];
    self.beatfive.image = [UIImage imageNamed:@"beat5"];
    self.beatsix.image = [UIImage imageNamed:@"beat6"];
    self.beatseven.image = [UIImage imageNamed:@"beat7"];
    self.beateight.image = [UIImage imageNamed:@"beat8"];
    self.beatnine.image = [UIImage imageNamed:@"beat9"];
}

- (void) timerfire:(NSTimer *)metronometimer{
    
    self.beatnumber++;
    if ([self.MetreTempoPicker selectedRowInComponent:0] == 0){
        if (self.beatnumber > 2){
            self.beatnumber = 1;
        }
    } else if ([self.MetreTempoPicker selectedRowInComponent:0] == 1){
        if (self.beatnumber > 3){
            self.beatnumber = 1;
        }
    } else if ([self.MetreTempoPicker selectedRowInComponent:0] == 2){
        if (self.beatnumber > 4){
            self.beatnumber = 1;
        }
    } else if ([self.MetreTempoPicker selectedRowInComponent:0] == 3){
        if (self.beatnumber > 6){
            self.beatnumber = 1;
        }
    } else if ([self.MetreTempoPicker selectedRowInComponent:0] == 4){
            if (self.beatnumber > 9){
                self.beatnumber = 1;
            }
    }
    
    if (self.beatnumber == 1){
        if ([self.ClickAudioPlayer isPlaying] || [self.DownClickAudioPlayer isPlaying]){
            [self.ClickAudioPlayer stop];
            [self.DownClickAudioPlayer stop];
            self.ClickAudioPlayer.currentTime = 0.0;
            self.DownClickAudioPlayer.currentTime = 0.0;
        }
        [self.UpClickAudioPlayer play];
        self.beatone.image = [UIImage imageNamed:@"beat1on"];
        self.beattwo.image = [UIImage imageNamed:@"beat2"];
        self.beatthree.image = [UIImage imageNamed:@"beat3"];
        self.beatfour.image = [UIImage imageNamed:@"beat4"];
        self.beatfive.image = [UIImage imageNamed:@"beat5"];
        self.beatsix.image = [UIImage imageNamed:@"beat6"];
        self.beatseven.image = [UIImage imageNamed:@"beat7"];
        self.beateight.image = [UIImage imageNamed:@"beat8"];
        self.beatnine.image = [UIImage imageNamed:@"beat9"];
    } else if (self.beatnumber == 2){
        if ([self.ClickAudioPlayer isPlaying] || [self.DownClickAudioPlayer isPlaying]){
            [self.ClickAudioPlayer stop];
            [self.DownClickAudioPlayer stop];
            self.ClickAudioPlayer.currentTime = 0.0;
            self.DownClickAudioPlayer.currentTime = 0.0;
        }
        [self.ClickAudioPlayer play];
        self.beatone.image = [UIImage imageNamed:@"beat1"];
        self.beattwo.image = [UIImage imageNamed:@"beat2on"];
        self.beatthree.image = [UIImage imageNamed:@"beat3"];
        self.beatfour.image = [UIImage imageNamed:@"beat4"];
        self.beatfive.image = [UIImage imageNamed:@"beat5"];
        self.beatsix.image = [UIImage imageNamed:@"beat6"];
        self.beatseven.image = [UIImage imageNamed:@"beat7"];
        self.beateight.image = [UIImage imageNamed:@"beat8"];
        self.beatnine.image = [UIImage imageNamed:@"beat9"];
    }  else if (self.beatnumber == 3){
        if ([self.ClickAudioPlayer isPlaying] || [self.DownClickAudioPlayer isPlaying]){
            [self.ClickAudioPlayer stop];
            [self.DownClickAudioPlayer stop];
            self.ClickAudioPlayer.currentTime = 0.0;
            self.DownClickAudioPlayer.currentTime = 0.0;
        }
        [self.ClickAudioPlayer play];
        self.beatone.image = [UIImage imageNamed:@"beat1"];
        self.beattwo.image = [UIImage imageNamed:@"beat2"];
        self.beatthree.image = [UIImage imageNamed:@"beat3on"];
        self.beatfour.image = [UIImage imageNamed:@"beat4"];
        self.beatfive.image = [UIImage imageNamed:@"beat5"];
        self.beatsix.image = [UIImage imageNamed:@"beat6"];
        self.beatseven.image = [UIImage imageNamed:@"beat7"];
        self.beateight.image = [UIImage imageNamed:@"beat8"];
        self.beatnine.image = [UIImage imageNamed:@"beat9"];
    } else if (self.beatnumber == 4){
        if ([self.ClickAudioPlayer isPlaying] || [self.DownClickAudioPlayer isPlaying]){
            [self.ClickAudioPlayer stop];
            [self.DownClickAudioPlayer stop];
            self.ClickAudioPlayer.currentTime = 0.0;
            self.DownClickAudioPlayer.currentTime = 0.0;
        }
        
        if ([self.metre isEqualToString:@"6/8"] || [self.metre isEqualToString:@"9/8"]){
            [self.DownClickAudioPlayer play];
        } else{
        [self.ClickAudioPlayer play];
        }
        self.beatone.image = [UIImage imageNamed:@"beat1"];
        self.beattwo.image = [UIImage imageNamed:@"beat2"];
        self.beatthree.image = [UIImage imageNamed:@"beat3"];
        self.beatfour.image = [UIImage imageNamed:@"beat4on"];
        self.beatfive.image = [UIImage imageNamed:@"beat5"];
        self.beatsix.image = [UIImage imageNamed:@"beat6"];
        self.beatseven.image = [UIImage imageNamed:@"beat7"];
        self.beateight.image = [UIImage imageNamed:@"beat8"];
        self.beatnine.image = [UIImage imageNamed:@"beat9"];
    } else if (self.beatnumber == 5){
        if ([self.ClickAudioPlayer isPlaying] || [self.DownClickAudioPlayer isPlaying]){
            [self.ClickAudioPlayer stop];
            [self.DownClickAudioPlayer stop];
            self.ClickAudioPlayer.currentTime = 0.0;
            self.DownClickAudioPlayer.currentTime = 0.0;
        }
        [self.ClickAudioPlayer play];
        self.beatone.image = [UIImage imageNamed:@"beat1"];
        self.beattwo.image = [UIImage imageNamed:@"beat2"];
        self.beatthree.image = [UIImage imageNamed:@"beat3"];
        self.beatfour.image = [UIImage imageNamed:@"beat4"];
        self.beatfive.image = [UIImage imageNamed:@"beat5on"];
        self.beatsix.image = [UIImage imageNamed:@"beat6"];
        self.beatseven.image = [UIImage imageNamed:@"beat7"];
        self.beateight.image = [UIImage imageNamed:@"beat8"];
        self.beatnine.image = [UIImage imageNamed:@"beat9"];
    } else if (self.beatnumber == 6){
        if ([self.ClickAudioPlayer isPlaying] || [self.DownClickAudioPlayer isPlaying]){
            [self.ClickAudioPlayer stop];
            [self.DownClickAudioPlayer stop];
            self.ClickAudioPlayer.currentTime = 0.0;
            self.DownClickAudioPlayer.currentTime = 0.0;
        }
        [self.ClickAudioPlayer play];
        self.beatone.image = [UIImage imageNamed:@"beat1"];
        self.beattwo.image = [UIImage imageNamed:@"beat2"];
        self.beatthree.image = [UIImage imageNamed:@"beat3"];
        self.beatfour.image = [UIImage imageNamed:@"beat4"];
        self.beatfive.image = [UIImage imageNamed:@"beat5"];
        self.beatsix.image = [UIImage imageNamed:@"beat6on"];
        self.beatseven.image = [UIImage imageNamed:@"beat7"];
        self.beateight.image = [UIImage imageNamed:@"beat8"];
        self.beatnine.image = [UIImage imageNamed:@"beat9"];
    } else if (self.beatnumber == 7){
        if ([self.ClickAudioPlayer isPlaying] || [self.DownClickAudioPlayer isPlaying]){
            [self.ClickAudioPlayer stop];
            [self.DownClickAudioPlayer stop];
            self.ClickAudioPlayer.currentTime = 0.0;
            self.DownClickAudioPlayer.currentTime = 0.0;
        }
        
        if ([self.metre isEqualToString:@"9/8"]){
            [self.DownClickAudioPlayer play];
        } else {
            [self.ClickAudioPlayer play];
        }
        self.beatone.image = [UIImage imageNamed:@"beat1"];
        self.beattwo.image = [UIImage imageNamed:@"beat2"];
        self.beatthree.image = [UIImage imageNamed:@"beat3"];
        self.beatfour.image = [UIImage imageNamed:@"beat4"];
        self.beatfive.image = [UIImage imageNamed:@"beat5"];
        self.beatsix.image = [UIImage imageNamed:@"beat6"];
        self.beatseven.image = [UIImage imageNamed:@"beat7on"];
        self.beateight.image = [UIImage imageNamed:@"beat8"];
        self.beatnine.image = [UIImage imageNamed:@"beat9"];
    } else if (self.beatnumber == 8){
        if ([self.ClickAudioPlayer isPlaying]){
            [self.ClickAudioPlayer stop];
            self.ClickAudioPlayer.currentTime = 0.0;
        }
        [self.ClickAudioPlayer play];
        self.beatone.image = [UIImage imageNamed:@"beat1"];
        self.beattwo.image = [UIImage imageNamed:@"beat2"];
        self.beatthree.image = [UIImage imageNamed:@"beat3"];
        self.beatfour.image = [UIImage imageNamed:@"beat4"];
        self.beatfive.image = [UIImage imageNamed:@"beat5"];
        self.beatsix.image = [UIImage imageNamed:@"beat6"];
        self.beatseven.image = [UIImage imageNamed:@"beat7"];
        self.beateight.image = [UIImage imageNamed:@"beat8on"];
        self.beatnine.image = [UIImage imageNamed:@"beat9"];
    } else if (self.beatnumber == 9){
        if ([self.ClickAudioPlayer isPlaying]){
            [self.ClickAudioPlayer stop];
            self.ClickAudioPlayer.currentTime = 0.0;
        }
        [self.ClickAudioPlayer play];
        self.beatone.image = [UIImage imageNamed:@"beat1"];
        self.beattwo.image = [UIImage imageNamed:@"beat2"];
        self.beatthree.image = [UIImage imageNamed:@"beat3"];
        self.beatfour.image = [UIImage imageNamed:@"beat4"];
        self.beatfive.image = [UIImage imageNamed:@"beat5"];
        self.beatsix.image = [UIImage imageNamed:@"beat6"];
        self.beatseven.image = [UIImage imageNamed:@"beat7"];
        self.beateight.image = [UIImage imageNamed:@"beat8"];
        self.beatnine.image = [UIImage imageNamed:@"beat9on"];
    }
    
    
    NSLog(@"Timer Fire! Beatnumber = %ld", self.beatnumber);
    
    
}

- (IBAction)bmpentered:(UITextField *)sender {
    NSString *bpmstring = self.bpmtextfield.text;
    self.bpm = [bpmstring intValue];
    self.bpmstepper.value = self.bpm;
    
    NSLog(@"bpm = %f", self.bpm);
    NSLog(@"stepper value = %f", self.bpmstepper.value);
}

- (IBAction)bpmincremented:(UIStepper *)sender {
    NSInteger steppervalue = [sender value];
    NSString *bpmstring = [NSString stringWithFormat:@"%li", steppervalue];
    self.bpmtextfield.text = bpmstring;
    self.bpm = [bpmstring intValue];
    NSLog(@"bpm = %f", self.bpm);
}


- (void) setupaudio  {
    NSString *UpClickPath = [NSString stringWithFormat:@"%@/UpClick.wav",
                             [[NSBundle mainBundle] resourcePath]];
    NSURL *UpClickURL = [NSURL fileURLWithPath:UpClickPath];
    self.UpClickAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:UpClickURL error:nil];
    [self.UpClickAudioPlayer prepareToPlay];
    
    NSString *ClickPath = [NSString stringWithFormat:@"%@/Click.wav",
                               [[NSBundle mainBundle] resourcePath]];
    NSURL *ClickURL = [NSURL fileURLWithPath:ClickPath];
    self.ClickAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:ClickURL error:nil];
    [self.ClickAudioPlayer prepareToPlay];
    
    NSString *DownClickPath = [NSString stringWithFormat:@"%@/DownClick.wav",
                           [[NSBundle mainBundle] resourcePath]];
    NSURL *DownClickURL = [NSURL fileURLWithPath:DownClickPath];
    self.DownClickAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:DownClickURL error:nil];
    [self.DownClickAudioPlayer prepareToPlay];
    
    NSLog(@"Audio Setup");
    
}
@end

