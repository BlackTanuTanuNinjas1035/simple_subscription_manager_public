$(document).ready(function () {
    $('#select_subscription').select2();
});

// 下　html内の直書きcssを無効化　bodyタグ内のstyelを消してるらしい
// $(function() {
// 	$('body *').removeAttr('style');
// });
//　特定のタグの直書きcss無効化
$(function() {
	$('.select2.select2-container.select2-container--default').removeAttr('style');
});