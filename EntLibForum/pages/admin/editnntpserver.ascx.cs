using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace yaf.pages.admin
{
	/// <summary>
	/// Summary description for editgroup.
	/// </summary>
	public partial class editnntpserver : AdminPage
	{

		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack) 
			{
				PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
				PageLinks.AddLink("Administration",Forum.GetLink(Pages.admin_admin));
				PageLinks.AddLink("NNTP Servers","");

				BindData();
				if(Request.QueryString["s"] != null) 
				{
					using(DataTable dt = DB.nntpserver_list(PageBoardID,Request.QueryString["s"]))
					{
						DataRow row = dt.Rows[0];
						Name.Text		= row["Name"].ToString();
						Address.Text	= row["Address"].ToString();
						Port.Text		= row["Port"].ToString();
						UserName.Text	= row["UserName"].ToString();
						UserPass.Text	= row["UserPass"].ToString();
					}
				}
				else
				{
					Port.Text = "119";
				}
			}
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
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

		private void BindData() {
			DataBind();
		}

		protected void Cancel_Click(object sender, System.EventArgs e)
		{
			Forum.Redirect(Pages.admin_nntpservers);
		}

		protected void Save_Click(object sender, System.EventArgs e)
		{
			if(Name.Text.Trim().Length==0) 
			{
				AddLoadMessage("Missing server name.");
				return;
			}
			if(Address.Text.Trim().Length==0) 
			{
				AddLoadMessage("Missing server address.");
				return;
			}

			object nntpServerID = null;
			if(Request.QueryString["s"]!=null) nntpServerID = Request.QueryString["s"];
			DB.nntpserver_save(nntpServerID,PageBoardID,Name.Text,Address.Text,Port.Text.Length>0 ? Port.Text : null,UserName.Text.Length>0 ? UserName.Text : null,UserPass.Text.Length>0 ? UserPass.Text : null);
			Forum.Redirect(Pages.admin_nntpservers);
		}
	}
}
