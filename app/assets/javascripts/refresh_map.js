/**
 * Created by andermanci on 19/5/17.
 */
$(document).ready(function () {
    // will call refreshPartial every 30 seconds
    setInterval(refreshMap, 15000)

});

// calls action refreshing the partial
function refreshMap() {
    $.ajax({
        url: "get_gps"
    })
}