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
	/// Summary description for printtopic.
	/// </summary>
	public partial class printtopic : ForumPage
	{

		public printtopic() : base("PRINTTOPIC")
		{
		}

		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(Request.QueryString["t"] == null || !ForumReadAccess)
				Data.AccessDenied();

			ShowToolBar = false;

			if(!IsPostBack) {
				if(ForumControl.LockedForum==0)
				{
					PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
					PageLinks.AddLink(PageCategoryName,Forum.GetLink(Pages.forum,"c={0}",PageCategoryID));
				}
				PageLinks.AddForumLinks(PageForumID);
				PageLinks.AddLink(PageTopicName,Forum.GetLink(Pages.posts,"t={0}",PageTopicID));

				Posts.DataSource = DB.post_list(PageTopicID,1);
				DataBind();
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

		protected string GetPrintHeader(object o)
		{
			DataRowView row = (DataRowView)o;
			return String.Format("<b>{2}: {0}</b> - {1}",row["UserName"],FormatDateTime((DateTime)row["Posted"]),GetText("postedby"));
		}

		protected string GetPrintBody(object o)
		{
			DataRowView row = (DataRowView)o;
		
			string message = row["Message"].ToString();

			message = FormatMsg.FormatMessage(this,message,new MessageFlags(Convert.ToInt32(row["Flags"])));
			
			return message;
		}
	}
}
