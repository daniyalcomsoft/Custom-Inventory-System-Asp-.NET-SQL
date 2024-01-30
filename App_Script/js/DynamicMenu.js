
function JSON_Menu() {
    var jsonMenu = JSON.parse($("[id$=hdnMenu]").val());
    var jsonSubMenu = JSON.parse($("[id$=hdnSubMenu]").val());
    var jsonPages = JSON.parse($("[id$=hdnPages]").val());
    var MenuUrl = $("[id$=hdnMenuLink]").val();
  

    for (var i = 0; i < jsonMenu.length; i++) {

        var MenuID = jsonMenu[i].MenuID; //MenuID
        var MenuName = jsonMenu[i].MenuName; //MenuName
        var MenuIcon = jsonMenu[i].MenuIcon; //MenuIcon
        var MenuCount = jsonMenu[i].MenuCount; //MenuPageCount 
       
       
        var ExistinSubMenu = jsonSubMenu.filter(function (item) {
            return item.MenuID == MenuID
        });

        if (ExistinSubMenu.length > 0)
        {
            $("#MainID").append(
                 $('<li id="' + MenuID + '" runat="server">').attr('class', 'site-menu-item has-sub').append(
                 $('<a href="javascript:void(0)">').attr('class', 'waves-effect waves-classic').append(
                 $('<i aria-hidden="true">').attr('class', MenuIcon.trim())).append(
                 $('<span>').attr('class', 'site-menu-title').append(MenuName.replace(" ", "<br/>")))).append(
                 $('<ul>').attr('class', 'site-menu-sub')))



            for (var j = 0; j < jsonSubMenu.length; j++) {

                var SubMenu = jsonSubMenu[j].SubTitle; //SubMenu
                var SubMenuID = jsonSubMenu[j].SubTitleID; //SubMenu

                $("[Id$=" + MenuID + "] > ul").append($('<li>').attr('class', 'site-menu-item has-sub').append(
      $('<a>').attr('href', "javascript:void(0)").append(
      $('<span>').append(SubMenu).attr('class', "site-menu-title")).append($('<span>').attr('class', "site-menu-arrow"))).append($('<ul id="' + SubMenuID + '" runat="server">').attr('class', 'site-menu-sub')))
               
                var PagesbySubMenuname = jsonPages.filter(function (item) {
                    return item.MenuID == MenuID && item.SubTitleID == SubMenuID
                });

                for (var m = 0; m < PagesbySubMenuname.length; m++) {

                    var subPageName = PagesbySubMenuname[m].PageName;
                    var subPageUrl = MenuUrl + PagesbySubMenuname[m].PageUrl; //PageUrl
                    var subPageicon = PagesbySubMenuname[m].PageIcon; //PageIcon 
                    $("[Id$=" + MenuID + "] > ul > li > [Id$=" + SubMenuID + "]").append($('<li>').attr('class', 'site-menu-item').append(
      $('<a>').attr('href', subPageUrl.trim()).attr('class', 'animsition-link waves-effect waves-classic').append(
      $('<span>').attr('class', 'site-menu-title').append(
      $('<i>').attr('class', subPageicon)).append(subPageName))))

                }



            }

        }
        else
        {
           

               
                var PagesbyMenu = jsonPages.filter(function (item) {
                    return item.MenuID == MenuID
                });

                if (PagesbyMenu.length == 1)
                {
                    var PageName = PagesbyMenu[0].PageName;
                    var PageUrl = MenuUrl + PagesbyMenu[0].PageUrl; //PageUrl
                    var Pageicon = PagesbyMenu[0].PageIcon; //PageIcon 
                    $("#MainID").append(
      $('<li id="' + MenuID + '" runat="server">').attr('class', 'site-menu-item').append(
      $('<a>').attr('class', 'animsition-link waves-effect waves-classic').attr('href', PageUrl.trim()).append(
      $('<i aria-hidden="true">').attr('class', MenuIcon.trim())).append($('<span>').append(PageName).attr('class', 'site-menu-title'))));

                }
                else
                {

                    $("#MainID").append(
                   $('<li id="' + MenuID + '" runat="server">').attr('class', 'site-menu-item has-sub').append(
                   $('<a href="javascript:void(0)">').attr('class', 'waves-effect waves-classic').append(
                   $('<i aria-hidden="true">').attr('class', MenuIcon.trim())).append(
                   $('<span>').attr('class', 'site-menu-title').append(MenuName.replace(" ", "<br/>")))).append(
                   $('<ul>').attr('class', 'site-menu-sub')))


                for (var k = 0; k < PagesbyMenu.length; k++) {

                    var PageName = PagesbyMenu[k].PageName;
                    var PageUrl = MenuUrl + PagesbyMenu[k].PageUrl; //PageUrl
                    var Pageicon = PagesbyMenu[k].PageIcon; //PageIcon 

                    $("[Id$=" + MenuID + "] > ul").append($('<li>').attr('class', 'site-menu-item').append(
      $('<a>').attr('href', PageUrl.trim()).attr('class', 'animsition-link waves-effect waves-classic').append(
      $('<span>').attr('class', 'site-menu-title').append(
      $('<i>').attr('class', Pageicon)).append(PageName))))


                }
                    }
           
          
        }


    }



}




function UpperCase(str) {
    str = str.toLowerCase().replace(/\b[a-z]/g, function (letter) {
        return letter.toUpperCase();
    });
    return str;
}

$("li .searchterm").on('click', function () {
    console.log('testing');
});







