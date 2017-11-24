//
//  SecondViewController.m
//  ELEC2660 Project
//
//  Created by Angus Moore on 20/11/2017.
//  Copyright © 2017 Leeds.ac.uk. All rights reserved.
//

#import "TunerViewController.h"
#import "TunerData.h"

@interface TunerViewController ()

@end

@implementation TunerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.Notepicker.delegate = self;
    self.Notepicker.dataSource = self;
    self.tunerdata =[[TunerData alloc]init];
    [self setupAudioPlayers];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma picker delegate methods

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{
    return [self.tunerdata.pickertonearray objectAtIndex:row];
}


- (void) pickerView:(UIPickerView *)pickerView
       didSelectRow:(NSInteger)row
        inComponent:(NSInteger)component{
    
    self.tunerdata.pickerdatanote = [self.Notepicker selectedRowInComponent:0];
    self.selectednote = self.tunerdata.getpickernote;
    NSLog(@"Selected Note %@", self.selectednote);
    
    }

#pragma picker data methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 14;
    
}

-(void) setupAudioPlayers{
    NSString *C4Path = [NSString stringWithFormat:@"%@/C4.wav",
    [[NSBundle mainBundle] resourcePath]];
    NSURL *C4URL = [NSURL fileURLWithPath:C4Path];
    self.C4AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:C4URL error:nil];
    NSLog(@"Audio Setup");
    
}




- (IBAction)Playpressed:(UIButton *)sender {
    
    [self.C4AudioPlayer play];
    NSLog(@"button pressed");
}

- (IBAction)Stoppressed:(UIButton *)sender {
}
@end
