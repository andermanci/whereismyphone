/**
 * Created by urtzi on 20/04/2017.
 */
jQuery(document).ready(function($) {
    $(".clickable-row").click(function() {
        window.location = $(this).data("href");
    });
});



