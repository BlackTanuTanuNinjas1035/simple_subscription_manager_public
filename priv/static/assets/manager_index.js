
//たぶん登録されてるサブスクをhtmlのなかから取得してリストにして返す関数
function getSubsc() {
    let ls_n = document.getElementsByClassName("subsc_name");
    let ls_p = document.getElementsByClassName("subsc_price");

    let ls_name = [];
    let ls_price = [];

    let tmp;
    for ( let t = 0; t < ls_n.length; t++) {
        //console.log("hello");
        tmp = ls_n[t].textContent;
        ls_name.push(tmp.replace(/\s+/g, ''));  //空白と改行を取り除いてからpush
        tmp = ls_p[t].textContent;
        ls_price.push(tmp.replace(/\s+/g, ''));
        };
    //console.log(ls_name, ls_price);
    let return_array = [ls_name, ls_price];
    return return_array
}

$(function(){
    $(".subsc_option").on("click", function(){
        $(this).find(".subsc_option_menu").toggleClass("active");
        $(this).parents(".subsc_card").children(".subsc_change_payment").slideToggle(300);
    });
    $("#user_guid").on("click", function() {
        $("#user_guid_content").slideToggle(200);
    })
    
    let cards = document.querySelectorAll(".subsc_card");
    console.log(cards);
    for (let i = 0; i < cards.length; i++) {
        let card = cards[i];
        //console.log(card);
        let card_continue = card.querySelector(".subsc_continue");
        card_continue = card_continue.querySelector("div").textContent;
        console.log(card_continue);
        if(card_continue == "継続×") {
            console.log(card);
            card.classList.add("no_keizoku");
        }
    }
})
