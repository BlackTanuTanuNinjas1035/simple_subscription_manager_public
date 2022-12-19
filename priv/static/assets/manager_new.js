$(document).ready(function () {
    //select2の適用
    $('.select_subscription').select2();
});


$(function() {
    // 下　html内の直書きcssを無効化　bodyタグ内のstyelを消してるらしい　なんかselect2使うと余計なやつがついてくるから
    // $(function() {
    // 	$('body *').removeAttr('style');
    // });
    //　特定のタグの直書きcss無効化
	$('.select2.select2-container.select2-container--default').removeAttr('style');


    //ジャンルのセレクトボックスの値を取得し、それに対応したジャンルの選択画面を表示するやつの最初の一回する初期化するやつ
    let select_val = $("#genre_select option:selected").val();
    let selected_genre = ".select_content_" + select_val;
    console.log(selected_genre);
    //現在activeがついてるやつを一旦消してから、当該のやつにactiveを付与する
    $(".select_content.active").removeClass("active");
    $(selected_genre).addClass("active");


    //ジャンルのセレクトボックスを変更するたび実行するやつ
    $("#genre_select").change(function() {
        let select_text = $("#genre_select option:selected").text();
        let select_val = $("#genre_select option:selected").val();
        let selected_genre = ".select_content_" + select_val;
        //console.log(select_text);
        console.log(selected_genre);
        $(".select_content.active").removeClass("active");
        $(selected_genre).addClass("active");
    })


    //セレクトボックスで選択されたサービスに対応する説明文を表示する処理
    //すべて
    //初期値　セレクトボックスの初期値を取得し表示する
    var val = $("#select_subscription").val();
    var selected_subsc = '#' + val;
    //console.log(selected_subsc);
    $(".subsc_info_all").find("li").removeClass("active");
    $(selected_subsc).addClass("active")
    //ジャンルがすべてのセレクトボックスでサービスを選択するたび、当該の説明文を表示する
    $("#select_subscription").change(function() {
        var val = $(this).val();
        var selected_subsc = '#' + val;
        console.log(selected_subsc);
        $(".subsc_info_all").find("li").removeClass("active");
        $(selected_subsc).addClass("active");
    })

    //動画
    //初期値
    var val = $("#select_subscription_by_video").val();
    var selected_subsc = '#video-' + val;
    console.log(selected_subsc);
    $(".subsc_info_video").find("li").removeClass("active");
    $(selected_subsc).addClass("active")
    //選択毎
    $("#select_subscription_by_video").change(function() {
        var val = $(this).val();
        var selected_subsc = '#video-' + val;
        console.log(selected_subsc);
        $(".subsc_info_video").find("li").removeClass("active");
        $(selected_subsc).addClass("active");
    })

    //音楽
    //初期値
    var val = $("#select_subscription_by_music").val();
    var selected_subsc = '#music-' + val;
    console.log(selected_subsc);
    $(".subsc_info_music").find("li").removeClass("active");
    $(selected_subsc).addClass("active")
    //選択毎
    $("#select_subscription_by_music").change(function() {
        var val = $(this).val();
        var selected_subsc = '#music-' + val;
        console.log(selected_subsc);
        $(".subsc_info_music").find("li").removeClass("active");
        $(selected_subsc).addClass("active");
    })

    //カーレンタル
    //初期値
    var val = $("#select_subscription_by_car").val();
    var selected_subsc = '#car-' + val;
    console.log(selected_subsc);
    $(".subsc_info_car").find("li").removeClass("active");
    $(selected_subsc).addClass("active")
    //選択毎
    $("#select_subscription_by_car").change(function() {
        var val = $(this).val();
        var selected_subsc = '#car-' + val;
        console.log(selected_subsc);
        $(".subsc_info_car").find("li").removeClass("active");
        $(selected_subsc).addClass("active");
    })

    //食品
    //初期値
    var val = $("#select_subscription_by_food").val();
    var selected_subsc = '#food-' + val;
    console.log(selected_subsc);
    $(".subsc_info_food").find("li").removeClass("active");
    $(selected_subsc).addClass("active")
    //選択毎
    $("#select_subscription_by_food").change(function() {
        var val = $(this).val();
        var selected_subsc = '#food-' + val;
        console.log(selected_subsc);
        $(".subsc_info_food").find("li").removeClass("active");
        $(selected_subsc).addClass("active");
    })

    //ソフトウェア
    //初期値
    var val = $("#select_subscription_by_software").val();
    var selected_subsc = '#software-' + val;
    console.log(selected_subsc);
    $(".subsc_info_software").find("li").removeClass("active");
    $(selected_subsc).addClass("active")
    //選択毎
    $("#select_subscription_by_software").change(function() {
        var val = $(this).val();
        var selected_subsc = '#software-' + val;
        console.log(selected_subsc);
        $(".subsc_info_software").find("li").removeClass("active");
        $(selected_subsc).addClass("active");
    })

    //家具
    //初期値
    var val = $("#select_subscription_by_furniture").val();
    var selected_subsc = '#furniture-' + val;
    console.log(selected_subsc);
    $(".subsc_info_furniture").find("li").removeClass("active");
    $(selected_subsc).addClass("active")
    //選択毎
    $("#select_subscription_by_furniture").change(function() {
        var val = $(this).val();
        var selected_subsc = '#furniture-' + val;
        console.log(selected_subsc);
        $(".subsc_info_furniture").find("li").removeClass("active");
        $(selected_subsc).addClass("active");
    })

    //習い事
    //初期値
    var val = $("#select_subscription_by_lesson").val();
    var selected_subsc = '#lesson-' + val;
    console.log(selected_subsc);
    $(".subsc_info_lesson").find("li").removeClass("active");
    $(selected_subsc).addClass("active")
    //選択毎
    $("#select_subscription_by_lesson").change(function() {
        var val = $(this).val();
        var selected_subsc = '#lesson-' + val;
        console.log(selected_subsc);
        $(".subsc_info_lesson").find("li").removeClass("active");
        $(selected_subsc).addClass("active");
    })

    //家具
    //初期値
    var val = $("#select_subscription_by_book").val();
    var selected_subsc = '#book-' + val;
    console.log(selected_subsc);
    $(".subsc_info_book").find("li").removeClass("active");
    $(selected_subsc).addClass("active")
    //選択毎
    $("#select_subscription_by_book").change(function() {
        var val = $(this).val();
        var selected_subsc = '#book-' + val;
        console.log(selected_subsc);
        $(".subsc_info_book").find("li").removeClass("active");
        $(selected_subsc).addClass("active");
    })
    
    $(".discription_button").on("click", function() {
        $(".discription").slideToggle();
    })

});