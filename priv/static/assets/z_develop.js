let start_time = performance.now();

$(function() {
        // setIntervalを使う方法
        function sleep(waitSec, callbackFunc) {
            // 経過時間（秒）
            var spanedSec = 0;
            // 1秒間隔で無名関数を実行
            var id = setInterval(function () {
                spanedSec++;
                // 経過時間 >= 待機時間の場合、待機終了。
                if (spanedSec >= waitSec) {
                    // タイマー停止
                    clearInterval(id);
                    // 完了時、コールバック関数を実行
                    if (callbackFunc) callbackFunc();
                }
            }, 1000);
        }
        sleep(5, function () {
            console.log('5秒経過しました！');
        });
        console.log("経過後");
});

$(window).on('load', function() {
    let end_time = performance.now();
    console.log((end_time - start_time) / 1000 + "秒");
});


//ロードとリサイズ時の処理
$(window).on('load resize', function(){
    var winW = $(window).width();
    var devW = 767;
    if (winW <= devW) {
    //767px以下の時の処理
        console.log("767以下だよー");

    } else {
    //768pxより大きい時の処理
        console.log("768以上だよー");
    }
});