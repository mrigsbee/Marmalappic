
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

    ///
    $('.flagged').click(function(){

        var id = $(this).attr('id');
        var res = id.split("_");
        var picid = res[1];

        var id = $(this).attr('id');

        $.post(
            '/Marmalappic/postvote/?',
            {
              "picid": picid
             }, "json")
            .done(function(data){

                $("#" + id).hide();
                $("#flagged_" + picid).show();
        });

    });

    ///
    $('.delete').click(function(){

        var id = $(this).attr('id');
        var res = id.split("_");
        var picid = res[1];
        var user = res[2];

        $.post(
            '/Marmalappic/admin/delete/?',
            {
              "picid": picid,
              "username": user
             }, "json")
            .done(function(data){
                 location.reload();
            });
    });
});
