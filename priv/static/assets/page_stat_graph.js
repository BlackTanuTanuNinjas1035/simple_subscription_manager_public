//棒グラフのツールチップを中心に表示するため
Chart.Tooltip.positioners.middle = elements => {
    let model = elements[0]._model;
    return {
    x: model.x,
    y: (model.base + model.y) / 2
    };
};

//ホバーした要素をグラフの中心に表示するためのやつ
var global_value = 0;
var chartJsPluginCenterLabel = {
    afterDatasetsDraw: function (chart) {

    // // ラベルの X 座標と Y 座標
    var canvas = chart.ctx.canvas;
    var labelX = canvas.clientWidth / 2;
    var labelY = Math.round((canvas.clientHeight + chart.chartArea.top) / 2);
    // // ラベルの値　つかえなかった
    var value = chart.data.datasets[0].data[0] + '%';
    // ラベル描画
    var ctx = this.setTextStyle(chart.ctx);
    ctx.fillText(global_value, labelX, labelY);
    },

    /**
     * 書式設定
     */
    setTextStyle: function (ctx) {
    var fontSize = 40;
    var fontStyle = 'normal';
    var fontFamily = '"Helvetica Neue", Helvetica, Arial, sans-serif';
    ctx.font = Chart.helpers.fontString(fontSize, fontStyle, fontFamily);
    ctx.fillStyle = '#636363';
    ctx.textAlign = 'center';
    ctx.textBaseline = 'middle';
    return ctx;
    }
};

var options = {//グラフのオプション
    cutoutPercentage: 50, //ドーナツグラフの何％をえぐるか
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
        //bodyFontSize: 15, //ツールチップのフォントサイズ
    },
    title:{//上部タイトル表示の設定
        display: false,
        fontSize:10,
        text: '単位：%'
    },

     //このpluginsはパーセンテージ表示の外部のやつ
    plugins: {
        datalabels: {
            formatter: (value, ctx) => {
                let sum = 0;
                let data_length = ctx.chart.data.datasets[0].data.length;
                let data_set_index = ctx.datasetIndex;
                let data_index = ctx.dataIndex;
                for(let i = 0; i < data_length; i++){
                    sum += ctx.chart.data.datasets[0].data[i]
                }
                // console.log(ctx.dataset.label);

                // let return_num = (value*100 / sum).toFixed(2)+"%";
                //パーセントが小さすぎたら数字を表示させない
                let percentage = (value*100 / sum);
                let return_num;
                if ( percentage > 1) {
                    return_num = percentage.toFixed(1)+"%";
                }else {
                    return_num = null;
                }
                return return_num
            },
            color: '#040404',
            anchor: 'center',
            font: {
                size: 20
            },
            labels: {
                title: {
                    font: {
                        weight: 'bold'
                    }
                }
            }
        },
        colorschemes: {
            scheme: 'brewer.Paired12'
        }
    }
};
//ミニグラフ用　フォントサイズを変えたかったから
var options_mini = {//グラフのオプション
    cutoutPercentage: 50, //ドーナツグラフの何％をえぐるか
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
        //bodyFontSize: 15, //ツールチップのフォントサイズ
    },
    title:{//上部タイトル表示の設定
        display: false,
        fontSize:10,
        text: '単位：%'
    },

     //このpluginsはパーセンテージ表示の外部のやつ
    plugins: {
        datalabels: {
            formatter: (value, ctx) => {
                let sum = 0;
                let data_length = ctx.chart.data.datasets[0].data.length;
                let data_set_index = ctx.datasetIndex;
                let data_index = ctx.dataIndex;
                for(let i = 0; i < data_length; i++){
                    sum += ctx.chart.data.datasets[0].data[i]
                }
                // console.log(ctx.dataset.label);

                // let return_num = (value*100 / sum).toFixed(2)+"%";
                //パーセントが小さすぎたら数字を表示させない
                let percentage = (value*100 / sum);
                let return_num;
                if ( percentage > 1) {
                    return_num = percentage.toFixed(1)+"%";
                }else {
                    return_num = null;
                }
                return return_num
            },
            color: '#040404',
            anchor: 'center',
            font: {
                size: 15
            },
            labels: {
                title: {
                    font: {
                        weight: 'bold'
                    }
                }
            }
        },
        colorschemes: {
            scheme: 'brewer.Paired12'
        }
    }
};

var prevHoveredIndexes = [];
options.events = ['mousemove', 'mouseout', 'click', 'touchstart', 'touchmove', 'hover'];
options.onHover = (event, hoveredItems) => {
    //データの操作場所とか
    //console.log(data.datasets[0].data[14]);
    //console.log(hoveredItems);

    var graph_index = hoveredItems.map(x => x._index);
    var hoge = hoveredItems.map(x => x._datasetIndex);
    try {
        global_value = hoveredItems[0]._chart.config.data.labels[graph_index];
        console.log(global_value);

    } catch (error) {
        console.log("グラフ外ホバー")
    }
    
    // if(data.labels[piyo[0]] == null) {
    //     console.log("powo");
    // } else {
    //     global_value = data.labels[piyo[0]];
    // }
}

