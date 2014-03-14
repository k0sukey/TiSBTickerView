/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2014年 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiUIView.h"

@interface BeK0sukeTisbtickerviewView : TiUIView {
    NSMutableArray *_views;
    NSTimer *_timer;
    NSInteger _index;
    BOOL _start;
    int _direction;
    BOOL _animate;
    BOOL _loop;
}

-(void)tick:(id)args;
-(void)start:(id)args;
-(void)stop:(id)args;

@end
