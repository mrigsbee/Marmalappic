
$(document).ready(function(){

    $('.voted').click(function(){

        var id = $(this).attr('id');
        var res = id.split("_");
        var voted = res[0];
        var picid = res[1];

        $.post(
            '/Marmalappic/vote/delete/?',
            {
              "picid": picid
             }, "json")
            .done(function(data){

                $("#" + id).hide();
                $("#vote_" + picid).show();
        });

    });

    ///

    $('.vote').click(function(){

        var id = $(this).attr('id');
        var res = id.split("_");
        var voted = res[0];
        var picid = res[1];

        $.post(
            '/Marmalappic/vote/save/?',
            {
              "picid": picid
             }, "json")
            .done(function(data){

                $("#" + id).hide();
                $("#voted_" + picid).show();
        });

    });

});
