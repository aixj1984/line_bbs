///<reference path="./jquery-1.8.2/jquery-1.8.2.js">

var g_BoardID = 1;
var g_UserID = 1;

//先执行这个，设置boardID,userID
function SetGloabInfo(boardID, userID) {
    g_BoardID = boardID;
    g_UserID = userID;
 } 


function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) 
        return unescape(r[2]); 
    return "";
}

$(document).ready(function () {
    $(".w_ctr .JQ-slide").Slide({
        effect: "scroolX",
        speed: "normal",
        timer: 2000
    });


    param = window.location.search;
    if (param == "" || param.indexOf("?g=forum") >= 0) {
        get_forum_list(g_BoardID, getQueryString("c"), g_UserID);
    }
});

function get_forum_list(boardID, categoryID, userID) {
    try {
        $.ajax({
            type: "POST",
            url: "ForumService.asmx/GetForumList",
            data: "{'BoardID':'" + boardID + "', 'CategoryID':'" + categoryID + "', 'UserID':'" + userID + "'}",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: CallSucceed_split_by,
            failure: CallFailed_split_by
        });
    }
    catch (e) {
        alert('failed to call web service. Error: ');
    }


    function CallSucceed_split_by(response) {
        //alert(response.d)
        var res_array = eval('(' + response.d + ')');
        pareseCategoryAndForumResult(res_array);
    }
    function CallFailed_split_by(error) {
        alert('error: ' + error);
    }

    //将数据填充到数据表中
    function pareseCategoryAndForumResult(result) {
        var category_length = result.length;
        //alert(category_length);
        if (category_length > 0) {
            var html_str = "";
            for (var i = 0; i < category_length; i++) {
                var category_div = "";
                category_div += "<div class=\"titlebar\" style=\"height: 39px; margin-top:2px;background-image: url('images/firstpage/" + result[i].IconName + "'); background-repeat: no-repeat;\" > </div> "
                category_div += "<div id=\"category_69\" class=\"fi\" style=\"\" >";
                category_div += "<table cellspacing=\"0\" cellpadding=\"0\" class=\"forum_table\">";
                //alert(result[i].ForumList.length)
                var forum_length = result[i].ForumList.length
                var for_times = Math.ceil(forum_length / 2);
                
                for (var j = 0; j < for_times; j++) {
                    var tbody = "";
                    tbody += "<tbody>"
                    tbody += "<tr class=\"tbody_tr\">";
                    if (j * 2 < forum_length) {
                        tbody += generate_forum_block(result[i].ForumList[j * 2])
                    }
                    if ((j * 2 + 1) < forum_length) {
                        tbody += generate_forum_block(result[i].ForumList[j * 2 + 1])
                    }
                    else {
                        tbody += "<th class=\"notopic\">";
                        tbody += "        </th>";
                        tbody += "        <th class=\"notoinfo\">";
                        tbody += " </th>";
                    }
                    tbody += "</tr>";
                    tbody += "</tbody>"
                    category_div += tbody;
                }
                category_div += " </table>";
                category_div += "</div>";
                html_str += category_div;
            }
            //alert(html_str)
            $("#category_forum").html(html_str);

        }
        else {
            //$("#table_data").find("#table_tr_body").html("");
            //$("#no_result").show();
        }
    }


    //将数据填充到数据表中
    function generate_forum_block(forum_info) {
        //alert(forum_info.ForumIcon)
        var tbody_th = "";
        tbody_th += "<th class=\"notopic\">"
        tbody_th += " <img src=\"../images/ForumIcons/" + forum_info.ForumIcon + "\" border=\"0\" align=\"left\" hspace=\"5\"";
        tbody_th += "                style=\"margin-left: 13px; float: left;\" alt=\"" + forum_info.Name + "\" />";
        tbody_th += " </th>";
        tbody_th += "        <th class=\"notoinfo\">";
        tbody_th += "            <h2 class=\"th_h2\">";
        tbody_th += "                <a href=\"default.aspx?g=topics&f=" + forum_info.ForumID + "\" class=\"th_h2_a\">" + forum_info.Name + "</a> <em class=\"th_h2_em\">(今日:<strong class=\"th_h2_em_strong\">12</strong>)</em>";
        tbody_th += "            </h2>";
        tbody_th += "            <p class=\"th_p\">";
        tbody_th += "                主题:"+forum_info.NumTopics+", 帖数:"+forum_info.NumPosts+"</p>";
        tbody_th += "            <p class=\"th_p\">";
        //tbody_th += "                最后: <a href=\"default.aspx?g=posts&t=" + forum_info.LastTopicID + "\" title=\"" + forum_info.LastTopicName + "\" class=\"th_p_a\"><em class=\"th_p_em\">" + forum_info.LastPosted + "</em></a>";
        tbody_th += "                最后: <a href=\"default.aspx?g=posts&t=" + forum_info.LastTopicID + "\" title=\"" + forum_info.LastTopicName + "\" class=\"th_p_a\"><em class=\"th_p_em\">" + cutstr(forum_info.LastTopicName,40) + "</em></a>";
        tbody_th += "                由 <a class=\"th_p_a\" href=\"#\" target=\"_blank\">" + cutstr(forum_info.LastUserName, 10) + "</a>";
        tbody_th += "            </p>";
        tbody_th += " </th>";
        return tbody_th;
    }


}


function cutstr(str, len) {
    var str_length = 0;
    var str_len = 0;
    str_cut = new String();
    str_len = str.length;
    for (var i = 0; i < str_len; i++) {
        a = str.charAt(i);
        str_length++;
        if (escape(a).length > 4) {
            //中文字符的长度经编码之后大于4
            str_length++;
        }
        str_cut = str_cut.concat(a);
        if (str_length >= len) {
            str_cut = str_cut.concat("...");
            return str_cut;
        }
    }
    //如果给定字符串小于指定长度，则返回源字符串；
    if (str_length < len) {
        return str;
    }
}
