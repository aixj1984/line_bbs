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
	public partial class active : ForumPage
	{
		protected System.Web.UI.WebControls.DropDownList ForumJump;
		protected string LastForumName = "";

		public active()
			: base( "ACTIVE" )
		{
		}

		protected void Page_Load( object sender, System.EventArgs e )
		{
			// 20050909 CHP : BEGIN
			if ( IsPrivate && !User.IsAuthenticated )
			{
				if ( User.CanLogin )
					Forum.Redirect( Pages.login, "ReturnUrl={0}", Request.RawUrl );
				else
					Forum.Redirect( Pages.forum );
			}
			// 20050909 CHP : END

			// RssFeed.NavigateUrl = String.Format("{0}default.aspx?g=rsstopic&pg=active", Data.ForumRoot);
			if ( BoardSettings.ShowRSSLink )
			{
				RssFeed.NavigateUrl = Forum.GetLink( Pages.rsstopic, "pg=active" );
				RssFeed.Text = GetText( "RSSFEED" );
				RssFeed.Visible = true;
			}
			else
			{
				RssFeed.Visible = false;
			}

			if ( !IsPostBack )
			{
				PageLinks.AddLink( BoardSettings.Name, Forum.GetLink( Pages.forum ) );
				PageLinks.AddLink( GetText( "TITLE" ), "" );

				Since.Items.Add( new ListItem( String.Format( GetText( "last_visit" ), FormatDateTime( Mession.LastVisit ) ), "0" ) );
				Since.Items.Add( new ListItem( GetText( "last_hour" ), "-1" ) );
				Since.Items.Add( new ListItem( GetText( "last_two_hours" ), "-2" ) );
				Since.Items.Add( new ListItem( GetText( "last_day" ), "1" ) );
				Since.Items.Add( new ListItem( GetText( "last_two_days" ), "2" ) );
				Since.Items.Add( new ListItem( GetText( "last_week" ), "7" ) );
				Since.Items.Add( new ListItem( GetText( "last_two_weeks" ), "14" ) );
				Since.Items.Add( new ListItem( GetText( "last_month" ), "31" ) );
			}
			BindData();
		}

		private void Pager_PageChange( object sender, EventArgs e )
		{
			BindData();
		}

		#region Web Form Designer generated code
		override protected void OnInit( EventArgs e )
		{
			Pager.PageChange += new EventHandler( Pager_PageChange );
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit( e );
		}

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{

		}
		#endregion

		private void BindData()
		{
			DateTime SinceDate = DateTime.Now;
			int SinceValue = 0;

			if ( Since.SelectedItem != null )
			{
				SinceValue = int.Parse( Since.SelectedItem.Value );
				SinceDate = DateTime.Now;
				if ( SinceValue > 0 )
					SinceDate = DateTime.Now - TimeSpan.FromDays( SinceValue );
				else if ( SinceValue < 0 )
					SinceDate = DateTime.Now + TimeSpan.FromHours( SinceValue );
			}
			if ( SinceValue == 0 )
				SinceDate = Mession.LastVisit;


			PagedDataSource pds = new PagedDataSource();
			pds.AllowPaging = true;

			object categoryIDObject = null;

			if ( ForumControl.CategoryID != 0 ) categoryIDObject = ForumControl.CategoryID;

			DataView dv = DB.topic_active( PageBoardID, PageUserID, SinceDate, categoryIDObject ).DefaultView;
			pds.DataSource = dv;
			Pager.Count = dv.Count;
			Pager.PageSize = 15;
			pds.PageSize = Pager.PageSize;

			pds.CurrentPageIndex = Pager.CurrentPageIndex;
			TopicList.DataSource = pds;

			DataBind();
		}

		protected string PrintForumName( DataRowView row )
		{
			string ForumName = ( string ) row ["ForumName"];
			string html = "";
			if ( ForumName != LastForumName )
			{
				html = String.Format( "<tr><td class=header2 colspan=6><a href=\"{1}\">{0}</a></td></tr>", ForumName, Forum.GetLink( Pages.topics, "f={0}", row ["ForumID"] ) );
				LastForumName = ForumName;
			}
			return html;
		}

		protected void Since_SelectedIndexChanged( object sender, System.EventArgs e )
		{
			BindData();
		}
	}
}
