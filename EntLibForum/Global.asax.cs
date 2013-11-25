using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace yaf
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {
            // Code that runs when unhandled error occur
            Exception ex = Server.GetLastError().GetBaseException();
            string requestURL = Request.Url.ToString();

            Response.Redirect("error.aspx?errmsg=" + ex.Message);
        }
    }
}