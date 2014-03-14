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

var views = [];
for (var i = 0; i < 10; i++) {
	views.push(Ti.UI.createLabel({
		top: 0,
		right: 0,
		bottom: 0,
		left: 0,
		width: Ti.UI.FILL,
		height: Ti.UI.FILL,
		backgroundColor: i % 2 ? '#fff' : '#000',
		borderColor: '#000',
		borderRadius: 8,
		text: i,
		color: i % 2 ? '#000' : '#fff',
		font: {
			fontSize: 40,
			fontWeight: 'bold'
		},
		textAlign: Ti.UI.TEXT_ALIGNMENT_CENTER,
		verticalAlign: Ti.UI.TEXT_VERTICAL_ALIGNMENT_CENTER
	}));
}

var tickerView = TiSBTicker.createView({
	width: 200,
	height: 200,
	views: views
});
win.add(tickerView);

tickerView.addEventListener('start', function(){
	tickButton.setTitle('STOP');
	tickButton.setEnabled(true);
});

tickerView.addEventListener('progress', function(e){
	console.log(e.index);
});

tickerView.addEventListener('complete', function(){
	tickButton.setTitle('START');
	tickButton.setEnabled(true);
});

var tickButton = Ti.UI.createButton({
	bottom: 10,
	width: Ti.UI.SIZE,
	height: Ti.UI.SIZE,
	title: 'START'
});
win.add(tickButton);

tickButton.addEventListener('click', function(){
	tickButton.setEnabled(false);

	if (tickButton.getTitle() === 'START') {
		tickerView.start({
			direction: TiSBTicker.TICK_DIRECTION_DOWN,
			animate: true,
			interval: 500,
			loop: true
		});
	} else {
		tickerView.stop();
	}
});