//ranking_and_graphのところのidを引数で渡す　それと取得するランキングの数を引数で渡す　10を入れると　1~10位　11位以下はその他になる
function graphView(ranking_and_graph_id) {
    let a = document.querySelector("#" + ranking_and_graph_id);
    // 取得するランキングの数を引数で渡す　10を入れると　1~10位　11位以下はその他になる
    let rank_num = 10;
    let ranking_data = get_ranking(ranking_and_graph_id, rank_num)
    //console.log(ranking_data);
    var ctx = a.querySelector(".graph"); //グラフを描画したい場所のid

    var chart=new Chart(ctx,{
        type:'doughnut',//グラフのタイプ
        data:{//グラフのデータ
            //labels:["Abemaプレミアム", "Youtubeプレミアム"],//データの名前
            labels:ranking_data[0],
            datasets:[{
                label:"サービス割合",//グラフのタイトル
                //backgroundColor:["#BB5179","#FAFF67", "#58A27C","#3C00FF"],//グラフの背景色
                //data:["960", "1000"]//データ
                data:ranking_data[1]
            }]
        },

        options: options,
    });
    return chart
}
//ミニグラフ用　オプションのフォントサイズを変える方法が新しく作るしか思いつかなかった
function graphView_mini(ranking_and_graph_id) {
    let a = document.querySelector("#" + ranking_and_graph_id);
    // 取得するランキングの数を引数で渡す　10を入れると　1~10位　11位以下はその他になる
    let rank_num = 3;
    let ranking_data = get_ranking(ranking_and_graph_id, rank_num)
    //console.log(ranking_data);
    var ctx = a.querySelector(".graph"); //グラフを描画したい場所のid

    var chart=new Chart(ctx,{
        type:'doughnut',//グラフのタイプ
        data:{//グラフのデータ
            //labels:["Abemaプレミアム", "Youtubeプレミアム"],//データの名前
            labels:ranking_data[0],
            datasets:[{
                label:"ミニサービス割合",//グラフのタイトル
                //backgroundColor:["#BB5179","#FAFF67", "#58A27C","#3C00FF"],//グラフの背景色
                //data:["960", "1000"]//データ
                data:ranking_data[1]
            }]
        },

        options: options_mini,
    });
    return chart
}
//ジャンル用のグラフ描画関数　liのspanのclassが違うから取ってくる関数が違うだけなはず
function graphView_genre(ranking_and_graph_id) {
    let a = document.querySelector("#" + ranking_and_graph_id);
    let ranking_data = get_ranking_genre(ranking_and_graph_id);
    //console.log(ranking_data);
    var ctx = a.querySelector(".graph"); //グラフを描画したい場所のid

    var chart=new Chart(ctx,{
        type:'doughnut',//グラフのタイプ
        //type:'doughnut',
        data:{
            //グラフのデータ
            labels:ranking_data[0],
            datasets:[{
                label:"職種別比率",//グラフのタイトル
                //backgroundColor:["#BB5179","#FAFF67", "#58A27C","#3C00FF"],//グラフの背景色
                //data:["960", "1000"]//データ
                data:ranking_data[1]
            }]
        },
        options: options
    });
    return chart
}

//ジャンルの棒グラフ
function graphView_age_genre(age_genre_id) {
    let a = document.querySelector("#" + age_genre_id);
    let datasets_data = get_age_ranking_genre("#" + age_genre_id);
    var ctx = a.querySelector(".bar_graph"); //グラフを描画したい場所のid

    var chart=new Chart(ctx,{
        type:'bar',//グラフのタイプ
        data:{//グラフのデータ
            labels:["00代", "10代", "20代", "30代", "40代", "50代", "60代", "70代"],//データの名前
            datasets: datasets_data,
        },
        options:{
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
                position: 'middle',  // must match the positioner function name defined above
                yAlign: null,        // to get rid of the pointer
                xAlign: 'center'
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
                datalabels: {
                    formatter: (value, ctx) => {
                        let sum = 0;
                        let datasets_length = ctx.chart.data.datasets.length;
                        let data_set_index = ctx.datasetIndex;
                        let data_index = ctx.dataIndex;
                        for(let i = 0; i < datasets_length; i++){
                            sum += ctx.chart.data.datasets[i].data[data_index]
                        }
                        //console.log(sum);
                        // console.log(ctx.dataset.label);

                        // let return_num = (value*100 / sum).toFixed(2)+"%";
                        //パーセントが小さすぎたら数字を表示させない
                        let percentage = (value*100 / sum);
                        let return_num;
                        if ( percentage > 1) {
                            return_num = percentage.toFixed(1)+"%";
                        }else {
                            return_num = null;
                        }
                        return return_num
                    },
                    color: '#040404',
                    anchor: 'center',
                    font: {
                        size: 20
                    },
                    labels: {
                        title: {
                            font: {
                                weight: 'bold'
                            }
                        }
                    }
                },
                colorschemes: {
                    scheme: 'brewer.Paired12'
                }
            }
        }
        
    });
    return chart

};


