using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using yaf.pages;

namespace yaf
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SetStyle();
            JudegSlit();
        }

        public void Page_Error(object sender, System.EventArgs e)
        {
            Exception x = Server.GetLastError();
            yaf.DB.eventlog_create(forum.PageUserID, this, x);
            yaf.Utils.LogToMail(x);
        }

        private void SetStyle()
        {
            const string style = "<link href=\"{0}{1}\" type=\"text/css\" rel=\"stylesheet\">";

            Style.Text = string.Format(style, Data.ForumRoot, "forum.css") + "\n" + string.Format(style, (new ForumPage()).ThemeFile("theme.css"), "");
        }
        private void JudegSlit()
        {
            HttpBrowserCapabilities bc = Request.Browser;
            if ("IE" == bc.Browser && 9 >= bc.MajorVersion)
            {
                this.Span1.InnerHtml = " <div style=\" width: 100%;background: url('images/firstpage/导航.gif') repeat-x scroll 0% 0% transparent; height:40px;margin-top:-3px;\">";
                //做处理
            }
            else
            {
                this.Span1.InnerHtml = " <div style=\" width: 100%;background: url('images/firstpage/导航.gif') repeat-x scroll 0% 0% transparent; height:40px;margin-top:0px;\">";
            }
            this.Span1.InnerHtml += "<div  style=\"width: 1002px;margin: 0 auto;  text-align:left;\">";
            this.Span1.InnerHtml += "<div class=\"innerWrapper\">";
            this.Span1.InnerHtml += "<ul id=\"navigator\">";
            this.Span1.InnerHtml += "<li class=\"youAreHere\"><a href=\"default.aspx?g=forum\">社区首页</a></li>";
            this.Span1.InnerHtml += "<li class=\"youAreHere\"><a href=\"http://www.hubeici.com/index.shtml\">文谷首页</a></li>";
            this.Span1.InnerHtml += "<li class=\"youAreHere\"><a href=\"http://www.hubeici.com/about_us\">关于我们</a></li>";
            this.Span1.InnerHtml += "</ul>";
            this.Span1.InnerHtml += "</div>";
            this.Span1.InnerHtml += "</div>";
            this.Span1.InnerHtml += "</div>";
        }
    }
}
