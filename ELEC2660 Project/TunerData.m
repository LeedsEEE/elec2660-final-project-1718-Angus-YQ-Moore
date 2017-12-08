//
//  TunerData.m
//  ELEC2660 Project
//
//  Created by Angus Moore on 20/11/2017.
//  Copyright © 2017 Leeds.ac.uk. All rights reserved.
//

#import "TunerData.h"

// Define frequency values for C1 - B6
#define C1      32.70
#define Csharp1 34.65
#define D1      36.71
#define Dsharp1 38.89
#define E1      41.20
#define F1      43.65
#define Fsharp1 46.25
#define G1      49.00
#define Gsharp1 51.91
#define A1      55.00
#define Asharp1 58.27
#define B1      61.74
#define C2      65.41
#define Csharp2 69.30
#define D2      73.42
#define Dsharp2 77.78
#define E2      82.41
#define F2      87.31
#define Fsharp2 92.50
#define G2      98.00
#define Gsharp2 103.83
#define A2      110.00
#define Asharp2 116.54
#define B2      123.47
#define C3      130.81
#define Csharp3 138.59
#define D3      146.83
#define Dsharp3 155.56
#define E3      164.81
#define F3      174.61
#define Fsharp3 185.00
#define G3      196.00
#define Gsharp3 207.65
#define A3      220.00
#define Asharp3 233.08
#define B3      246.94
#define C4      261.63
#define Csharp4 277.18
#define D4      293.66
#define Dsharp4 311.13
#define E4      329.63
#define F4      349.23
#define Fsharp4 369.99
#define G4      392.00
#define Gsharp4 415.30
#define A4      440.00
#define Asharp4 466.16
#define B4      493.88
#define C5      523.25
#define Csharp5 554.37
#define D5      587.33
#define Dsharp5 622.25
#define E5      659.25
#define F5      698.46
#define Fsharp5 739.99
#define G5      783.99
#define Gsharp5 830.61
#define A5      880.00
#define Asharp5 932.33
#define B5      987.77
#define C6      1046.50
#define Csharp6 1108.73
#define D6      1174.66
#define Dsharp6 1244.51
#define E6      1318.51
#define F6      1396.91
#define Fsharp6 1479.98
#define G6      1567.98
#define Gsharp6 1661.22
#define A6      1760.00
#define Asharp6 1864.66
#define B6      1975.53

@implementation TunerData

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pickertonearray =[NSArray arrayWithObjects:@"C5" //index 0
                               ,@"C#5/Db5" //index 1
                               ,@"D5"      //index 2
                               ,@"D#5/Eb5" //index 3
                               ,@"E5"      //index 4
                               ,@"F5"      //index 5
                               ,@"F#5/Gb5" //index 6
                               ,@"G5"      //index 7
                               ,@"G#5/Ab5" //index 8
                               ,@"A5"      //index 9
                               ,@"A#5/Bb5" //index 10
                               ,@"B5"      //index 11
                               ,@"C6"      //index 12
                               ,@"C#6/Db6" //index 13
                               ,@"D6"      //index 14
                               ,@"D#6/Eb6" //index 15
                               ,@"E6"      //index 16
                               ,@"F6"      //index 17
                               ,@"F#6/Gb6" //index 18
                               ,@"G6"      //index 19
                               ,@"G#6/Ab6" //index 20
                               ,@"A6"      //index 21
                               ,@"A#6/Bb6" //index 22
                               ,@"B6"      //index 23
                               , nil];

    }
    return self;
}

