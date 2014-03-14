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
    TiUIView *view = (TiUIView*)[args view];
    [tickerView setFrontView:view];
}

-(void)setBackView_:(id)args
{
    ENSURE_SINGLE_ARG_OR_NIL(args, TiViewProxy);
    
    if (args == nil)
    {
        return;
    }
    
    SBTickerView *tickerView = [[self subviews] objectAtIndex:0];
    TiUIView *view = (TiUIView*)[args view];
    [tickerView setBackView:view];
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

@end
