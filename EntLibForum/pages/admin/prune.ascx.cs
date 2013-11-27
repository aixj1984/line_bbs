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
	/// Summary description for prune.
	/// </summary>
	public partial class prune : AdminPage
	{

		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack) {
				PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
				PageLinks.AddLink("��̨����",Forum.GetLink(Pages.admin_admin));
				PageLinks.AddLink("ɾ������","");

				days.Text = "60";
				BindData();
			}
		}

		private void BindData() {
			forumlist.DataSource = DB.forum_listread(PageBoardID,PageUserID,null,null);
			forumlist.DataValueField = "ForumID";
			forumlist.DataTextField = "Forum";
			DataBind();
			forumlist.Items.Insert(0,new ListItem("All Forums","0"));
		}

		private void commit_Click(object sender,EventArgs e) {
			int Count = DB.topic_prune(forumlist.SelectedValue,days.Text);
			AddLoadMessage(String.Format("{0} topic(s) deleted.",Count));
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			commit.Click += new EventHandler(commit_Click);
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
