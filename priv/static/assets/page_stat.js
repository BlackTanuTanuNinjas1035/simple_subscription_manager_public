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
        //console.log(selected_tab);
        $(".ranking").removeClass("active");
        $(selected_tab).addClass("active");
    })
});

// $(window).on('load', function(){
// 	//console.log(chart_graph_overall_service);
//     console.log("window");
// });

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

//ol_rankingのtagdataを受け取るとspanの要素を取得し、リストにして返す
function get_ranking(ranking_and_graph_id) {
    //受取ったtag_dataはquerySelectorで取得したrankingのolのやつ
    //olから値取る
    let subsc_name_list = [];
    let subsc_reginum_list = [];
    let sum = 0;  //すべての合計件数
    let sum_less_than = 0; //11以下の合計件数
    //let ol_selected = document.querySelector(tag_data);

    let a = document.querySelector("#" + ranking_and_graph_id);
    let b = a.querySelector(".ol_ranking");

    let li_list = b.querySelectorAll("li");

    for(let i = 0; i < li_list.length; i++) {
        let tmp_name = li_list[i].querySelector(".subsc_name").textContent;
        let tmp_reginum = parseFloat(li_list[i].querySelector(".subsc_reginum").textContent);

        if (i < 10) {
            //10未満の処理
            subsc_name_list[i] = tmp_name;
            subsc_reginum_list[i] = tmp_reginum;
            sum += tmp_reginum;
        } else if (i == 10) {
            //10のときの処理
            subsc_name_list[10] = "その他";
            sum += tmp_reginum;
            sum_less_than += tmp_reginum;
        } else {
            sum += tmp_reginum;
            sum_less_than += tmp_reginum;
        }
    }
    subsc_reginum_list.push(sum_less_than)
    // console.log(subsc_name_list);
    // console.log(subsc_reginum_list);
    // console.log(sum);
    // console.log(sum_less_than);
    re = [subsc_name_list, subsc_reginum_list];
    return re
}

function get_ranking_genre(ranking_and_graph_id) {
    //受取ったtag_dataはquerySelectorで取得したrankingのolのやつ
    //olから値取る
    let subsc_genre_list = [];
    let subsc_reginum_list = [];
    let sum = 0;  //すべての合計件数
    let sum_less_than = 0; //11以下の合計件数
    //let ol_selected = document.querySelector(tag_data);
    let a = document.querySelector("#" + ranking_and_graph_id);
    let b = a.querySelector(".ol_ranking");
    let li_list = b.querySelectorAll("li");

    for(let i = 0; i < li_list.length; i++) {
        let tmp_genre = li_list[i].querySelector(".subsc_genre").textContent;
        let tmp_reginum = parseFloat(li_list[i].querySelector(".subsc_reginum").textContent);

        if (i < 10) {
            //10未満の処理
            subsc_genre_list[i] = tmp_genre;
            subsc_reginum_list[i] = tmp_reginum;
            sum += tmp_reginum;
        } else if (i == 10) {
            //10のときの処理
            subsc_genre_list[10] = "その他";
            sum += tmp_reginum;
            sum_less_than += tmp_reginum;
        } else {
            sum += tmp_reginum;
            sum_less_than += tmp_reginum;
        }
    }
    subsc_reginum_list.push(sum_less_than)
    // console.log(subsc_name_list);
    // console.log(subsc_reginum_list);
    // console.log(sum);
    // console.log(sum_less_than);
    re = [subsc_genre_list, subsc_reginum_list];
    return re
}