#pragma mark - get picker note data method
- (NSString*)getpickernote{
    NSString *pickernote;
    // Return selected pitch depending on picker row
    if (_pickerdatanote == 0){
        pickernote =@ "C5";
    } else if(_pickerdatanote == 1){
        pickernote = @"C#5/Db5";
    } else if(_pickerdatanote == 2){
        pickernote = @"D5";
    } else if(_pickerdatanote == 3){
        pickernote = @"D#5/Eb5";
    } else if(_pickerdatanote == 4){
        pickernote = @"E5";
    } else if(_pickerdatanote == 5){
        pickernote = @"F5";
    } else if(_pickerdatanote == 6){
        pickernote = @"F#5/Gb5";
    } else if(_pickerdatanote == 7){
        pickernote = @"G5";
    } else if(_pickerdatanote == 8){
        pickernote = @"G#5/Ab5";
    } else if(_pickerdatanote == 9){
        pickernote = @"A5";
    } else if(_pickerdatanote == 10){
        pickernote = @"A#5/Bb5";
    } else if(_pickerdatanote == 11){
        pickernote = @"B5";
    } else if(_pickerdatanote == 12){
        pickernote = @"C6";
    } else if(_pickerdatanote == 13){
        pickernote = @"C#6/Db6";
    } else if(_pickerdatanote == 14){
        pickernote = @"D6";
    } else if(_pickerdatanote == 15){
        pickernote = @"D#6/Eb6";
    } else if(_pickerdatanote == 16){
        pickernote = @"E6";
    } else if(_pickerdatanote == 17){
        pickernote = @"F6";
    } else if(_pickerdatanote == 18){
        pickernote = @"F#6/Gb6";
    } else if(_pickerdatanote == 19){
        pickernote = @"G6";
    } else if(_pickerdatanote == 20){
        pickernote = @"G#6/Ab6";
    } else if(_pickerdatanote == 21){
        pickernote = @"A6";
    } else if(_pickerdatanote == 22){
        pickernote = @"A#6/Bb6";
    } else if(_pickerdatanote == 23){
        pickernote = @"B6";}
    
    return pickernote;
}


#pragma mark - Get indicator angle ratio data method

