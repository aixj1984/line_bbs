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
	/// Summary description for cp_subscriptions.
	/// </summary>
	public partial class cp_subscriptions : ForumPage
	{

		public cp_subscriptions() : base("CP_SUBSCRIPTIONS")
		{
		}

		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!User.IsAuthenticated)
			{
				if(User.CanLogin)
					Forum.Redirect(Pages.login,"ReturnUrl={0}",Utils.GetSafeRawUrl());
				else
					Forum.Redirect(Pages.forum);
			}
			
			if(!IsPostBack) 
			{
				BindData();

				PageLinks.AddLink(BoardSettings.Name,Forum.GetLink(Pages.forum));
				PageLinks.AddLink(PageUserName,Forum.GetLink(Pages.cp_profile));
				PageLinks.AddLink(GetText("TITLE"),"");

				UnsubscribeForums.Text = GetText("unsubscribe");
				UnsubscribeTopics.Text = GetText("unsubscribe");
			}
		}

		private void BindData() {
			ForumList.DataSource = DB.watchforum_list(PageUserID);
			TopicList.DataSource = DB.watchtopic_list(PageUserID);
			DataBind();
		}

		protected string FormatForumReplies(object o) 
		{
			DataRowView row = (DataRowView)o;
			return String.Format("{0}",(int)row["Messages"] - (int)row["Topics"]);
		}

		protected string FormatLastPosted(object o) {
			DataRowView row = (DataRowView)o;

			if(row["LastPosted"].ToString().Length==0)
				return "&nbsp;";

			string link = String.Format("<a href=\"{0}\">{1}</a>",
				Forum.GetLink(Pages.profile,"u={0}",row["LastUserID"]),
				row["LastUserName"]
			);
			string by = String.Format(GetText("lastpostlink"),
				FormatDateTime((DateTime)row["LastPosted"]),
				link);

			string html = String.Format("{0} <a href=\"{1}\"><img src=\"{2}\"'></a>",
				by,
				Forum.GetLink(Pages.posts,"m={0}#{0}",row["LastMessageID"]),
				GetThemeContents("ICONS","ICON_LATEST")
				);
			return html;
		}

		protected void UnsubscribeTopics_Click(object sender, System.EventArgs e) {
			bool NoneChecked = true;
			for(int i=0;i<TopicList.Items.Count;i++) {
				CheckBox ctrl = (CheckBox)TopicList.Items[i].FindControl("unsubx");
				Label lbl = (Label)TopicList.Items[i].FindControl("ttid");
				if(ctrl.Checked) {
					DB.watchtopic_delete(lbl.Text);
					NoneChecked = false;
				}
			}
			if(NoneChecked)
				AddLoadMessage(GetText("WARN_SELECTTOPICS"));
			else
				BindData();
		}

		protected void UnsubscribeForums_Click(object sender, System.EventArgs e) {
			bool NoneChecked = true;
			for(int i=0;i<ForumList.Items.Count;i++) {
				CheckBox ctrl = (CheckBox)ForumList.Items[i].FindControl("unsubf");
				Label lbl = (Label)ForumList.Items[i].FindControl("tfid");
				if(ctrl.Checked) {
					DB.watchforum_delete(lbl.Text);
					NoneChecked = false;
				}
			}
			if(NoneChecked)
				AddLoadMessage(GetText("WARN_SELECTFORUMS"));
			else
				BindData();
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
	}
}
