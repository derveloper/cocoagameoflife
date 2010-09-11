//
//  Cell.h
//  CocoaGameOfLife
//
//  Created by vileda on 22.03.09.
//  Copyright 2009 Tristan Leo. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Cell : NSObject {
	bool alive;
}

@property(readwrite, assign) bool alive;
- (void)toggle;

@end
