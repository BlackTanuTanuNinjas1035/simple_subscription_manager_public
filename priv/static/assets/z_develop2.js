console.log("hello");
$(window).on('load', function() {
    let end2_time = performance.now();
    console.log("z_develop2 end", (end2_time - start_time) / 1000 + "秒");
});