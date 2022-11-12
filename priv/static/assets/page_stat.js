$(function(){
    $(".tab_button").on("click", function(){
        //ボタンのactiveの切り替え
        let selected_button = $(this);
        $(".tab_button").removeClass("active");
        $(selected_button).addClass("active");

        //ランキング部分のactive切り替え
        let selected = selected_button.data("tab");
        //console.log(selected);
        let selected_tab = ".ranking_" + selected;
        console.log(selected_tab);
        $(".ranking").removeClass("active");
        $(selected_tab).addClass("active");
    })

    //olから値取る
    let ol_class = $("#unko li:nth-child(1)").child(".subsc_reginum");
    console.log(ol_class);
})