
$(function(){

    /*ハンバーガーボタンをクリックしたらactiveクラスを付与する*/
    $('#hamburger_button2').on('click', function(e){
        
        //クリックした場所のクラスの表示↓
        // let click_class = e.target.className;
        // console.log(click_class);

        $('#hamburger_button2').toggleClass('active');
        $('#hamburger_nav').toggleClass('active');
        console.log("ボタン");
        e.stopPropagation();
    });

    /*#hamburger_navをクリックしたときイベントが親要素に伝播して.frontをクリックしたときの処理が開始しないようにする*/
    $('#hamburger_nav').on('click', function(e) {
        e.stopPropagation();
    });

    /*画面をクリックしたときナビがactiveだったら剥奪する*/
    $('#front' ).on('click', function(e) {
        
        let tmp = $('#hamburger_nav');
        if(tmp.hasClass('active')) {
            $('#hamburger_button2').removeClass('active');
            $('#hamburger_nav').removeClass('active');
        } 
        
    });

});