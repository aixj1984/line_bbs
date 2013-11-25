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

    }
}
