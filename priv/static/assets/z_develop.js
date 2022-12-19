console.log("z_develop start");
let start_time = performance.now();
// setTimeout(function(){
//     console.log("10秒経過しました")
// },10000);
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
    console.log("z_develop end", (end_time - start_time) / 1000 + "秒");
    // console.log("エンド" + (end_time - start_time) / 1000 + "秒");
});