// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
// show lightbox
function load_timone(content)
{
	show_timone();
	$('timone_content').innerHTML = "<table width='100%' height='100%'><tr><td align='center'><b>Loading...</b><br/><img src='/images/pumbaa.gif'></td></tr></table>";
	$('timone_content').innerHTML = content;
}

function show_timone()
{
	$('timone_overlay').style.display = 'block';
	$('timone_closer').style.display = 'block';
	$('timone_content').style.display = 'block';
}

function hide_timone()
{
	$('timone_overlay').setStyle({display : 'none'});
	$('timone_closer').setStyle({display : 'none'});
	$('timone_content').setStyle({display : 'none'});
}
