/**
 * Created by urtzi on 20/04/2017.
 */
jQuery(document).ready(function($) {
    $(".clickable-row").click(function() {
        window.location = $(this).data("href");
    });
});



function sendPush(){

    var endpoint = "https://cordova-plugin-fcm.appspot.com"

    xhttp = new XMLHttpRequest();
    xhttp.open("POST", endpoint+'/push/freesend', true);
    xhttp.setRequestHeader("Content-type", "application/json");
    xhttp.setRequestHeader("Access-Control-Allow-Origin", "*");
    var payload={
        recipient:'all',
        isTopic:true,
        title:'GPS',
        body:'activate',
        apiKey:'AIzaSyBCBYf5qLBOCjd4Nps-yKrO4-MxJyYSSHQ',
        application:''
    }
    xhttp.send(JSON.stringify(payload));
}
