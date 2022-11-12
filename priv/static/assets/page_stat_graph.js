//値をグラフに表示させる
Chart.plugins.register({
    afterDatasetsDraw: function (chart, easing) {
        var ctx = chart.ctx;

        chart.data.datasets.forEach(function (dataset, i) {
            var meta = chart.getDatasetMeta(i);
            if (!meta.hidden) {
                meta.data.forEach(function (element, index) {
                    // 値の表示
                    ctx.fillStyle = 'rgb(0, 0, 0,0.8)';//文字の色
                    var fontSize = 12;//フォントサイズ
                    var fontStyle = 'normal';//フォントスタイル
                    var fontFamily = 'Arial';//フォントファミリー
                    ctx.font = Chart.helpers.fontString(fontSize, fontStyle, fontFamily);

                    var dataString = dataset.data[index].toString();
        
                    // 値の位置
                    ctx.textAlign = 'center';//テキストを中央寄せ
                    ctx.textBaseline = 'middle';//テキストベースラインの位置を中央揃え

                    var padding = 5;//余白
                    var position = element.tooltipPosition();
                    ctx.fillText(dataString, position.x, position.y - (fontSize / 2) - padding);
    
                });
            }
        });
    }
});

function graphView(graph_id) {
        var ctx=document.getElementById(graph_id);//グラフを描画したい場所のid

        // var tmp = getSubsc();
        // var ls_name = tmp[0];
        // var ls_price = tmp[1];
        //console.log(ls_name);
        var chart=new Chart(ctx,{
            type:'pie',//グラフのタイプ
            //type:'doughnut',
            data:{//グラフのデータ
                labels:["Abemaプレミアム", "Youtubeプレミアム"],//データの名前
                //labels:ls_name,
                datasets:[{
                    label:"職種別比率",//グラフのタイトル
                    backgroundColor:["#BB5179","#FAFF67", "#58A27C","#3C00FF"],//グラフの背景色
                    data:["960", "1000"]//データ
                    //data:ls_price
                }]
            },

            options:{//グラフのオプション
                maintainAspectRatio: false,//CSSで大きさを調整するため、自動縮小をさせない
                legend:{
                    display:true//グラフの説明を表示
                },
                tooltips:{//グラフへカーソルを合わせた際の詳細表示の設定
                    callbacks:{
                        label: function (tooltipItem, data) {
                        return data.labels[tooltipItem.index]+ ": "+ data.datasets[0].data[tooltipItem.index] + "%";//%を最後につける
                        }
                    },    
                },
                title:{//上部タイトル表示の設定
                    display: true,
                    fontSize:10,
                    text: '単位：%'
                },
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

    //女性のサービスランキング
    let graph_female_service = true;
    //女性の年齢別のサービスランキング
    let flaglist_graph_female_age_service = [];
    for (let i = 0; i < age_number; i++) {
        flaglist_graph_female_age_service[i] = true;
    }

    $("#graph_overall_service").on("inview", function() {
        if (flag_graph_overall_service) {
            flag_graph_overall_service = false;
            let tmp = "graph_overall_service";
            let chart_graph_overall_service = graphView(tmp); //オブジェクトが返ってくる　個別にoptionなど変更したいとき
        };
    });
    $("#graph_male_service").on("inview", function() {
        if (flag_graph_male_service) {
            flag_graph_male_service = false;
            let tmp = "graph_male_service";
            let  chart_graph_male_service = graphView(tmp); //オブジェクトが返ってくる　個別にoptionなど変更したいとき
        };
    });
    //男性年齢別サービスのグラフのインスタンスを格納するリスト
    let chartlist_graph_male_age_service = [];
    let chart_id;
    let chart_id_sub; //#つけたchart_id
    for(let i = 0; i < age_number; i++) {
        chart_id = "graph_male_age_" + i + "0_service";
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
    let chartlist_graph_female_age_service = [];
    for(let i = 0; i < age_number; i++) {
        chart_id = "graph_female_age_" + i + "0_service";
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


});