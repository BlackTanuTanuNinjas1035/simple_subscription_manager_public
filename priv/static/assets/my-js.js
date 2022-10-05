$("[name=apply_type]").change(function () {
    let val = $("[name=subscription_type]").val();
    if (val == 1) {
        $("#text1").show();

    }
})