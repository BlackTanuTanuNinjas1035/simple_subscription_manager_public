$(function() {
    // let second = 0;
    let shot_bool = true;
    let random_num = 9;

    let big_interval_id = setInterval(function(){
        random_num = parseInt(Math.random() * 10);
        //console.log(random_num);
        //あたりを引いてかつ前のあたりから30秒たっていたら発射する　アニメーションが一回20秒のため
        if(random_num == 0 && shot_bool) {
            shot_bool = false;
            //console.log("発射");
            //位置用
            let postion_num = Math.floor(Math.random() * (4 + 1 - 1)) + 1
            let postion_class = "p" + postion_num;
            //liを追加
            let li_tanutanu = document.createElement("li");
            li_tanutanu.classList.add('tanutanu');
            li_tanutanu.classList.add(postion_class);
            document.querySelector("#circles_ul").appendChild(li_tanutanu);
            // document.querySelector("#tanutanu").classList.add("shot");
            setTimeout(function() {
                shot_bool = true;
                document.querySelector(".tanutanu").remove();
                // document.querySelector("#tanutanu").classList.remove("shot");
            }, 30000)
        }
    }, 1000);
});
