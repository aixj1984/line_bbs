using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace yaf.pages
{
	/// <summary>
	/// Summary description for approve.
	/// </summary>
	public partial class approve : ForumPage
	{
		
		public approve() : base("APPROVE")
		{
		}

		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack) {
				PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
				PageLinks.AddLink(GetText("TITLE"),"");

				ValidateKey.Text = GetText("validate");
				if(Request.QueryString["k"]!=null)
				{
					key.Text = Request.QueryString["k"];
					ValidateKey_Click(sender,e);
				}
				else
				{
					approved.Visible = false;
					error.Visible = !approved.Visible;
				}
			}
		}

		private void ValidateKey_Click(object sender, System.EventArgs e)
		{
			approved.Visible = DB.checkemail_update(key.Text);
			error.Visible = !approved.Visible;
			AddLoadMessage(GetText("EMAIL_VERIFIED"));
			Response.Redirect("default.aspx?g=login");
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			ValidateKey.Click += new EventHandler(ValidateKey_Click);
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    

		}
		#endregion
	}
}
