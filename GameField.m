//
//  GameField.m
//  CocoaGameOfLife
//
//  Created by vileda on 22.03.09.
//  Copyright 2009 Tristan Leo. All rights reserved.
//

#import "GameField.h"

@implementation GameField

@synthesize height;
@synthesize width;
@synthesize cells;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		width = 80;
		height = 80;
		cellSize = 4;
		cursor = [NSCursor crosshairCursor];
		[cursor setOnMouseEntered:YES];		
		cells = [[NSMutableArray alloc] initWithCapacity:width];
		
		for (int i = 0; i < width; i++) {
			NSMutableArray *row = [NSMutableArray arrayWithCapacity:height];
			for (int j = 0; j < height; j++) {
				[row insertObject:[[Cell alloc] init] atIndex: j];
			}
			[cells insertObject:row atIndex:i];
		}
    }
    return self;
}

- (void) resetCursorRects
{
	[self addCursorRect:[self visibleRect] cursor:cursor];
}

- (void)drawRect:(NSRect)rect
{
	[[NSColor whiteColor] set];
	NSRectFill(rect);
	
	for (int i = 0; i < width; i++) {
		for (int j = 0; j < height; j++) {
			Cell* cell = [self cellAtColumn:i andRow:j];
			NSRect cellRect = NSMakeRect(i*cellSize, j*cellSize, cellSize, cellSize);
			[[NSColor blueColor] set];
			if(cell.alive)
				NSRectFill(cellRect);
		}
	}
}

- (void) reset
{
	for (int i = 0; i < width; i++) {
		for (int j = 0; j < height; j++) {
			[[self cellAtColumn:i andRow:j] setAlive:NO];
		}
	}
	[self setNeedsDisplay:YES];
}

- (void)updateCells
{
	NSMutableArray *nextGen = [[NSMutableArray alloc] initWithCapacity:width];
	
	for (int i = 0; i < width; i++) {
		NSMutableArray *row = [NSMutableArray arrayWithCapacity:height];
		for (int j = 0; j < height; j++) {
			int n = [self findNeighboursForCellAtColumn:i andRow:j];
			Cell *cell = [self cellAtColumn:i andRow:j];
			Cell *nextCell = [[Cell alloc] init];
			if((n == 2) && [cell alive]) {
                // Cells that are alive, with 2 neighbours stay alive
                [nextCell setAlive:YES];
            }
            else if(n == 3) {
                // Cells that have 3 neighbours are alive
                [nextCell setAlive:YES];
            }
            else {
                // Everyone else dies
                [nextCell setAlive:NO];
            }
			[row insertObject:nextCell atIndex: j];
		}
		[nextGen insertObject:row atIndex:i];
	}
	[cells release];
	[self setCells:nextGen];

	[self setNeedsDisplay:YES];
}

- (int)findNeighboursForCellAtColumn:(int)colKey andRow:(int)rowKey
{
    int total = 0;
	
    // Row Above
    if([self cellAliveAtColumn:(colKey - 1) andRow:(rowKey + 1)])
        total++;
    if([self cellAliveAtColumn:colKey andRow:(rowKey + 1)])
        total++;
    if([self cellAliveAtColumn:(colKey + 1) andRow:(rowKey + 1)])
        total++;
	
    // Left & Right
    if([self cellAliveAtColumn:(colKey - 1) andRow:rowKey])
        total++;
    if([self cellAliveAtColumn:(colKey + 1) andRow:rowKey])
        total++;
	
    // Row Below
    if([self cellAliveAtColumn:(colKey - 1) andRow:(rowKey - 1)])
        total++;
    if([self cellAliveAtColumn:colKey andRow:(rowKey - 1)])
        total++;
    if([self cellAliveAtColumn:(colKey + 1) andRow:(rowKey - 1)])
        total++;
	
    return total;
}

- (bool)cellAliveAtColumn:(int)colKey andRow:(int)rowKey
{
    return [[self cellAtColumn:colKey andRow:rowKey] alive];
}

- (Cell *)cellAtColumn:(int)colKey andRow:(int)rowKey
{
    if((colKey < 0 || colKey >= [self width]) || (rowKey < 0 || rowKey >= [self height]))
        return nil;
    return [[cells objectAtIndex:colKey] objectAtIndex:rowKey];
}

- (void)mouseDown:(NSEvent*)theEvent
{
	NSPoint mouseLoc = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	float x = floor(mouseLoc.x/cellSize);
	float y = floor(mouseLoc.y/cellSize);
	
	Cell* cell = (Cell*)[[cells objectAtIndex:x] objectAtIndex:y];
	[cell toggle];

	[self setNeedsDisplay:YES];
}

-(void)setWidth:(int)w
{
	width = w;
	NSSize s;
	s.height = height*cellSize;
	s.width = width*cellSize;
	[self viewWillStartLiveResize];
	[self setFrameSize:s];
	[self viewDidEndLiveResize];
}

-(void)setHeight:(int)h
{
	height = h;
	NSSize s;
	s.height = height*cellSize;
	s.width = width*cellSize;
	[self setFrameSize:s];
	[self setNeedsDisplay:true];
}

@end
