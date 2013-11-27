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
	/// Summary description for mail.
	/// </summary>
	public partial class mail : AdminPage
	{
	
		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack) 
			{
				PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
				PageLinks.AddLink("后台管理",Forum.GetLink(Pages.admin_admin));
				PageLinks.AddLink("发送邮件","");

				BindData();
			}
		}

		private void BindData() {
			ToList.DataSource = DB.group_list(PageBoardID,null);
			DataBind();

			ListItem item = new ListItem("All Users","0");
			ToList.Items.Insert(0,item);
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

		protected void Send_Click(object sender, System.EventArgs e) {
			object GroupID = null;
			if(ToList.SelectedItem.Value!="0")
				GroupID = ToList.SelectedValue;

			using(DataTable dt = DB.user_emails(PageBoardID,GroupID)) 
			{
				foreach(DataRow row in dt.Rows)
					//  Build a MailMessage
					Utils.SendMail(this,BoardSettings.ForumEmail,(string)row["Email"],Subject.Text,Body.Text);
			}
			Subject.Text = "";
			Body.Text = "";
			AddLoadMessage("Mails sent.");
		}
	}
}
