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
    
    
}

#pragma picker data methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    NSInteger rows = 0;
    if(component == 0){
        rows = 4;
    } else if (component == 1){
        rows = 13;
    }
    return rows;
}

#pragma remove keyboard

- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event {// taken from stack overflow
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
}

- (void) timerfire:(NSTimer *)metronometimer{
    
    self.beatnumber++;
    if ([self.MetreTempoPicker selectedRowInComponent:0] == 0){
        if (self.beatnumber > 2){
            self.beatnumber = 1;
        }
    }else if ([self.MetreTempoPicker selectedRowInComponent:0] == 1){
        if (self.beatnumber > 3){
            self.beatnumber = 1;
        }
    }else if ([self.MetreTempoPicker selectedRowInComponent:0] == 2){
        if (self.beatnumber > 4){
            self.beatnumber = 1;
        }
    }else if ([self.MetreTempoPicker selectedRowInComponent:0] == 3){
        if (self.beatnumber > 6){
            self.beatnumber = 1;
        }
    }
    
    if (self.beatnumber == 1){
        if ([self.UpClickAudioPlayer isPlaying]){
            [self.UpClickAudioPlayer stop];
            self.UpClickAudioPlayer.currentTime = 0.0;
        }
        [self.UpClickAudioPlayer play];
        self.beatone.image = [UIImage imageNamed:@"beat1on"];
        self.beattwo.image = [UIImage imageNamed:@"beat2"];
        self.beatthree.image = [UIImage imageNamed:@"beat3"];
        self.beatfour.image = [UIImage imageNamed:@"beat4"];
        self.beatfive.image = [UIImage imageNamed:@"beat5"];
        self.beatsix.image = [UIImage imageNamed:@"beat6"];
    } else if (self.beatnumber == 2){
        if ([self.DownClickAudioPlayer isPlaying]){
            [self.DownClickAudioPlayer stop];
            self.DownClickAudioPlayer.currentTime = 0.0;
        }
        [self.DownClickAudioPlayer play];
        self.beatone.image = [UIImage imageNamed:@"beat1"];
        self.beattwo.image = [UIImage imageNamed:@"beat2on"];
        self.beatthree.image = [UIImage imageNamed:@"beat3"];
        self.beatfour.image = [UIImage imageNamed:@"beat4"];
        self.beatfive.image = [UIImage imageNamed:@"beat5"];
        self.beatsix.image = [UIImage imageNamed:@"beat6"];
    }  else if (self.beatnumber == 3){
        if ([self.DownClickAudioPlayer isPlaying]){
            [self.DownClickAudioPlayer stop];
            self.DownClickAudioPlayer.currentTime = 0.0;
        }
        [self.DownClickAudioPlayer play];
        self.beatone.image = [UIImage imageNamed:@"beat1"];
        self.beattwo.image = [UIImage imageNamed:@"beat2"];
        self.beatthree.image = [UIImage imageNamed:@"beat3on"];
        self.beatfour.image = [UIImage imageNamed:@"beat4"];
        self.beatfive.image = [UIImage imageNamed:@"beat5"];
        self.beatsix.image = [UIImage imageNamed:@"beat6"];
    } else if (self.beatnumber == 4){
        if ([self.DownClickAudioPlayer isPlaying]){
            [self.DownClickAudioPlayer stop];
            self.DownClickAudioPlayer.currentTime = 0.0;
        }
        [self.DownClickAudioPlayer play];
        self.beatone.image = [UIImage imageNamed:@"beat1"];
        self.beattwo.image = [UIImage imageNamed:@"beat2"];
        self.beatthree.image = [UIImage imageNamed:@"beat3"];
        self.beatfour.image = [UIImage imageNamed:@"beat4on"];
        self.beatfive.image = [UIImage imageNamed:@"beat5"];
        self.beatsix.image = [UIImage imageNamed:@"beat6"];
    } else if (self.beatnumber == 5){
        if ([self.DownClickAudioPlayer isPlaying]){
            [self.DownClickAudioPlayer stop];
            self.DownClickAudioPlayer.currentTime = 0.0;
        }
        [self.DownClickAudioPlayer play];
        self.beatone.image = [UIImage imageNamed:@"beat1"];
        self.beattwo.image = [UIImage imageNamed:@"beat2"];
        self.beatthree.image = [UIImage imageNamed:@"beat3"];
        self.beatfour.image = [UIImage imageNamed:@"beat4"];
        self.beatfive.image = [UIImage imageNamed:@"beat5on"];
        self.beatsix.image = [UIImage imageNamed:@"beat6"];
    } else if (self.beatnumber == 6){
        if ([self.DownClickAudioPlayer isPlaying]){
            [self.DownClickAudioPlayer stop];
            self.DownClickAudioPlayer.currentTime = 0.0;
        }
        [self.DownClickAudioPlayer play];
        self.beatone.image = [UIImage imageNamed:@"beat1"];
        self.beattwo.image = [UIImage imageNamed:@"beat2"];
        self.beatthree.image = [UIImage imageNamed:@"beat3"];
        self.beatfour.image = [UIImage imageNamed:@"beat4"];
        self.beatfive.image = [UIImage imageNamed:@"beat5"];
        self.beatsix.image = [UIImage imageNamed:@"beat6on"];
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
    
    NSString *DownClickPath = [NSString stringWithFormat:@"%@/DownClick.wav",
                               [[NSBundle mainBundle] resourcePath]];
    NSURL *DownClickURL = [NSURL fileURLWithPath:DownClickPath];
    self.DownClickAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:DownClickURL error:nil];
    [self.DownClickAudioPlayer prepareToPlay];
    
    NSLog(@"Audio Setup");
    
}
@end

