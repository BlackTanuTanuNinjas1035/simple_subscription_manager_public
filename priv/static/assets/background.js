$(function() {
    // let second = 0;
    let shot_bool = true;
    let random_num = 9;

    let big_interval_id = setInterval(function(){
        random_num = parseInt(Math.random() * 10);
        console.log(random_num);
        //あたりを引いてかつ前のあたりから20秒たっていたら発射する　アニメーションが一回20秒のため
        if(random_num == 0 && shot_bool) {
            shot_bool = false;
            console.log("発射");
            let li_tanutanu = document.createElement("li");
            li_tanutanu.classList.add('tanutanu');
            document.querySelector("#circles_ul").appendChild(li_tanutanu);
            // document.querySelector("#tanutanu").classList.add("shot");
            setTimeout(function() {
                shot_bool = true;
                document.querySelector(".tanutanu").remove();
                // document.querySelector("#tanutanu").classList.remove("shot");
            }, 20000)
        }
    }, 1000);
});
