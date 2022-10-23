
$(function(){
    $('#hamburger_button').on('click', function(e){
        e.stopPropagation();
        $('#hamburger_nav').toggleClass('active');
        console.log("hi");
    });

    $('.main_contents' ).on('click', function(e) {
        
        let tmp = $('#hamburger_nav');
        let click_class = e.target.className;
        console.log(click_class);
        if(click_class != "hamburger_nav"){
            console.log("hello");
            if(tmp.hasClass('active')) {
                $('#hamburger_nav').removeClass('active');
                

        }
        
        

        }
        
    });

    // $("body").click(function(event) {
    //     // console.log(event.target.nodeName);
    //     console.log(event.target.className);
    // });

});