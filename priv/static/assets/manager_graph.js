
var options = {//グラフのオプション
  //cutoutPercentage: 50, //ドーナツグラフの何％をえぐるか
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
        bodyFontSize: 15, //ツールチップのフォントサイズ
    },
    title:{//上部タイトル表示の設定
        display: true,
        fontSize:30,
        fontColor: "#040404",
        fontStyle: "bold",
        text: '登録しているサブスクの割合'
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
                    sum += parseInt(ctx.chart.data.datasets[0].data[i])
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
        }
    }
};


//=========== 円グラフ ============//
// $('#chart01').on('inview', function(event, isInView) {//画面上に入ったらグラフを描画
//   if( flag_chart01 ) {
//     flag_chart01 = false;
//     if (isInView) {
//       var ctx=document.getElementById("chart01");//グラフを描画したい場所のid
//       var tmp = getSubsc();
//       var ls_name = tmp[0];
//       var ls_price = tmp[1];
//       console.log(ls_name);
      
//       var chart=new Chart(ctx,{
//       type:'pie',//グラフのタイプ
//       //type:'doughnut',
//       data:{//グラフのデータ
//         // labels:["Abemaプレミアム", "Youtubeプレミアム"],//データの名前
//         labels:ls_name,
//         datasets:[{
//             label:"サブスクの割合",//グラフのタイトル
//             backgroundColor:["#BB5179","#FAFF67", "#58A27C","#3C00FF"],//グラフの背景色
//             // data:["960", "1000"]//データ
//             data:ls_price
//           }]
//       },
//       options: options
//       // options:{//グラフのオプション
//       //   maintainAspectRatio: false,//CSSで大きさを調整するため、自動縮小をさせない
//       //   legend:{
//       //     display:false//グラフの説明を表示
//       //   },
//       //   tooltips:{//グラフへカーソルを合わせた際の詳細表示の設定
//       //     callbacks:{
//       //         label: function (tooltipItem, data) {
//       //       return data.labels[tooltipItem.index]+ ": "+ data.datasets[0].data[tooltipItem.index] + "%";//%を最後につける
//       //     }
//       //     },    
//       //   },
//       //   title:{//上部タイトル表示の設定
//       //     display: false,
//       //     fontSize:10,
//       //     text: '単位：%'
//       //   },
//       // }
//       });
        
//       }
//   }

// });




$(function() {
  let flag_chart01 = true;
  $('#chart01').on('inview', function() {//画面上に入ったらグラフを描画
  if( flag_chart01 ) {
    flag_chart01 = false;

      var ctx=document.getElementById("chart01");//グラフを描画したい場所のid
      var tmp = getSubsc();
      var ls_name = tmp[0];
      var ls_price = tmp[1];
      console.log(ls_name);
      
      var chart=new Chart(ctx,{
      type:'pie',//グラフのタイプ
      data:{//グラフのデータ
        labels:ls_name,
        datasets:[{
            label:"サブスクの割合",//グラフのタイトル
            backgroundColor:["#BB5179","#FAFF67", "#58A27C","#3C00FF"],//グラフの背景色
            // data:["960", "1000"]//データ
            data:ls_price
          }]
      },
      options: options
      // options:{//グラフのオプション
      //   maintainAspectRatio: false,//CSSで大きさを調整するため、自動縮小をさせない
      //   legend:{
      //     display:false//グラフの説明を表示
      //   },
      //   tooltips:{//グラフへカーソルを合わせた際の詳細表示の設定
      //     callbacks:{
      //         label: function (tooltipItem, data) {
      //       return data.labels[tooltipItem.index]+ ": "+ data.datasets[0].data[tooltipItem.index] + "%";//%を最後につける
      //     }
      //     },    
      //   },
      //   title:{//上部タイトル表示の設定
      //     display: false,
      //     fontSize:10,
      //     text: '単位：%'
      //   },
      // }
      });
        
  }

});
})







// $(function() {
//   $("#chart01").on("inview", function() {
//     if (flag_chart01) {
//         flag_chart01 = false;
//         let tmp = "overall_service";
//         chart_graph_overall_service = graphView(tmp); //オブジェクトが返ってくる　個別にoptionなど変更したいとき
//         //console.log(chart_graph_overall_service);
//     };
// });
// })

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
              label:"職種別比率",//グラフのタイトル
              backgroundColor:["#BB5179","#FAFF67", "#58A27C","#3C00FF"],//グラフの背景色
              //data:["960", "1000"]//データ
              data:ranking_data[1]
          }]
      },

      options: options,
  });
  return chart
}