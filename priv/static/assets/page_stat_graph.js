//値をグラフに表示させる
// Chart.plugins.register({
//     afterDatasetsDraw: function (chart, easing) {
//         var ctx = chart.ctx;

//         chart.data.datasets.forEach(function (dataset, i) {
//             var meta = chart.getDatasetMeta(i);
//             if (!meta.hidden) {
//                 meta.data.forEach(function (element, index) {
//                     // 値の表示
//                     ctx.fillStyle = 'rgb(0, 0, 0,0.8)';//文字の色
//                     var fontSize = 12;//フォントサイズ
//                     var fontStyle = 'normal';//フォントスタイル
//                     var fontFamily = 'Arial';//フォントファミリー
//                     ctx.font = Chart.helpers.fontString(fontSize, fontStyle, fontFamily);

//                     //var dataString = dataset.data[index].toString();
//                     //var dataString = chart.data.labels[index];
        
//                     // 値の位置
//                     ctx.textAlign = 'center';//テキストを中央寄せ
//                     ctx.textBaseline = 'middle';//テキストベースラインの位置を中央揃え

//                     var padding = 5;//余白
//                     var position = element.tooltipPosition();
//                     ctx.fillText(dataString, position.x, position.y - (fontSize / 2) - padding);
    
//                 });
//             }
//         });
        
//     }
// });

// function graphView(graph_id) {
//         var ctx=document.getElementById(graph_id);//グラフを描画したい場所のid

//         // var tmp = getSubsc();
//         // var ls_name = tmp[0];
//         // var ls_price = tmp[1];
//         //console.log(ls_name);
//         var chart=new Chart(ctx,{
//             type:'pie',//グラフのタイプ
//             //type:'doughnut',
//             data:{//グラフのデータ
//                 labels:["Abemaプレミアム", "Youtubeプレミアム"],//データの名前
//                 //labels:ls_name,
//                 datasets:[{
//                     label:"職種別比率",//グラフのタイトル
//                     backgroundColor:["#BB5179","#FAFF67", "#58A27C","#3C00FF"],//グラフの背景色
//                     data:["960", "1000"]//データ
//                     //data:ls_price
//                 }]
//             },

//             options:{//グラフのオプション
//                 maintainAspectRatio: false,//CSSで大きさを調整するため、自動縮小をさせない
//                 legend:{
//                     display:true//グラフの説明を表示
//                 },
//                 tooltips:{//グラフへカーソルを合わせた際の詳細表示の設定
//                     callbacks:{
//                         label: function (tooltipItem, data) {
//                         return data.labels[tooltipItem.index]+ ": "+ data.datasets[0].data[tooltipItem.index] + "%";//%を最後につける
//                         }
//                     },    
//                 },
//                 title:{//上部タイトル表示の設定
//                     display: true,
//                     fontSize:10,
//                     text: '単位：%'
//                 },
//             }
            
            
//         });
//         return chart
// }

//ranking_and_graphのところのidを引数で渡す
function graphView(ranking_and_graph_id) {
    let a = document.querySelector("#" + ranking_and_graph_id);
    //let b = a.querySelector(".ol_ranking");
    //let ranking_data = get_ranking(b);
    let ranking_data = get_ranking(ranking_and_graph_id)
    //console.log(ranking_data);
    var ctx = a.querySelector(".graph"); //グラフを描画したい場所のid

    var chart=new Chart(ctx,{
        type:'doughnut',//グラフのタイプ
        //type:'doughnut',
        data:{//グラフのデータ
            //labels:["Abemaプレミアム", "Youtubeプレミアム"],//データの名前
            labels:ranking_data[0],
            datasets:[{
                label:"職種別比率",//グラフのタイトル
                backgroundColor:["#BB5179","#FAFF67", "#58A27C","#3C00FF"],//グラフの背景色
                //data:["960", "1000"]//データ
                data:ranking_data[1]
            }]
        },

        options:{//グラフのオプション
            maintainAspectRatio: false,//CSSで大きさを調整するため、自動縮小をさせない
            legend:{
                display:false//グラフの説明を表示
            },
            tooltips:{//グラフへカーソルを合わせた際の詳細表示の設定
                callbacks:{
                    label: function (tooltipItem, data) {
                    //return data.labels[tooltipItem.index]+ ": "+ data.datasets[0].data[tooltipItem.index] + "%";//%を最後につける
                    return data.labels[tooltipItem.index]
                    }
                },    
            },
            title:{//上部タイトル表示の設定
                display: false,
                fontSize:10,
                text: '単位：%'
            },

             //このpluginsはパーセンテージ表示の外部のやつ
            plugins: {
                labels: {
                render: 'percentage',
                fontColor: 'black',
                fontSize: 20
                }
            }
        }
        
    });
    return chart
}
//ジャンル用のグラフ描画関数　liのspanのclassが違うから取ってくる関数が違うだけなはず
function graphView_genre(ranking_and_graph_id) {
    let a = document.querySelector("#" + ranking_and_graph_id);
    //let b = a.querySelector(".ol_ranking");
    //let ranking_data = get_ranking_genre(b);
    let ranking_data = get_ranking_genre(ranking_and_graph_id);
    //console.log(ranking_data);
    var ctx = a.querySelector(".graph"); //グラフを描画したい場所のid

    var chart=new Chart(ctx,{
        type:'doughnut',//グラフのタイプ
        //type:'doughnut',
        data:{//グラフのデータ
            //labels:["Abemaプレミアム", "Youtubeプレミアム"],//データの名前
            labels:ranking_data[0],
            datasets:[{
                label:"職種別比率",//グラフのタイトル
                backgroundColor:["#BB5179","#FAFF67", "#58A27C","#3C00FF"],//グラフの背景色
                //data:["960", "1000"]//データ
                data:ranking_data[1]
            }]
        },

        options:{//グラフのオプション
            maintainAspectRatio: false,//CSSで大きさを調整するため、自動縮小をさせない
            legend:{
                display:false//グラフの説明を表示
            },
            tooltips:{//グラフへカーソルを合わせた際の詳細表示の設定
                callbacks:{
                    label: function (tooltipItem, data) {
                    //return data.labels[tooltipItem.index]+ ": "+ data.datasets[0].data[tooltipItem.index] + "%";//%を最後につける
                    return data.labels[tooltipItem.index]
                    }
                },    
            },
            title:{//上部タイトル表示の設定
                display: false,
                fontSize:10,
                text: '単位：%'
            },

             //このpluginsはパーセンテージ表示の外部のやつ
            plugins: {
                labels: {
                render: 'percentage',
                fontColor: 'black',
                fontSize: 20
                }
            }
        }
        
    });
    return chart
}

