// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function startTimer( start ){
	d = new Date();
	now = d.getTime();

	var diff = new Date( now - start );

	var hours = ""+(diff.getHours() - 1);
	var mins = ""+diff.getMinutes();
	var secs = ""+diff.getSeconds();
		
	if( hours.length == 1 ) hours = '0' + hours;
	if( mins.length == 1 ) mins = '0' + mins;
	if( secs.length == 1 ) secs = '0' + secs;
	
	$( 'counter' ).innerHTML = hours + ":" + mins + ":" + secs;
}

function showExpenseForm( id ){
	$( 'expense-form-' + id ).style.display = 'block';
	$( 'expense-link-' + id ).style.display = 'none';
}

function showClientForm(){
	$( 'client-link' ).style.display = 'none';
	$( 'client-form' ).style.display = 'block';
}