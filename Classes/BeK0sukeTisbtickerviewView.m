/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2014年 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "BeK0sukeTisbtickerviewView.h"
#import "TiViewProxy.h"

#import "SBTickerView.h"

@implementation BeK0sukeTisbtickerviewView

-(void)initializeState
{
    [super initializeState];
    
    if (self)
    {
        _start = NO;
        
        SBTickerView *tickerView = [[SBTickerView alloc] initWithFrame:CGRectZero];
        [self addSubview:tickerView];
    }
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    SBTickerView *tickerView = [[self subviews] objectAtIndex:0];
    [tickerView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    
    [super frameSizeChanged:frame bounds:bounds];
}

-(void)setFrontView_:(id)args
{
    ENSURE_SINGLE_ARG_OR_NIL(args, TiViewProxy);
    
    if (args == nil)
    {
        return;
    }
    
    SBTickerView *tickerView = [[self subviews] objectAtIndex:0];
    [tickerView setFrontView:(TiUIView*)[args view]];
}

-(void)setBackView_:(id)args
{
    ENSURE_SINGLE_ARG_OR_NIL(args, TiViewProxy);
    
    if (args == nil)
    {
        return;
    }
    
    SBTickerView *tickerView = [[self subviews] objectAtIndex:0];
    [tickerView setBackView:(TiUIView*)[args view]];
}

-(void)setViews_:(id)args
{
    if (_start)
    {
        [self stop:nil];
    }
    
    ENSURE_TYPE_OR_NIL(args, NSArray);
    
    if ([args count] == 0)
    {
        return;
    }
    
    [_views removeAllObjects];
    _views = [args mutableCopy];
    
    SBTickerView *tickerView = [[self subviews] objectAtIndex:0];
    [tickerView setFrontView:(TiUIView*)[[_views objectAtIndex:0] view]];
}

-(void)setDuration_:(id)args
{
    SBTickerView *tickerView = [[self subviews] objectAtIndex:0];
    [tickerView setDuration:[TiUtils floatValue:args def:1000.0f] / 1000.0f];
}

-(void)setPanning_:(id)args
{
    SBTickerView *tickerView = [[self subviews] objectAtIndex:0];
    [tickerView setPanning:[TiUtils boolValue:args def:NO]];
}

-(void)setAllowedPanDirections_:(id)args
{
    SBTickerView *tickerView = [[self subviews] objectAtIndex:0];
    [tickerView setAllowedPanDirections:args];
}

-(void)tick:(id)args
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    ENSURE_UI_THREAD_1_ARG(args);
#pragma clang diagnostic pop
    
    NSDictionary *properties;
    ENSURE_ARG_AT_INDEX(properties, args, 0, NSDictionary);
    
    if ([self.proxy _hasListeners:@"start"])
    {
        [self.proxy fireEvent:@"start"];
    }
    
    SBTickerView *tickerView = [[self subviews] objectAtIndex:0];
    [tickerView tick:[TiUtils intValue:[properties objectForKey:@"direction"] def:0]
            animated:[TiUtils boolValue:[properties objectForKey:@"animate"] def:YES]
          completion:^{
              if ([self.proxy _hasListeners:@"complete"])
              {
                  [self.proxy fireEvent:@"complete"];
              }
          }];
}

-(void)start:(id)args
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    ENSURE_UI_THREAD_1_ARG(args);
#pragma clang diagnostic pop
    
    NSDictionary *properties;
    ENSURE_ARG_AT_INDEX(properties, args, 0, NSDictionary);
    
    if (_start)
    {
        return;
    }
    
    _start = YES;
    
    _direction = [TiUtils intValue:[properties objectForKey:@"direction"] def:0];
    _animate = [TiUtils boolValue:[properties objectForKey:@"animate"] def:YES];
    _loop = [TiUtils boolValue:[properties objectForKey:@"loop"] def:NO];
    
    SBTickerView *tickerView = [[self subviews] objectAtIndex:0];
    [tickerView setDuration:[TiUtils floatValue:[properties objectForKey:@"interval"] def:1000.0f] / 1000.0f * 0.5f];
    
    if ([self.proxy _hasListeners:@"start"])
    {
        [self.proxy fireEvent:@"start"];
    }
    
    _index = 1;
    _timer = [NSTimer scheduledTimerWithTimeInterval:[TiUtils floatValue:[properties objectForKey:@"interval"] def:1000.0f] / 1000.0f
                                              target:self
                                            selector:@selector(ticks:)
                                            userInfo:nil
                                             repeats:YES];
}

-(void)stop:(id)args
{
    if (!_start)
    {
        false;
    }
    
    if (_timer != nil)
    {
        [_timer invalidate];
        
        if ([self.proxy _hasListeners:@"complete"])
        {
            [self.proxy fireEvent:@"complete"];
        }

    }
    
    _start = NO;
    _index = 1;
}

-(void)ticks:(id)sender
{
    if (_index >= [_views count])
    {
        if (_loop)
        {
            _index = 0;
        }
        else
        {
            [self stop:nil];
            return;
        }
    }
    
    SBTickerView *tickerView = [[self subviews] objectAtIndex:0];
    
    
    if ([_views count] == 1)
    {
        [tickerView setBackView:(TiUIView*)[[_views objectAtIndex:0] view]];
    }
    else
    {
        [tickerView setBackView:(TiUIView*)[[_views objectAtIndex:_index] view]];
    }
    
    [tickerView tick:_direction
            animated:_animate
          completion:^{
              if ([self.proxy _hasListeners:@"progress"])
              {
                  NSMutableDictionary *event = [TiUtils dictionaryWithCode:0 message:nil];
                  [event setObject:[NSString stringWithFormat:@"%d", _index - 1] forKey:@"index"];
                  [self.proxy fireEvent:@"progress" withObject:event];
              }
          }];
    
    _index++;
}

@end
