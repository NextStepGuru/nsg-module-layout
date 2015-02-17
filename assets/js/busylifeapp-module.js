$(function() {

	$('.trello-sync  a').on('click',function(e){
		e.preventDefault();
		if(!$(this).hasClass('disabled')){
			$('#newTrello').val($(this).attr('rel'));
			$('#trelloText').html($(this).html()).parent().removeClass('disabled');
			checkNewSync();
		}
	});

	$('.evernote-sync a').on('click',function(e){
		e.preventDefault();
		if(!$(this).hasClass('disabled')){
			$('#newEvernote').val($(this).attr('rel'));
			$('#evernoteText').html($(this).html()).parent().removeClass('disabled');
			checkNewSync();
		}
	});
});

function checkNewSync(){
	if( $('#newEvernote').val().length && $('#newTrello').val().length ){
		$('#newButton').removeClass('disabled');
	}
}