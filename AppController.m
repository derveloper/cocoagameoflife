//
//  AppController.m
//  CocoaGameOfLife
//
//  Created by vileda on 22.03.09.
//  Copyright 2009 Tristan Leo. All rights reserved.
//

#import "AppController.h"


@implementation AppController

@synthesize generation;
@synthesize speed;

- (id) init
{
	self = [super init];
	if (self != nil) {
		generation = 0;
		speed = 1000;
	}
	return self;
}

- (IBAction)reset:(id)sender
{
	[self setGeneration:0];
	[view reset];
}

- (void)timerFired:(id)sender
{
    [view updateCells];
	[self setGeneration:[self generation]+1];
}

- (IBAction)play:(id)sender
{
    if(updateTimer == nil) {
        [play setTitle:@"Stop"];
        updateTimer = [NSTimer scheduledTimerWithTimeInterval:speed/1000
                                                       target:self
                                                     selector:@selector(timerFired:)
                                                     userInfo:nil
                                                      repeats:YES];
    }
    else {
        [play setTitle:@"Start"];
        [updateTimer invalidate];
        updateTimer = nil;
    }
}

@end
