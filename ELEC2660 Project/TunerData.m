//
//  TunerData.m
//  ELEC2660 Project
//
//  Created by Angus Moore on 20/11/2017.
//  Copyright © 2017 Leeds.ac.uk. All rights reserved.
//

#import "TunerData.h"

#define C1      32.70  //index 11 C1
#define Csharp1 34.65  //index 12 C#1
#define D1      36.71 //index 13 D1
#define Dsharp1 38.89 //index 14 D#1
#define E1      41.20 //index 15 E1
#define F1      43.65 //index 16 F1
#define Fsharp1 46.25 //index 17 F#1
#define G1      49.00 //index 18 G1
#define Gsharp1 51.91 //index 19 G#1
#define A1      55.00 //index 20 A1
#define Asharp1 58.27 //index 21 A#1
#define B1      61.74 //index 22 B1
#define C2      65.41 //index 23 C2
#define Csharp2 69.30 //index 24 C#2
#define D2      73.42 //index 25 D2
#define Dsharp2 77.78 //index 26 D#2
#define E2      82.41 //index 27 E2
#define F2      87.31 //index 28 F2
#define Fsharp2 92.50 //index 29 F#2
#define G2      98.00 //index 30 G2
#define Gsharp2 103.83 //index 31 G#2
#define A2      110.00 //index 32 A2
#define Asharp2 116.54 //index 33 A#2
#define B2      123.47 //index 34 B2
#define C3      130.81 //index 35 C3
#define Csharp3 138.59 //index 36 C#3
#define D3      146.83 //index 37 D3
#define Dsharp3 155.56 //index 38 D#3
#define E3      164.81 //index 39 E3
#define F3      174.61 //index 40 F3
#define Fsharp3 185.00 //index 41 F#3
#define G3      196.00 //index 42 G3
#define Gsharp3 207.65 //index 43 G#3
#define A3      220.00 //index 44 A3
#define Asharp3 233.08 //index 45 A#3
#define B3      246.94 //index 46 B3
#define C4      261.63 //index 47 C4
#define Csharp4 277.18 //index 48 C#4
#define D4      293.66 //index 49 D4
#define Dsharp4 311.13 //index 50 D#4
#define E4      329.63 //index 51 E4
#define F4      349.23 //index 52 F4
#define Fsharp4 369.99 //index 53 F#4
#define G4      392.00 //index 54 G4
#define Gsharp4 415.30 //index 55 G#4
#define A4      440.00 //index 56 A4
#define Asharp4 466.16 //index 57 A#4
#define B4      493.88 //index 58 B4
#define C5      523.25 //index 59 C5
#define Csharp5 554.37 //index 60 C#5
#define D5      587.33 //index 61 D5
#define Dsharp5 622.25 //index 62 D#5
#define E5      659.25 //index 63 E5
#define F5      698.46 //index 64 F5
#define Fsharp5 739.99 //index 65 F#5
#define G5      783.99 //index 66 G5
#define Gsharp5 830.61 //index 67 G#5
#define A5      880.00 //index 68 A5
#define Asharp5 932.33 //index 69 A#5
#define B5      987.77 //index 70 B5
#define C6      1046.50 //index 71 C6
#define Csharp6 1108.73 //index 72 C#6
#define D6      1174.66 //index 73 D6
#define Dsharp6 1244.51 //index 74 D#6
#define E6      1318.51 //index 75 E6
#define F6      1396.91 //index 76 F6
#define Fsharp6 1479.98 //index 77 F#6
#define G6      1567.98 //index 78 G6
#define Gsharp6 1661.22 //index 79 G#6
#define A6      1760.00 //index 80 A6
#define Asharp6 1864.66 //index 81 A#6
#define B6      1975.53 //index 82 B6