$(function() {
    //ageだけlistとforを使って記述したい
    //すべてのサービスランキングフラグ↓
    let flag_graph_overall_service = true;
    //年代別　人気サービスランキングフラグ
    let flaglist_graph_overall_age_service = []; //listの添字と年代が対応している
    let age_number = 8 //年齢別の区分の数　forで使う
    for (let i = 0; i < age_number; i++) {
        flaglist_graph_overall_age_service[i] = true;
    }
    //男性のサービスランキングフラグ
    let flag_graph_male_service = true;
    //男性の年齢別サービスランキングフラグ
    let flaglist_graph_male_age_service = []; //listの添字と年代が対応している
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

    let chart_graph_overall_service;
    //すべてのサービスランキングのグラフ描画処理
    $("#graph_overall_service").on("inview", function() {
        if (flag_graph_overall_service) {
            flag_graph_overall_service = false;
            let tmp = "overall_service";
            chart_graph_overall_service = graphView(tmp); //オブジェクトが返ってくる　個別にoptionなど変更したいとき
            //console.log(chart_graph_overall_service);
        };
    });
    

    //年代別　人気のサービスランキング
    let chartlist_graph_overall_age_service = [];
    let chart_id;
    let chart_id_sub; //#つけたchart_id
    for(let i = 0; i < age_number; i++) {
        chart_id = "overall_age_" + i + "0_service";
        chart_id_sub = "#" + chart_id;
        //即時関数　(function(渡す変数)){}(受け取る変数名)
        (function(i, chart_id, chart_id_sub, flaglist_graph_overall_age_service, chartlist_graph_overall_age_service){
            $(chart_id_sub).on("inview", function() {
                if(flaglist_graph_overall_age_service[i]) {
                    flaglist_graph_overall_age_service[i] = false;
                    chartlist_graph_overall_age_service[i] = graphView_mini(chart_id);
                }
            })
        })(i, chart_id, chart_id_sub, flaglist_graph_overall_age_service, chartlist_graph_overall_age_service);
    }


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
    for(let i = 0; i < age_number; i++) {
        chart_id = "male_age_" + i + "0_service";
        chart_id_sub = "#" + chart_id;
        //即時関数　(function(渡す変数)){}(受け取る変数名)
        (function(i, chart_id, chart_id_sub, flaglist_graph_male_age_service, chartlist_graph_male_age_service){
            $(chart_id_sub).on("inview", function() {
                if(flaglist_graph_male_age_service[i]) {
                    flaglist_graph_male_age_service[i] = false;
                    chartlist_graph_male_age_service[i] = graphView_mini(chart_id);
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
                    chartlist_graph_female_age_service[i] = graphView_mini(chart_id);
                }
            })
        })(i, chart_id, chart_id_sub, flaglist_graph_female_age_service, chartlist_graph_female_age_service);
    }

    //ジャンルコーナー

    //すべてのジャンルランキングフラグ↓
    let flag_graph_overall_genre = true;
    //男性のジャンルランキングフラグ
    let flag_graph_male_genre = true;

    //女性のジャンルランキングフラグ
    let flag_graph_female_genre = true;

    $("#graph_overall_genre").on("inview", function() {
        if (flag_graph_overall_genre) {
            flag_graph_overall_genre = false;
            let tmp = "overall_genre";
            let  chart_graph_male_genre = graphView_genre(tmp); //オブジェクトが返ってくる　個別にoptionなど変更したいとき
        };
    });

    //年代別　人気ジャンルランキング

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
    let flag_bar_graph_overall_genre = true;
    let flag_bar_graph_age_male_genre = true;
    let flag_bar_graph_age_female_genre = true;

    $("#bar_graph_overall_genre").on("inview", function() {
        if(flag_bar_graph_overall_genre) {
            flag_bar_graph_overall_genre = false;
            let tmp = "overall_age_genre";
            let chart_bar_graph_overall_genre = graphView_age_genre(tmp);
        }
        
    });

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

    //Chart.plugins.register(chartJsPluginCenterLabel);


    //ランキングにメダルをつける作業
    let juni_id = ["#overall_service", "#male_overall_service", "#female_overall_service", "#overall_genre", "#male_overall_genre", "#female_overall_genre"]
    for(let i = 0; i < juni_id.length; i++) {
        let juni_list = get_ranking_number(juni_id[i]);
    add_ranking_number(juni_id[i], juni_list);
    }
    
    let final_time = performance.now();
    // console.log("ファイナル" + (final_time - start_time) / 1000 + "秒");
});