//年代別ランキングを囲ったage_genreのidを渡すとchart.jsでつかうdatasetsにいれるリストが返ってくる
function get_age_ranking_genre(age_genre_id){
    let age_genre = document.querySelector(age_genre_id);
    let age_genre_list = age_genre.querySelectorAll(".mini_ranking_and_graph"); 

    //初期化
     //年代の数　8個　ループするときに使う
    let age_num = 8
    //ジャンルのリスト
    let genre_list = [ "動画配信のサービス", "音楽配信のサービス", "カーレンタルのサービス", "食品のサービス", "ソフトウェア提供のサービス","家具・家電のサービス","習い事や趣味のサービス","本のサービス"]
    //age_data_listに8つの年代の辞書を格納する
    let age_data_list = [];
    for(let i = 0; i < age_num; i++) {
        //年代の個数ずつ空辞書をpush
        age_data_list.push({});
        for(let j = 0; j < genre_list.length; j++) {
            //すべてのジャンルの件数を0件にして初期化
            age_data_list[i][genre_list[j]] = 0;
        }
    }
    //console.log(age_data_list);


    //年代のループ　10未満　10代　20代
    for(let i = 0; i < age_num; i ++) {
        let ranking_and_graph_id = age_genre_list[i].getAttribute("id");
        //console.log(ranking_and_graph_id);
        let ranking_data = get_ranking_genre(ranking_and_graph_id);
        //特定の代のランキングのループ　例 30代のランキング　1.動画 2.音楽
        for(let j = 0; j < ranking_data[0].length; j++) {
            //console.log(ranking_data[0][j]);
            //age_data_list年代ごとのリストに　ジャンルの件数を入力する
            //ranking_data[0]はジャンルの名称がランキング順に格納されている
            switch(ranking_data[0][j]) {
                case genre_list[0]:
                    age_data_list[i][genre_list[0]] = ranking_data[1][j];
                    //console.log(age_data_list[i][genre_list[0]]);
                    break;
                case genre_list[1]:
                    age_data_list[i][genre_list[1]] = ranking_data[1][j];
                    break;
                case genre_list[2]:
                    age_data_list[i][genre_list[2]] = ranking_data[1][j];
                    break;
                case genre_list[3]:
                    age_data_list[i][genre_list[3]] = ranking_data[1][j];
                    break;
                case genre_list[4]:
                    age_data_list[i][genre_list[4]] = ranking_data[1][j];
                    break;
                case genre_list[5]:
                    age_data_list[i][genre_list[5]] = ranking_data[1][j];
                    break;
                case genre_list[6]:
                    age_data_list[i][genre_list[6]] = ranking_data[1][j];
                    break;
                case genre_list[7]:
                    age_data_list[i][genre_list[7]] = ranking_data[1][j];
                    break;
            }
        }
        //console.log(age_data_list[i]);
    }

    //age_data_listのキーの数を数える　年代の数 age_numでもいいけど　変え忘れるといけないので
    age_data_list_age_num = Object.keys(age_data_list).length;
    re_age_data = []
    for(let i = 0; i < genre_list.length; i++) {
        re_age_data.push([]);
    }
    //年代と年代ごとジャンルの2重ループ　iが年代　jが年代ごとジャンル
    for(let i = 0; i < age_data_list_age_num; i++) {
        for(let j = 0; j < genre_list.length; j++) {
            //age_data_listの該当する年代(age_data_list[i])のキーを指定(genre_list[j])してpushしてる
            re_age_data[j].push(age_data_list[i][genre_list[j]]);
        }
    }
    //ここのre_age_dataは　大枠　ジャンルごと　小枠　年代別になってる
    //re_age_data[動画, 音楽, カー] ジャンルの並びはgenre_listの順
    //動画[00代, 10代, 20代]
    //console.log(re_age_data);

    let color_palette = ["red", "blue", "green", "yellow", "purple", "orange", "pink", "gray", "white"]
    let re = [];
    for(let i = 0; i < genre_list.length; i++) {
        re.push({});
        re[i]["label"] = genre_list[i];
        re[i]["backgroundColor"] = color_palette[i];
        re[i]["data"] = re_age_data[i]
        //console.log(re[i]);
    }
    return re
}

//順位をリストにして返す　10以内　順位タイ有り
function get_ranking_number(ranking_id) {
    let document_rank = document.querySelector(ranking_id);
    let ol_rank = document_rank.querySelector(".ol_ranking");
    let rank_li_list = ol_rank.querySelectorAll("li");
    //juni_numは件数
    let juni_num = [];
    //juni_noはランキング　順位タイあり
    let juni_no = [];

    //ランキングの要素が10以下の場合はループする回数を要素数にする
    let for_num = 10;
    if(rank_li_list.length < for_num) {
        for_num = rank_li_list.length;
    }
    //juni_numに件数を入れる
    for(let i = 0; i < for_num; i++) {
        juni_num.push(parseInt(rank_li_list[i].querySelector(".subsc_reginum").textContent));
    }
    //juni_noをfor_numの分初期化する　iの初期値は1　例：[1,2,3,4,5,6,7,8]
    for(let i = 1; i < for_num + 1; i++) {
        juni_no.push(i);
    }
    // console.log(juni_num);
    // console.log(juni_no);

    for(let i = 1; i < for_num; i++) {
        if(juni_num[i] == juni_num[i-1]) {
            juni_no[i] = juni_no[i-1];
        }
    }
    
    return juni_no
}

//idと順位リストを受け取り順位にあったメモリを表示する
function add_ranking_number(ranking_id, juni_list) {
    let document_rank = document.querySelector(ranking_id);
    let ol_rank = document_rank.querySelector(".ol_ranking");
    let rank_li_list = ol_rank.querySelectorAll("li");

    loop_num  = 10;
    if(loop_num > rank_li_list.length) {
        loop_num = rank_li_list.length;
    }
    
    if(loop_num > 0) {
        for (let i = 0; i < loop_num; i ++) {
            let medal_class = ranking_id + " .ol_ranking li:nth-child(" + (i + 1) + ") .medal";
            let add_class_no = "no" + String(juni_list[i]);
            $(medal_class).addClass(add_class_no);
        }
    }
};