@implementation TunerData

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pickertonearray =[NSArray arrayWithObjects:@"C5"
                               ,@"D5"
                               ,@"E5"
                               ,@"F5"
                               ,@"G5"
                               ,@"A5"
                               ,@"B5"
                               ,@"C6"
                               ,@"D6"
                               ,@"E6"
                               ,@"F6"
                               ,@"G6"
                               ,@"A6"
                               ,@"B6", nil];
        
        
        self.notefreqvaluesarray = [NSMutableArray arrayWithObjects:
                                    @17.32f, //index 0 C#0
                                    @18.35f, //index 1 D0
                                    @19.45f, //index 2 D#0
                                    @20.60f, //index 3 E0
                                    @21.83f, //index 4 F0
                                    @23.12f, //index 5 F#0
                                    @24.50f, //index 6 G0
                                    @25.96f, //index 7 G#0
                                    @27.50f, //index 8 A0
                                    @29.14f, //index 9 A#0
                                    @30.87f, //index 10 B0
                                    @32.70f, //index 11 C1
                                    @34.65f, //index 12 C#1
                                    @36.71f, //index 13 D1
                                    @38.89f, //index 14 D#1
                                    @41.20f, //index 15 E1
                                    @43.65f, //index 16 F1
                                    @46.25f, //index 17 F#1
                                    @49.00f, //index 18 G1
                                    @51.91f, //index 19 G#1
                                    @55.00f, //index 20 A1
                                    @58.27f, //index 21 A#1
                                    @61.74f, //index 22 B1
                                    @65.41f, //index 23 C2
                                    @69.30f, //index 24 C#2
                                    @73.42f, //index 25 D2
                                    @77.78f, //index 26 D#2
                                    @82.41f, //index 27 E2
                                    @87.31f, //index 28 F2
                                    @92.50f, //index 29 F#2
                                    @98.00f, //index 30 G2
                                    @103.83f, //index 31 G#2
                                    @110.00f, //index 32 A2
                                    @116.54f, //index 33 A#2
                                    @123.47f, //index 34 B2
                                    @130.81f, //index 35 C3
                                    @138.59f, //index 36 C#3
                                    @146.83f, //index 37 D3
                                    @155.56f, //index 38 D#3
                                    @164.81f, //index 39 E3
                                    @174.61f, //index 40 F3
                                    @185.00f, //index 41 F#3
                                    @196.00f, //index 42 G3
                                    @207.65f, //index 43 G#3
                                    @220.00f, //index 44 A3
                                    @233.08f, //index 45 A#3
                                    @246.94f, //index 46 B3
                                    @261.63f, //index 47 C4
                                    @277.18f, //index 48 C#4
                                    @293.66f, //index 49 D4
                                    @311.13f, //index 50 D#4
                                    @329.63f, //index 51 E4
                                    @349.23f, //index 52 F4
                                    @369.99f, //index 53 F#4
                                    @392.00f, //index 54 G4
                                    @415.30f, //index 55 G#4
                                    @440.00f, //index 56 A4
                                    @466.16f, //index 57 A#4
                                    @493.88f, //index 58 B4
                                    @523.25f, //index 59 C5
                                    @554.37f, //index 60 C#5
                                    @587.33f, //index 61 D5
                                    @622.25f, //index 62 D#5
                                    @659.25f, //index 63 E5
                                    @698.46f, //index 64 F5
                                    @739.99f, //index 65 F#5
                                    @783.99f, //index 66 G5
                                    @830.61f, //index 67 G#5
                                    @880.00f, //index 68 A5
                                    @932.33f, //index 69 A#5
                                    @987.77f, //index 70 B5
                                    @1046.50f, //index 71 C6
                                    @1108.73f, //index 72 C#6
                                    @1174.66f, //index 73 D6
                                    @1244.51f, //index 74 D#6
                                    @1318.51f, //index 75 E6
                                    @1396.91f, //index 76 F6
                                    @1479.98f, //index 77 F#6
                                    @1567.98f, //index 78 G6
                                    @1661.22f, //index 79 G#6
                                    @1760.00f, //index 80 A6
                                    @1864.66f, //index 81 A#6
                                    @1975.53f, //index 82 B6
                                    @2093.00f, //index 83 C7
                                    @2217.46f, //index 84 C#7
                                    @2349.32f, //index 85 D7
                                    @2489.02f, //index 86 D#7
                                    @2637.02f, //index 87 E7
                                    @2793.83f, //index 88 F7
                                    @2959.96f, //index 89 F#7
                                    @3135.96f, //index 90 G7
                                    @3322.44f, //index 91 G#7
                                    @3520.00f, //index 92 A7
                                    @3729.31f, //index 93 A#7
                                    @3951.07f, //index 94 B7
                                    nil];
    
    }
    return self;
}

-(float)getindictorangle{
    
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
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  
    return angle;
}


- (NSString*)getpickernote{
    NSString *pickernote;
    if (_pickerdatanote == 0){
        pickernote =@ "C4";
    } else if(_pickerdatanote == 1){
        pickernote = @"D4";
    } else if(_pickerdatanote == 2){
        pickernote = @"E4";
    } else if(_pickerdatanote == 3){
        pickernote = @"F4";
    } else if(_pickerdatanote == 4){
        pickernote = @"G4";
    } else if(_pickerdatanote == 5){
        pickernote = @"A4";
    } else if(_pickerdatanote == 6){
        pickernote = @"B4";
    } else if(_pickerdatanote == 7){
        pickernote = @"C5";
    } else if(_pickerdatanote == 8){
        pickernote = @"D5";
    } else if(_pickerdatanote == 9){
        pickernote = @"E5";
    } else if(_pickerdatanote == 10){
        pickernote = @"F5";
    } else if(_pickerdatanote == 11){
        pickernote = @"G5";
    } else if(_pickerdatanote == 12){
        pickernote = @"A5";
    } else if(_pickerdatanote == 13){
        pickernote = @"B5";
    }
    
    return pickernote;
}

@end

