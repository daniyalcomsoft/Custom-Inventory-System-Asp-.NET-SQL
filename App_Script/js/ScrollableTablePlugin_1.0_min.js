﻿//function MakeScrollable(e, t) { for (var a = e.id, l = (e.offsetHeight, new Array), i = 0; i < e.getElementsByTagName("TH").length; i++) l[i] = e.getElementsByTagName("TH")[i].offsetWidth; e.parentNode.appendChild(document.createElement("div")); var n = e.parentNode, d = document.createElement("table"); for (i = 0; i < e.attributes.length; i++) e.attributes[i].specified && "id" != e.attributes[i].name && d.setAttribute(e.attributes[i].name, e.attributes[i].value); d.style.cssText = e.style.cssText, d.appendChild(document.createElement("tbody")), d.getElementsByTagName("tbody")[0].appendChild(e.getElementsByTagName("TR")[0]); for (var s = d.getElementsByTagName("TH"), o = e.getElementsByTagName("TR")[0], r = 0, i = 0; i < s.length; i++) { var h; h = l[i] > o.getElementsByTagName("TD")[i].offsetWidth ? l[i] : o.getElementsByTagName("TD")[i].offsetWidth, r += h, s[i].style.width = parseInt(h) + "px", $("tr", $(e)).each(function () { $("td", this).eq(i).css("width", h) }) } n.removeChild(e); var c = document.createElement("div"); c.id = "header" + a, c.appendChild(d), n.appendChild(c); var m = document.createElement("div"); c = document.getElementById(c.id), c.style.width = "9999999999999px"; var p = c.getElementsByTagName("table")[0].offsetWidth; c.style.width = p + 17 + "px", r > p ? (c.getElementsByTagName("table")[0].style.width = r + "px", m.style.cssText = "overflow:auto;height:" + t.ScrollHeight + "px;width:" + (r + 17) + "px") : m.style.cssText = "overflow:auto;height:" + t.ScrollHeight + "px;width:" + (p + 17) + "px", m.appendChild(e), n.appendChild(m), t.Width > 0 && (n.style.cssText = "overflow:auto;width:" + t.Width + "px"), m.scrollTop = position, m.onscroll = function () { position = m.scrollTop } } !function (e) { e.fn.Scrollable = function (t) { var a = { ScrollHeight: 300, Width: 0 }, t = e.extend(a, t); return this.each(function () { { var a = e(this).get(0); a.id } MakeScrollable(a, t) }) } } (jQuery); var position = 0;


function MakeScrollable(e, t) {
    for (var a = e.id, l = (e.offsetHeight, new Array), i = 0; i < e.getElementsByTagName("TH").length; i++) l[i] = e.getElementsByTagName("TH")[i].offsetWidth;
    e.parentNode.appendChild(document.createElement("div"));
    var n = e.parentNode,
		d = document.createElement("table");
    for (i = 0; i < e.attributes.length; i++) e.attributes[i].specified && "id" != e.attributes[i].name && d.setAttribute(e.attributes[i].name, e.attributes[i].value);
    d.style.cssText = e.style.cssText, d.appendChild(document.createElement("tbody")), d.getElementsByTagName("tbody")[0].appendChild(e.getElementsByTagName("TR")[0]);
    for (var s = d.getElementsByTagName("TH"), o = e.getElementsByTagName("TR")[0], r = 0, i = 0; i < s.length; i++) {
        var h;
        h = l[i] > o.getElementsByTagName("TD")[i].offsetWidth ? l[i] : o.getElementsByTagName("TD")[i].offsetWidth, r += h, s[i].style.width = parseInt(h) + "px", $("tr", $(e)).each(function () {
            $("td", this).eq(i).css("width", h)
        })
    }
    n.removeChild(e);
    var c = document.createElement("div");
    c.id = "header" + a, c.appendChild(d), n.appendChild(c);
    var m = document.createElement("div");
    // c = document.getElementById(c.id), c.style.width = "9999999999999px";
    var p = c.getElementsByTagName("table")[0].offsetWidth - 20;
    c.style.width = p + 17 + "px", r > p ? (c.getElementsByTagName("table")[0].style.width = r + "px", m.style.cssText = "overflow:auto;height:" + t.ScrollHeight + "px;width:" + (r - 20 + 17) + "px") : m.style.cssText = "overflow:auto;height:" + t.ScrollHeight + "px;width:" + (p + 17) + "px", m.appendChild(e), n.appendChild(m), t.Width > 0 && (n.style.cssText = "overflow:auto;width:" + t.Width + "px"), m.scrollTop = position, m.onscroll = function () {
        position = m.scrollTop
    }
} ! function (e) {
    e.fn.Scrollable = function (t) {
        var a = {
            ScrollHeight: 300,
            Width: 0
        },
			t = e.extend(a, t);
        return this.each(function () {
            {
                var a = e(this).get(0);
                a.id
            }
            MakeScrollable(a, t)
        })
    }
}(jQuery);
var position = 0;