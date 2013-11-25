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
	/// Summary description for active.
	/// </summary>
	public partial class im_email : ForumPage
	{

		public im_email() : base("IM_EMAIL")
		{
		}

		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!User.IsAuthenticated)
				Data.AccessDenied();

			if(!IsPostBack) 
			{
				using(DataTable dt=DB.user_list(PageBoardID,Request.QueryString["u"],null)) 
				{
					foreach(DataRow row in dt.Rows) 
					{
						PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
						PageLinks.AddLink(row["Name"].ToString(),Forum.GetLink(Pages.profile,"u={0}",row["UserID"]));
						PageLinks.AddLink(GetText("TITLE"),"");
						break;
					}
				}
				Send.Text = GetText("SEND");
			}
		}

		private void Send_Click(object sender,EventArgs e)
		{
			try
			{
 				string from = string.Empty, to = string.Empty;
 				string fromName = string.Empty, toName = string.Empty;
				using(DataTable dt=DB.user_list(PageBoardID,Request.QueryString["u"],null)) 
				{
					foreach(DataRow row in dt.Rows) 
					{
 						to = row["Email"].ToString();
 						toName = row["Name"].ToString();
						break;
					}
				}
				using(DataTable dt=DB.user_list(PageBoardID,PageUserID,null)) 
				{
					foreach(DataRow row in dt.Rows) 
					{
 						from = row["Email"].ToString();
 						fromName = row["Name"].ToString();
						break;
					}
				}
 				Utils.SendMail(this, from, fromName, to, toName, Subject.Text, Body.Text);
				Forum.Redirect(Pages.profile,"u={0}",Request.QueryString["u"]);
			}
			catch(Exception x) 
			{
				DB.eventlog_create(PageUserID,this,x);
				if(IsAdmin)
					AddLoadMessage(x.Message);
				else
					AddLoadMessage(GetText("ERROR"));
			}
		}

		override protected void OnInit(EventArgs e)
		{
			this.Send.Click += new EventHandler(Send_Click);
			base.OnInit(e);
		}
	}
}