function graphView_age_genre(age_genre_id) {
    let a = document.querySelector("#" + age_genre_id);
    let datasets_data = get_age_ranking_genre("#" + age_genre_id);
    console.log(datasets_data);
    var ctx = a.querySelector(".bar_graph"); //グラフを描画したい場所のid

    var chart=new Chart(ctx,{
        type:'bar',//グラフのタイプ
        //type:'doughnut',
        data:{//グラフのデータ
            labels:["00代", "10代", "20代", "30代", "40代", "50代", "60代", "70代"],//データの名前
            //labels:ranking_data[0],
            // datasets: [
            //     {
            //         label:"動画配信のサービス",//グラフのタイトル
            //         //backgroundColor:["#BB5179","#FAFF67", "#58A27C","#3C00FF"],//グラフの背景色
            //         backgroundColor: "red",
            //         data:[100, 10, 100]//データ
            //         //data:ranking_data[1]
            //     },
            //     {
            //         label:"音楽配信のサービス",//グラフのタイトル
            //         //backgroundColor:["#3C00FF","#58A27C", "#FAFF67","BB5179"],//グラフの背景色
            //         backgroundColor: "blue",
            //         data:[200, 200, 20]//データ
            //     }
            // ]
            datasets: datasets_data
        },

        options:{//グラフのオプション
            maintainAspectRatio: false,//CSSで大きさを調整するため、自動縮小をさせない
            legend:{
                display:false//グラフの説明を表示
            },
            tooltips:{//グラフへカーソルを合わせた際の詳細表示の設定
                callbacks:{
                    label: function (tooltipItem, data) {
                    //return data.labels[tooltipItem.index]+ ": "+ data.datasets[0].data[tooltipItem.index] + "%";//%を最後につける
                    return data.datasets[tooltipItem.datasetIndex].label
                    }
                },    
            },
            scales: {
                xAxes: [
                    {
                        stacked: true  // 積み上げの指定
                    }
                ],
                yAxes: [
                    {
                        stacked: true  //  積み上げの指定
                    }
                ]
            },
            title:{//上部タイトル表示の設定
                display: false,
                fontSize:10,
                text: '単位：%'
            },

            //このpluginsはパーセンテージ表示の外部のやつ
            plugins: {
                labels: {
                render: 'percentage',
                fontColor: 'black',
                fontSize: 20,
                position: "default"
                }
            }
        }
        
    });
    return chart

}

//確認用
function hello(){
    console.log("hello");
}

