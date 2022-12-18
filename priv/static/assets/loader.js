$(window).on('load', function() {
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
        }, 100);
    }
    
    sleep(30, function () {
        console.log('3秒経過しました！');
        let load = document.querySelector("#load");
        load.classList.add("loaded");
        sleep(3, function() {
            console.log("3.3秒経過しました！");
            load.classList.add("none");
        });
    });
});