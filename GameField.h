//
//  GameField.h
//  CocoaGameOfLife
//
//  Created by vileda on 22.03.09.
//  Copyright 2009 Tristan Leo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "Cell.h"

@interface GameField : NSView {
	NSMutableArray *cells;
	int width;
	int height;
	int cellSize;
	NSCursor *cursor;
}
@property(readwrite, assign) int width;
@property(readwrite, assign) int height;
@property(readwrite, assign) NSMutableArray *cells;

- (void) reset;
- (int)findNeighboursForCellAtColumn:(int)colKey andRow:(int)rowKey;
- (bool)cellAliveAtColumn:(int)colKey andRow:(int)rowKey;
- (Cell *)cellAtColumn:(int)colKey andRow:(int)rowKey;
- (void)updateCells;

@end
