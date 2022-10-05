$(function() {
    $("#select_subscription").change(function() {
        var val = $(this).val();
        var selectSubscriptionId = '#' + val;
        $('ul#subscription_list li').hide();
        $(selectSubscriptionId).show();
    });
});