-(float)getindictorratio {
    //  Calculate the ratio of, the distance between the frequency of the current closet pitch to the calculated
    //  frequency, and the distance between the frequency of the closest pitch and second closest pitch.
    //  Will return a float value between -1 and 1

    float angle;
    float firstseconddistance;
    
    if ([self.closestnotedata isEqualToString:@"C1"]){
        
        if (_currentfrequencydata > C1){
            firstseconddistance = (C1 - Csharp1);//negative
        } else {
            firstseconddistance = (C1 - 30.87); //positive
            firstseconddistance = -firstseconddistance; //made negative
        }
        
        angle = ((C1 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
        
    } else if ([self.closestnotedata isEqualToString:@"C#1"]){
        
        if (_currentfrequencydata > Csharp1){
            firstseconddistance = (Csharp1 - D1);//negative
        } else {
            firstseconddistance = (Csharp1 - C1); //positive
            firstseconddistance = -firstseconddistance; //made negative
        }
        
        angle = ((Csharp1 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
        
    } else if ([self.closestnotedata isEqualToString:@"D1"]){
        
        if (_currentfrequencydata > D1){
            firstseconddistance = (D1 - Dsharp1);//negative
        } else {
            firstseconddistance = (D1 - Csharp1); //positive
            firstseconddistance = -firstseconddistance; //made negative
        }
        
        angle = ((D1 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
        
    } else if ([self.closestnotedata isEqualToString:@"D#1"]){
        
        if (_currentfrequencydata > Dsharp1){
            firstseconddistance = (Dsharp1 - E1);//negative
        } else {
            firstseconddistance = (Dsharp1 - D1); //positive
            firstseconddistance = -firstseconddistance; //made negative
        }
        
        angle = ((Dsharp1 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"E1"]){
        
        if (_currentfrequencydata > E1){
            firstseconddistance = (E1 - F1);//negative
        } else {
            firstseconddistance = (E1 - Dsharp1); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((E1 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"F1"]){
        
        if (_currentfrequencydata > F1){
            firstseconddistance = (F1 - Fsharp1);//negative
        } else {
            firstseconddistance = (F1 - E1); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((F1 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"F#1"]){
        
        if (_currentfrequencydata > Fsharp1){
            firstseconddistance = (Fsharp1 - G1);//negative
        } else {
            firstseconddistance = (Fsharp1 - F1); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Fsharp1 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"G1"]){
        
        if (_currentfrequencydata > G1){
            firstseconddistance = (G1 - Gsharp1);//negative
        } else {
            firstseconddistance = (G1 - Fsharp1); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((G1 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"G#1"]){
        
        if (_currentfrequencydata > Gsharp1){
            firstseconddistance = (Gsharp1 - A1);//negative
        } else {
            firstseconddistance = (Gsharp1 - G1); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Gsharp1 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"A1"]){
        
        if (_currentfrequencydata > A1){
            firstseconddistance = (A1 - Asharp1);//negative
        } else {
            firstseconddistance = (A1 - Gsharp1); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((A1 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"A#1"]){
        
        if (_currentfrequencydata > Asharp1){
            firstseconddistance = (Asharp1 - B1);//negative
        } else {
            firstseconddistance = (Asharp1 - A1); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Asharp1 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"B1"]){
        
        if (_currentfrequencydata > B1){
            firstseconddistance = (B1 - C1);//negative
        } else {
            firstseconddistance = (B1 - Asharp1); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((B1 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"C2"]){
        
        if (_currentfrequencydata > C2){
            firstseconddistance = (C2 - Csharp2);//negative
        } else {
            firstseconddistance = (C2 - B1); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((C2 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"C#2"]){
        
        if (_currentfrequencydata > Csharp2){
            firstseconddistance = (Csharp2 - D2);//negative
        } else {
            firstseconddistance = (Csharp2 - C2); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Csharp2 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"D2"]){
        
        if (_currentfrequencydata > D2){
            firstseconddistance = (D2 - Dsharp2);//negative
        } else {
            firstseconddistance = (D2 - Csharp2); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((D2 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"D#2"]){
        
        if (_currentfrequencydata > Dsharp2){
            firstseconddistance = (Dsharp2 - E2);//negative
        } else {
            firstseconddistance = (Dsharp2 - D2); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Dsharp2 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"E2"]){
        
        if (_currentfrequencydata > E2){
            firstseconddistance = (E2 - F2);//negative
        } else {
            firstseconddistance = (E2 - Dsharp2); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((E2 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"F2"]){
        
        if (_currentfrequencydata > F2){
            firstseconddistance = (F2 - Fsharp2);//negative
        } else {
            firstseconddistance = (F2 - E2); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((F2 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"F#2"]){
        
        if (_currentfrequencydata > Fsharp2){
            firstseconddistance = (Fsharp2 - G2);//negative
        } else {
            firstseconddistance = (Fsharp2 - F2); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Fsharp2 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"G2"]){
        
        if (_currentfrequencydata > G2){
            firstseconddistance = (G2 - Gsharp2);//negative
        } else {
            firstseconddistance = (G2 - Fsharp2); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((G2 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"G#2"]){
        
        if (_currentfrequencydata > Gsharp2){
            firstseconddistance = (Gsharp2 - A2);//negative
        } else {
            firstseconddistance = (Gsharp2 - G2); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Gsharp2 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"A2"]){
        
        if (_currentfrequencydata > A2){
            firstseconddistance = (A2 - Asharp2);//negative
        } else {
            firstseconddistance = (A2 - Gsharp2); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((A2 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"A#2"]){
        
        if (_currentfrequencydata > Asharp2){
            firstseconddistance = (Asharp2 - B2);//negative
        } else {
            firstseconddistance = (Asharp2 - A2); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Asharp2 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"B2"]){
        
        if (_currentfrequencydata > B2){
            firstseconddistance = (B2 - C3);//negative
        } else {
            firstseconddistance = (B2 - Asharp2); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((B2 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"C3"]){
        
        if (_currentfrequencydata > C3){
            firstseconddistance = (C3 - Csharp3);//negative
        } else {
            firstseconddistance = (C3 - B2); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((C3 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"C#3"]){
        
        if (_currentfrequencydata > Csharp3){
            firstseconddistance = (Csharp3 - D3);//negative
        } else {
            firstseconddistance = (Csharp3 - C3); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Csharp3 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"D3"]){
        
        if (_currentfrequencydata > D3){
            firstseconddistance = (D3 - Dsharp3);//negative
        } else {
            firstseconddistance = (D3 - Csharp3); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((D3 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"D#3"]){
        
        if (_currentfrequencydata > Dsharp3){
            firstseconddistance = (Dsharp3 - E3);//negative
        } else {
            firstseconddistance = (Dsharp3 - D3); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Dsharp3 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"E3"]){
        
        if (_currentfrequencydata > E3){
            firstseconddistance = (E3 - F3);//negative
        } else {
            firstseconddistance = (E3 - Dsharp3); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((E3 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"F3"]){
        
        if (_currentfrequencydata > F3){
            firstseconddistance = (F3 - Fsharp3);//negative
        } else {
            firstseconddistance = (F3 - E3); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((F3 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"F#3"]){
        
        if (_currentfrequencydata > Fsharp3){
            firstseconddistance = (Fsharp3 - G3);//negative
        } else {
            firstseconddistance = (Fsharp3 - F3); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Fsharp3 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"G3"]){
        
        if (_currentfrequencydata > G3){
            firstseconddistance = (G3 - Gsharp3);//negative
        } else {
            firstseconddistance = (G3 - Fsharp3); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((G3 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"G#3"]){
        
        if (_currentfrequencydata > Gsharp3){
            firstseconddistance = (Gsharp3 - A3);//negative
        } else {
            firstseconddistance = (Gsharp3 - G3); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Gsharp3 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"A3"]){
        
        if (_currentfrequencydata > A3){
            firstseconddistance = (A3 - Asharp3);//negative
        } else {
            firstseconddistance = (A3 - Gsharp3); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((A3 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"A#3"]){
        
        if (_currentfrequencydata > Asharp3){
            firstseconddistance = (Asharp3 - B3);//negative
        } else {
            firstseconddistance = (Asharp3 - A3); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Asharp3 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"B3"]){
        
        if (_currentfrequencydata > B3){
            firstseconddistance = (B3 - C3);//negative
        } else {
            firstseconddistance = (B3 - Asharp3); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((B3 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"C4"]){
        
        if (_currentfrequencydata > C4){
            firstseconddistance = (C4 - Csharp4);//negative
        } else {
            firstseconddistance = (C4 - B3); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((C4 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"C#4"]){
        
        if (_currentfrequencydata > Csharp4){
            firstseconddistance = (Csharp4 - D4);//negative
        } else {
            firstseconddistance = (Csharp4 - C4); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Csharp4 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"D4"]){
        
        if (_currentfrequencydata > D4){
            firstseconddistance = (D4 - Dsharp4);//negative
        } else {
            firstseconddistance = (D4 - Csharp4); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((D4 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"D#4"]){
        
        if (_currentfrequencydata > Dsharp4){
            firstseconddistance = (Dsharp4 - E4);//negative
        } else {
            firstseconddistance = (Dsharp4 - D4); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Dsharp4 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"E4"]){
        
        if (_currentfrequencydata > E4){
            firstseconddistance = (E4 - F4);//negative
        } else {
            firstseconddistance = (E4 - Dsharp4); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((E4 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"F4"]){
        
        if (_currentfrequencydata > F4){
            firstseconddistance = (F4 - Fsharp4);//negative
        } else {
            firstseconddistance = (F4 - E4); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((F4 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"F#4"]){
        
        if (_currentfrequencydata > Fsharp4){
            firstseconddistance = (Fsharp4 - G4);//negative
        } else {
            firstseconddistance = (Fsharp4 - F4); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Fsharp4 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"G4"]){
        
        if (_currentfrequencydata > G4){
            firstseconddistance = (G4 - Gsharp4);//negative
        } else {
            firstseconddistance = (G4 - Fsharp4); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((G4 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"G#4"]){
        
        if (_currentfrequencydata > Gsharp4){
            firstseconddistance = (Gsharp4 - A4);//negative
        } else {
            firstseconddistance = (Gsharp4 - G4); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Gsharp4 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"A4"]){
        
        if (_currentfrequencydata > A4){
            firstseconddistance = (A4 - Asharp4);//negative
        } else {
            firstseconddistance = (A4 - Gsharp4); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((A4 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"A#4"]){
        
        if (_currentfrequencydata > Asharp4){
            firstseconddistance = (Asharp4 - B4);//negative
        } else {
            firstseconddistance = (Asharp4 - A4); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Asharp4 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"B4"]){
        
        if (_currentfrequencydata > B4){
            firstseconddistance = (B4 - C5);//negative
        } else {
            firstseconddistance = (B4 - Asharp4); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((B4 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"C5"]){
        
        if (_currentfrequencydata > C5){
            firstseconddistance = (C5 - Csharp5);//negative
        } else {
            firstseconddistance = (C5 - B4); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((C5 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"C#5"]){
        
        if (_currentfrequencydata > Csharp5){
            firstseconddistance = (Csharp5 - D5);//negative
        } else {
            firstseconddistance = (Csharp5 - C5); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Csharp5 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    }  else if ([self.closestnotedata isEqualToString:@"D5"]){
        
        if (_currentfrequencydata > D5){
            firstseconddistance = (D5 - Dsharp5);//negative
        } else {
            firstseconddistance = (D5 - Csharp5); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((D5 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    }  else if ([self.closestnotedata isEqualToString:@"D#5"]){
        
        if (_currentfrequencydata > Dsharp5){
            firstseconddistance = (Dsharp5 - E5);//negative
        } else {
            firstseconddistance = (Dsharp5 - D5); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Dsharp5 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    }  else if ([self.closestnotedata isEqualToString:@"E5"]){
        
        if (_currentfrequencydata > E5){
            firstseconddistance = (E5 - F5);//negative
        } else {
            firstseconddistance = (E5 - Dsharp5); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((E5 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    }  else if ([self.closestnotedata isEqualToString:@"F5"]){
        
        if (_currentfrequencydata > F5){
            firstseconddistance = (F5 - Fsharp5);//negative
        } else {
            firstseconddistance = (F5 - E5); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((F5 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    }  else if ([self.closestnotedata isEqualToString:@"F#5"]){
        
        if (_currentfrequencydata > Fsharp5){
            firstseconddistance = (Fsharp5 - G5);//negative
        } else {
            firstseconddistance = (Fsharp5 - F5); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Fsharp5 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    }  else if ([self.closestnotedata isEqualToString:@"G5"]){
        
        if (_currentfrequencydata > G5){
            firstseconddistance = (G5 - Gsharp5);//negative
        } else {
            firstseconddistance = (G5 - Fsharp5); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((G5 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    }  else if ([self.closestnotedata isEqualToString:@"G#5"]){
        
        if (_currentfrequencydata > Gsharp5){
            firstseconddistance = (Gsharp5 - A5);//negative
        } else {
            firstseconddistance = (Gsharp5 - G5); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Gsharp5 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    }  else if ([self.closestnotedata isEqualToString:@"A5"]){
        
        if (_currentfrequencydata > A5){
            firstseconddistance = (A5 - Asharp5);//negative
        } else {
            firstseconddistance = (A5 - Gsharp5); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((A5 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    }  else if ([self.closestnotedata isEqualToString:@"A#5"]){
        
        if (_currentfrequencydata > Asharp5){
            firstseconddistance = (Asharp5 - B5);//negative
        } else {
            firstseconddistance = (Asharp5 - A5); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Asharp5 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    }  else if ([self.closestnotedata isEqualToString:@"B5"]){
        
        if (_currentfrequencydata > B5){
            firstseconddistance = (B5 - C6);//negative
        } else {
            firstseconddistance = (B5 - Asharp5); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((B5 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    }  else if ([self.closestnotedata isEqualToString:@"C6"]){
        
        if (_currentfrequencydata > C6){
            firstseconddistance = (C6 - Csharp6);//negative
        } else {
            firstseconddistance = (C6 - B5); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((C6 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"C#6"]){
        
        if (_currentfrequencydata > Csharp6){
            firstseconddistance = (Csharp6 - D6);//negative
        } else {
            firstseconddistance = (Csharp6 - C6); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Csharp6 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"D6"]){
        
        if (_currentfrequencydata > D6){
            firstseconddistance = (D6 - Dsharp6);//negative
        } else {
            firstseconddistance = (D6 - Csharp6); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((D6 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"D#6"]){
        
        if (_currentfrequencydata > Dsharp6){
            firstseconddistance = (Dsharp6 - E6);//negative
        } else {
            firstseconddistance = (Dsharp6 - D6); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Dsharp6 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"E6"]){
        
        if (_currentfrequencydata > E6){
            firstseconddistance = (E6 - F6);//negative
        } else {
            firstseconddistance = (E6 - Dsharp6); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((E6 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"F6"]){
        
        if (_currentfrequencydata > F6){
            firstseconddistance = (F6 - Fsharp6);//negative
        } else {
            firstseconddistance = (F6 - E6); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((F6 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"F#6"]){
        
        if (_currentfrequencydata > Fsharp6){
            firstseconddistance = (Fsharp6 - G6);//negative
        } else {
            firstseconddistance = (Fsharp6 - F6); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Fsharp6 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"G6"]){
        
        if (_currentfrequencydata > G6){
            firstseconddistance = (G6 - Gsharp6);//negative
        } else {
            firstseconddistance = (G6 - Fsharp6); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((G6 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"G#6"]){
        
        if (_currentfrequencydata > Gsharp6){
            firstseconddistance = (Gsharp6 - A6);//negative
        } else {
            firstseconddistance = (Gsharp6 - G6); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Gsharp6 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"A6"]){
        
        if (_currentfrequencydata > A6){
            firstseconddistance = (A6 - Asharp6);//negative
        } else {
            firstseconddistance = (A6 - Gsharp6); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((A6 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"A#6"]){
        
        if (_currentfrequencydata > Asharp6){
            firstseconddistance = (Asharp6 - B6);//negative
        } else {
            firstseconddistance = (Asharp6 - A6); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((Asharp6 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else if ([self.closestnotedata isEqualToString:@"B6"]){
        
        if (_currentfrequencydata > B6){
            firstseconddistance = (B6 - 2093.00);//negative
        } else {
            firstseconddistance = (B6 - Asharp6); //positive
            firstseconddistance = -firstseconddistance;
        }
        
        angle = ((B6 - self.currentfrequencydata))/(firstseconddistance);//top = negative when freq > cloestnote
    } else {
        angle = 0;
    }
  
    return angle;
}



@end

