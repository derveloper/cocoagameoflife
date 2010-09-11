//
//  Cell.m
//  CocoaGameOfLife
//
//  Created by vileda on 22.03.09.
//  Copyright 2009 Tristan Leo. All rights reserved.
//

#import "Cell.h"


@implementation Cell

@synthesize alive;

- (id)init
{
    [super init];
    alive = NO;
    return self;
	
}

- (void)toggle
{
    [self setAlive:![self alive]];
}

@end
