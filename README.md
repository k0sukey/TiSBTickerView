## TiSBTickerView

Wrapping [SBTickerView](https://github.com/blommegard/SBTickerView), on Titanium app.

![image](TiSBTickerView.png)

### Install

[Compiled module download](be.k0suke.tisbtickerview-iphone-0.1.zip)

	$ git clone git@github.com:k0sukey/TiSBTickerView.git
	$ cd TiSBTickerView
	$ git submodule init
	$ git submodule update

Open TiSBTickerView.xcodeproj and edit the SBTickerView/SBGradientOverlayLayer.h

	#import <UIKit/UIKit.h>

Execute build.py

	$ ./build.py

### Usage

	var TiSBTicker = require('be.k0suke.tisbtickerview'),
		direction = TiSBTicker.TICK_DIRECTION_DOWN,
		window = Ti.UI.createWindow(),
		tickerView = TiSBTicker.createView({
			width: 200,
			height: 200,
			frontView: Ti.UI.createLabel({
				top: 0,
				right: 0,
				bottom: 0,
				left: 0,
				width: Ti.UI.FILL,
				height: Ti.UI.FILL,
				backgroundColor: '#fff',
				borderColor: '#000',
				borderRadius: 8,
				text: 'FRONT',
				color: '#000',
				font: {
					fontSize: 40,
					fontWeight: 'bold'
				},
				textAlign: Ti.UI.TEXT_ALIGNMENT_CENTER,
				verticalAlign: Ti.UI.TEXT_VERTICAL_ALIGNMENT_CENTER
			}),
			backView: Ti.UI.createLabel({
				top: 0,
				right: 0,
				bottom: 0,
				left: 0,
				width: Ti.UI.FILL,
				height: Ti.UI.FILL,
				backgroundColor: '#000',
				borderRadius: 8,
				text: 'BACK',
				color: '#fff',
				font: {
					fontSize: 40,
					fontWeight: 'bold'
				},
				textAlign: Ti.UI.TEXT_ALIGNMENT_CENTER,
				verticalAlign: Ti.UI.TEXT_VERTICAL_ALIGNMENT_CENTER
			}),
			duration: 1000
		}),
		tickButton = Ti.UI.createButton({
			bottom: 10,
			width: Ti.UI.SIZE,
			height: Ti.UI.SIZE,
			title: 'TICK'
		});
	window.add(tickerView);
	window.add(tickButton);
	window.open();
	
	tickerView.addEventListener('start', function(){
		tickButton.setEnabled(false);
	});
	
	tickerView.addEventListener('complete', function(){
		if (direction === TiSBTicker.TICK_DIRECTION_DOWN) {
			direction = TiSBTicker.TICK_DIRECTION_UP;
		} else {
			direction = TiSBTicker.TICK_DIRECTION_DOWN;
		}
		
		tickButton.setEnabled(true);
	});
	
	tickButton.addEventListener('click', function(){
		tickerView.tick({
			direction: direction,
			animate: true
		});
	});

### License

The MIT License (MIT) Copyright (c) 2014 Kosuke Isobe, Socketbase Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.