//
//  FirstViewController.m
//  ELEC2660 Project
//
//  Created by Angus Moore on 20/11/2017.
//  Copyright © 2017 Leeds.ac.uk. All rights reserved.
//

#import "MetronomeViewController.h"
#import "MetronomeData.h"

@interface MetronomeViewController ()

- (IBAction)Playpressed:(UIButton *)sender;
- (IBAction)Stoppressed:(UIButton *)sender;


@end

@implementation MetronomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.MetreTempoPicker.delegate = self;
    self.MetreTempoPicker.dataSource = self;
    self.bpmtextfield.delegate = self;
    self.metronomedata = [[MetronomeData alloc] init];
    self.bpmtextfield.text = @"120";
    self.bpm = 120;
    self.bpmstepper.value = 120;

    
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
    self.metronomedata.SelectedMetre = [self.MetreTempoPicker selectedRowInComponent:0];
    self.metronomedata.SelectedTempo = [self.MetreTempoPicker selectedRowInComponent:1];
    self.bpm = self.metronomedata.gettempobpm;
    NSString *bpmstring = [NSString stringWithFormat:@"%li", (long)self.bpm];
    self.bpmtextfield.text = bpmstring;
    self.bpmstepper.value = self.bpm;
    NSLog(@"bpm = %li", self.bpm);
    NSLog(@"stepper value = %f", self.bpmstepper.value);
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

#pragma end of picker methods

- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event {//taken from stack overflow
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]])
            [view resignFirstResponder];
    }
}


- (BOOL)textField:(UITextField *)textField //taken from stack overflow https://stackoverflow.com/questions/27916943/how-to-not-allow-the-user-to-enter-a-value-more-than-190-in-uitextfield
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    NSString *checkstring = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if([checkstring intValue] > 240){
        return NO;
    }
        return YES;
}



- (IBAction)Playpressed:(UIButton *)sender {
}

- (IBAction)Stoppressed:(UIButton *)sender {
}



- (IBAction)bmpentered:(UITextField *)sender {
    NSString *bpmstring = self.bpmtextfield.text;
    self.bpm = [bpmstring intValue];
    self.bpmstepper.value = self.bpm;

    NSLog(@"bpm = %ld", self.bpm);
    NSLog(@"stepper value = %f", self.bpmstepper.value);
}
     
- (IBAction)bpmincremented:(UIStepper *)sender {
    NSInteger steppervalue = [sender value];
    NSString *bpmstring = [NSString stringWithFormat:@"%li", steppervalue];
    self.bpmtextfield.text = bpmstring;
    self.bpm = [bpmstring intValue];
    NSLog(@"bpm = %li", self.bpm);
}
@end
