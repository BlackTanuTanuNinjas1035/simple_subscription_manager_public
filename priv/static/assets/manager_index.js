// $(function () {
//     let ls_n = document.getElementsByClassName("subsc_name");
//     let ls_p = document.getElementsByClassName("subsc_price");

//     let ls_name = [];
//     let ls_price = [];

//     let tmp;
//     for ( let t = 0; t < ls_n.length; t++) {
//         console.log("hello");
//         tmp = ls_n[t].textContent;
//         ls_name.push(tmp.replace(/\s+/g, ''));  //空白と改行を取り除いてからpush
//         tmp = ls_p[t].textContent;
//         ls_price.push(tmp.replace(/\s+/g, ''));
//         };
//     console.log(ls_name, ls_price);
// })

function getSubsc() {
    let ls_n = document.getElementsByClassName("subsc_name");
    let ls_p = document.getElementsByClassName("subsc_price");

    let ls_name = [];
    let ls_price = [];

    let tmp;
    for ( let t = 0; t < ls_n.length; t++) {
        console.log("hello");
        tmp = ls_n[t].textContent;
        ls_name.push(tmp.replace(/\s+/g, ''));  //空白と改行を取り除いてからpush
        tmp = ls_p[t].textContent;
        ls_price.push(tmp.replace(/\s+/g, ''));
        };
    //console.log(ls_name, ls_price);
    let return_array = [ls_name, ls_price];
    return return_array
}