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
	/// Summary description for movetopic.
	/// </summary>
	public partial class movetopic : ForumPage
	{
	
		public movetopic() : base("MOVETOPIC")
		{
		}

		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(Request.QueryString["t"] == null || !ForumModeratorAccess)
				Data.AccessDenied();

			if(!IsPostBack)
			{
				if(ForumControl.LockedForum==0)
				{
					PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
					PageLinks.AddLink(PageCategoryName,Forum.GetLink(Pages.forum,"c={0}",PageCategoryID));
				}
				PageLinks.AddForumLinks(PageForumID);
				PageLinks.AddLink(PageTopicName,Forum.GetLink(Pages.posts,"t={0}",PageTopicID));

				Move.Text = GetText("move");

				ForumList.DataSource = DB.forum_listall_sorted(PageBoardID,PageUserID);
				
				DataBind();
				
				System.Web.UI.WebControls.ListItem pageItem = ForumList.Items.FindByValue(PageForumID.ToString());
				if (pageItem != null) pageItem.Selected = true;
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

		protected void Move_Click(object sender, System.EventArgs e)
		{
			// only move if it's a destination is a different forum.
			if (Convert.ToInt32(ForumList.SelectedValue) != PageForumID)
			{
				DB.topic_move(PageTopicID,ForumList.SelectedValue,BoardSettings.ShowMoved);
			}
			Forum.Redirect(Pages.topics,"f={0}",PageForumID);
		}
	}
}
