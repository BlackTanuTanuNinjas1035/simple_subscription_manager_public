$(function() {
    let scroll_parent = document.querySelector("#history_flame_in");
    $("#arrow_left").on('click', function() {
        let scroll_width = 0 - document.querySelector("#before_1").clientWidth;
        scroll_parent.scrollBy( scroll_width, 0);
    });
    $("#arrow_right").on('click', function() {
        let scroll_width = document.querySelector("#before_1").clientWidth;
        scroll_parent.scrollBy( scroll_width, 0);
    });
});

function get_history_data() {
    let data_list = document.querySelectorAll(".data");
    
    //monthは文字列のリスト
    let month_list = []
    let sum_list = [];

    for(let i = 0; i < data_list.length; i++) {
        let data = data_list[i];
        let month = data.querySelector(".span_month").textContent + "月";
        month_list.push(month);
        let card_list = data.querySelectorAll(".data_card");
        let price_sum = 0;
        for(let j = 0; j < card_list.length; j++) {
            price_sum += parseInt(card_list[j].querySelector(".price").textContent);
        }
        sum_list.push(price_sum);
    }
    console.log(month_list);
    console.log(sum_list);
    
    let return_list = [];
    return_list.push(month_list.reverse())
    return_list.push(sum_list.reverse())
    console.log(return_list)
    
    return return_list;
}