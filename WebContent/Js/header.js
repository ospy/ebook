$(document).ready(function () {
//导航条
$(".navbar li").mouseenter(function () {

    $(this).find(".popmenu").css({ "display": "block" });

    $(this).find("b").attr("class", "navitriangel-trans");


});

$(".navbar li").mouseleave(function () {

    $(this).find(".popmenu").css({ "display": "none" });

    $(this).find("b").attr("class", "navitriangel");


});

});