$(function() {
    //ageだけlistとforを使って記述したい
    //すべてのサービスランキングフラグ↓
    let flag_graph_overall_service = true;
    //男性のサービスランキングフラグ
    let flag_graph_male_service = true;
    //男性の年齢別サービスランキングフラグ
    let flaglist_graph_male_age_service = []; //listの添字と年代が対応している
    let age_number = 8 //年齢別の区分の数　forで使う
    for (let i = 0; i < age_number; i++) {
        flaglist_graph_male_age_service[i] = true;
    }

    //女性のサービスランキングフラグ
    let flag_graph_female_service = true;
    //女性の年齢別のサービスランキングフラグ
    let flaglist_graph_female_age_service = [];
    for (let i = 0; i < age_number; i++) {
        flaglist_graph_female_age_service[i] = true;
    }

    //すべてのサービスランキングのグラフ描画処理
    $("#graph_overall_service").on("inview", function() {
        if (flag_graph_overall_service) {
            flag_graph_overall_service = false;
            let tmp = "overall_service";
            let chart_graph_overall_service = graphView(tmp); //オブジェクトが返ってくる　個別にoptionなど変更したいとき
        };
    });
    //すべての男性のサービスグラフランキングの描画処理
    $("#graph_male_overall_service").on("inview", function() {
        if (flag_graph_male_service) {
            flag_graph_male_service = false;
            let tmp = "male_overall_service";
            let  chart_graph_male_service = graphView(tmp); //オブジェクトが返ってくる　個別にoptionなど変更したいとき
        };
    });
    //男性年齢別サービスのグラフのインスタンスを格納するリスト
    let chartlist_graph_male_age_service = [];
    let chart_id;
    let chart_id_sub; //#つけたchart_id
    for(let i = 0; i < age_number; i++) {
        chart_id = "male_age_" + i + "0_service";
        chart_id_sub = "#" + chart_id;
        //即時関数　(function(渡す変数)){}(受け取る変数名)
        (function(i, chart_id, chart_id_sub, flaglist_graph_male_age_service, chartlist_graph_male_age_service){
            $(chart_id_sub).on("inview", function() {
                if(flaglist_graph_male_age_service[i]) {
                    flaglist_graph_male_age_service[i] = false;
                    chartlist_graph_male_age_service[i] = graphView(chart_id);
                }
            })
        })(i, chart_id, chart_id_sub, flaglist_graph_male_age_service, chartlist_graph_male_age_service);
    }
    //女性
    $("#graph_female_service").on("inview", function() {
        if (flag_graph_female_service) {
            flag_graph_female_service = false;
            let tmp = "female_overall_service";
            let  chart_graph_male_service = graphView(tmp); //オブジェクトが返ってくる　個別にoptionなど変更したいとき
        };
    });
    //女性年齢別
    let chartlist_graph_female_age_service = [];
    for(let i = 0; i < age_number; i++) {
        chart_id = "female_age_" + i + "0_service";
        chart_id_sub = "#" + chart_id;
        (function(i, chart_id, chart_id_sub, flaglist_graph_female_age_service, chartlist_graph_female_age_service){
            $(chart_id_sub).on("inview", function() {
                if(flaglist_graph_female_age_service[i]) {
                    flaglist_graph_female_age_service[i] = false;
                    chartlist_graph_female_age_service[i] = graphView(chart_id);
                }
            })
        })(i, chart_id, chart_id_sub, flaglist_graph_female_age_service, chartlist_graph_female_age_service);
    }

    //ジャンルコーナー

    //すべてのジャンルランキングフラグ↓
    let flag_graph_overall_genre = true;
    //男性のジャンルランキングフラグ
    let flag_graph_male_genre = true;
    //男性の年齢別のジャンルランキングフラグ
    let flag_graph_male_age_genre = true;

    //女性のジャンルランキングフラグ
    let flag_graph_female_genre = true;
    //女性の年齢別のジャンルランキングフラグ
    let flag_graph_female_age_genre = true;

    $("#graph_overall_genre").on("inview", function() {
        if (flag_graph_overall_genre) {
            flag_graph_overall_genre = false;
            let tmp = "overall_genre";
            let  chart_graph_male_genre = graphView_genre(tmp); //オブジェクトが返ってくる　個別にoptionなど変更したいとき
        };
    });
    $("#graph_male_overall_genre").on("inview", function() {
        if (flag_graph_male_genre) {
            flag_graph_male_genre = false;
            let tmp = "male_overall_genre";
            let  chart_graph_male_genre = graphView_genre(tmp); //オブジェクトが返ってくる　個別にoptionなど変更したいとき
        };
    });


    $("#graph_female_overall_genre").on("inview", function() {
        if (flag_graph_female_genre) {
            flag_graph_female_genre = false;
            let tmp = "female_overall_genre";
            let  chart_graph_male_genre = graphView_genre(tmp); //オブジェクトが返ってくる　個別にoptionなど変更したいとき
        };
    });

    //棒グラフ
    let flag_bar_graph_age_male_genre = true;
    let flag_bar_graph_age_female_genre = true;




    $("#bar_graph_male_genre").on("inview", function() {
        if(flag_bar_graph_age_male_genre) {
            flag_bar_graph_age_male_genre = false;
            let tmp = "male_age_genre";
            let chart_bar_graph_age_male_genre = graphView_age_genre(tmp);
        }
        
    });
    $("#bar_graph_female_genre").on("inview", function() {
        if(flag_bar_graph_age_female_genre) {
            flag_bar_graph_age_female_genre = false;
            let tmp = "female_age_genre";
            let chart_bar_graph_age_female_genre = graphView_age_genre(tmp);
        }
        
    });

});