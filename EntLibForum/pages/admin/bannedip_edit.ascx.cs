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
	/// Summary description for bannedip_edit.
	/// </summary>
	public partial class bannedip_edit : AdminPage
	{

		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack) {
				PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
				PageLinks.AddLink("Administration",Forum.GetLink(Pages.admin_admin));
				PageLinks.AddLink("Banned IP Addresses",Forum.GetLink(Pages.admin_bannedip));

				BindData();
			}
		}

		private void BindData() {
			if(Request.QueryString["i"] != null) {
				DataRow row = DB.bannedip_list(PageBoardID,Request.QueryString["i"]).Rows[0];
				mask.Text = (string)row["Mask"];
			}
		}

		private void save_Click(object sender,EventArgs e) {
			String[] ip = mask.Text.Split('.');
			if(ip.Length!=4) {
				AddLoadMessage("Invalid ip address.");
				return;
			}
			DB.bannedip_save(Request.QueryString["i"],PageBoardID,mask.Text);
			Cache.Remove("bannedip");
			Forum.Redirect(Pages.admin_bannedip);
		}

		private void cancel_Click(object sender,EventArgs e) {
			Forum.Redirect(Pages.admin_bannedip);
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			save.Click += new EventHandler(save_Click);
			cancel.Click += new EventHandler(cancel_Click);
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
