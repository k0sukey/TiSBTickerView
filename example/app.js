// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
win.open();

// TODO: write your module tests here
var TiSBTicker = require('be.k0suke.tisbtickerview');
var direction = TiSBTicker.TICK_DIRECTION_DOWN;

var tickerView = TiSBTicker.createView({
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
});
win.add(tickerView);

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

var tickButton = Ti.UI.createButton({
	bottom: 10,
	width: Ti.UI.SIZE,
	height: Ti.UI.SIZE,
	title: 'TICK'
});
win.add(tickButton);

tickButton.addEventListener('click', function(){
	tickerView.tick({
		direction: direction,
		animate: true
	});
});