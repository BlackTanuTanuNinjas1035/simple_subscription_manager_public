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

let flag_chart01 = true;
//=========== 円グラフ ============//
$('#line_graph').on('inview', function(event, isInView) {//画面上に入ったらグラフを描画
if( flag_chart01 ) {
    flag_chart01 = false;
    if (isInView) {
    // var ctx=document.getElementById("chart01");//グラフを描画したい場所のid
    // var tmp = getSubsc();
    // var ls_name = tmp[0];
    // var ls_price = tmp[1];
    // console.log(ls_name);
    let history_data = get_history_data();
    var ctx=document.getElementById("line_graph");
    var chart=new Chart(ctx,{
    type:'line',//グラフのタイプ
    //type:'doughnut',
    data:{//グラフのデータ
        //labels:[1,2,3,4,5,6,7,8,9,10,11,12],//データの名前
        labels: history_data[0],
        datasets:[{
            // label:"職種別比率",//グラフのタイトル
            // backgroundColor:["#BB5179","#FAFF67", "#58A27C","#3C00FF"],//グラフの背景色
            // data:["960", "1000"]//データ
            // // data:ls_price
                label: "Prime and Fibonacci",
                fillColor: "rgba(220,220,220,0.2)",
                strokeColor: "rgba(220,220,220,1)",
                pointColor: "rgba(220,220,220,1)",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(220,220,220,1)",
                //data: [2, 3, 5, 7, 11, 13, 17, 19, 23, 29 , 20, 10]
                data: history_data[1]
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
            return data.labels[tooltipItem.index]+ ": "+ data.datasets[0].data[tooltipItem.index] + "%";//%を最後につける
        }
        },    
        },
        title:{//上部タイトル表示の設定
        display: false,
        fontSize:10,
        text: '単位：%'
        },
    }
    });
        
    }
}

});