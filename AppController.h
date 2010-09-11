//
//  AppController.h
//  CocoaGameOfLife
//
//  Created by vileda on 22.03.09.
//  Copyright 2009 Tristan Leo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GameField.h"

@interface AppController : NSObject {
	int generation;
	NSTimer *updateTimer;
	IBOutlet NSButton *play;
	IBOutlet GameField *view;
	float speed;
}
@property(readwrite, assign) int generation;
@property(readwrite, assign) float speed;

#pragma mark events
- (IBAction)play:(id)sender;
- (void)timerFired:(id)sender;
- (IBAction)reset:(id)sender;

@end
