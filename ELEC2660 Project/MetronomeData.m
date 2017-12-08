//
//  MetronomeData.m
//  ELEC2660 Project
//
//  Created by Angus Moore on 20/11/2017.
//  Copyright © 2017 Leeds.ac.uk. All rights reserved.
//

#import "MetronomeData.h"

@implementation MetronomeData


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.MetreArray = [NSArray arrayWithObjects:@"2/4", // index 0
                           @"3/4", // index 1
                           @"4/4", // index 2
                           @"6/8", // index 3
                           @"9/8", // index 4
                           nil];
        
        self.TempoArray = [NSArray arrayWithObjects:@"Sostenuto", // index 0
                           @"Grave", // index 1
                           @"Largo", // index 2
                           @"Larghetto", // index 3
                           @"Adagio", // index 4
                           @"Andante", // index 5
                           @"Andantino", // index 6
                           @"Moderato", // index 7
                           @"Allegro", // index 8
                           @"Veloce", // index 9
                           @"Vivace", // index 10
                           @"Presto", // index 11
                           @"Prestissimo", // index 12
                           nil];
        
    }
    return self;
}

#pragma mark - Tempo and metre data methods

-(NSInteger) gettempobpm{ // Return current tempo depending on picker row
    NSInteger databpm = 0;
    if (_SelectedTempo == 0){
        databpm = 20;
    } else if (_SelectedTempo == 1){
        databpm = 35;
    } else if (_SelectedTempo == 2){
        databpm = 50;
    } else if (_SelectedTempo == 3){
        databpm = 65;
    } else if (_SelectedTempo == 4){
        databpm = 75;
    } else if (_SelectedTempo == 5){
        databpm = 88;
    } else if (_SelectedTempo == 6){
        databpm = 105;
    } else if (_SelectedTempo == 7){
        databpm = 120;
    } else if (_SelectedTempo == 8){
        databpm = 140;
    } else if (_SelectedTempo == 9){
        databpm = 160;
    } else if (_SelectedTempo == 10){
        databpm = 170;
    } else if (_SelectedTempo == 11){
        databpm = 190;
    } else if (_SelectedTempo == 12){
        databpm = 210;}
    
    return databpm;
}

- (NSString *) getmetre { // Return current metre depending on picker row
    NSString *datametre;
    if (self.SelectedMetre == 0){
        datametre = @"2/4";
    } else if (self.SelectedMetre == 1){
        datametre = @"3/4";
    } else if (self.SelectedMetre == 2){
        datametre = @"4/4";
    } else if (self.SelectedMetre == 3){
        datametre = @"6/8";
    } else if (self.SelectedMetre == 4){
        datametre = @"9/8";
    }
    return datametre;
}



@end

