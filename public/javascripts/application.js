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
}

function showClientForm(){
	$( 'client-form' ).style.display = 'block';
}

function showEditClientForm( id ){
	$( 'client-header-' + id ).style.display = 'none';
	$( 'client-edit-' + id ).style.display = 'block';
}

function showEditExpenseForm( id ){
	$( 'expense-' + id ).style.display = 'none';
	$( 'edit-expense-' + id ).style.display = 'block';
}

function showEditIntervalForm( id ){
	$( 'interval-' + id ).style.display = 'none';
	$( 'edit-interval-' + id ).style.display = 'block';
}

function hideNotice(){
	$( 'notice' ).style.display = 'none';
}

function confirmDelete( entity, url ){
	if( confirm( 'Are you sure you wish to delete this ' + entity + '?' ) ){
		window.location = url;
	}
}

window.onload = init;

function init(){
	var clients = $$( 'h1.client' );
	
	for( var i = 0; i < clients.length; i++ ){
		clients[i].onmouseover = showEditControls;
		clients[i].onmouseout = hideEditControls;
	}
	
	var entries = $$( 'div.entry-wrapper' );
	
	for( var i = 0; i < entries.length; i++ ){
		entries[i].onmouseover = showEditControls;
		entries[i].onmouseout = hideEditControls;
	}	
	
	var option_links = $$( 'div.options a' );
	
	for( var i = 0; i < option_links.length; i++ ){
		option_links[i].onclick = hideOptions;
	}
}

function showEditControls( e ){	
	for( var i = 0; i < this.childNodes.length; i++ ){
		if( this.childNodes[i].className == "edit-link" ){
			this.childNodes[i].style.display = 'inline';
		}
	}
}

function hideEditControls( e ){
	for( var i = 0; i < this.childNodes.length; i++ ){
		if( this.childNodes[i].className == "edit-link" ){
			this.childNodes[i].style.display = 'none';
		}
	}
}

function toggleClientInfo( id ){
	if( $( 'client-info-' + id ).style.display != 'none' ){
		$( 'client-info-' + id ).style.display = 'none';
	}else{
		$( 'client-info-' + id ).style.display = 'block';
	}
}

function toggleViewOptions(){
	if( $( 'view-options' ).style.display != 'block' ){
		$( 'view-options' ).style.display = 'block';
		$( 'show-view-options-link' ).innerHTML = '- Hide view options';
	}else{
		$( 'view-options' ).style.display = 'none';
		$( 'show-view-options-link' ).innerHTML = '+ Show view options';
	}
}

function setClientCheckboxes( v ){
	var boxes = $$( '.client-checkbox' );
	
	for( var i = 0; i < boxes.length; i++ ){
		boxes[i].checked = v;
	}
}

function showOptions( id ){
	hideOptions();
	$( 'client-options-' + id ).style.display = 'block';
	$( 'client-options-link-' + id ).addClassName( 'selected' );
	return false;
}

function hideOptions(){
	$$( 'div.options' ).each( function(d){
		d.style.display = 'none';
	})
	
	$$( 'a.cog' ).each( function(l){
		l.removeClassName( 'selected' );
	})
}