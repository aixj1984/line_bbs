using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace yaf
{
	/// <summary>
	/// Summary description for error.
	/// </summary>
	public partial class error : System.Web.UI.Page
	{
		protected void Page_Load(object sender, System.EventArgs e)
		{
			// Forum.Redirect(Pages.error,Request.QueryString.ToString());
            if (Request.QueryString["errmsg"] != null)
            {
                lblMessage.Text = Request.QueryString["errmsg"].ToString();
            }
		}

		override protected void OnInit(EventArgs e)
		{
			this.Load += new System.EventHandler(this.Page_Load);
			base.OnInit(e);
		}
	}
}
