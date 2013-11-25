using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;

namespace yaf.pages
{
	/// <summary>
	/// Summary description for _default.
	/// </summary>
	public partial class forum : ForumPage
	{

		public forum()
			: base( "DEFAULT" )
		{
		}

		protected void Page_Load( object sender, System.EventArgs e )
		{
			if ( !IsPostBack )
			{
				if ( IsPrivate && ( User == null || ( User != null && !User.IsAuthenticated ) ) )
				{
					Forum.Redirect( Pages.login, "ReturnUrl={0}", Request.RawUrl );
				}

				TimeNow.Text = String.Format( GetText( "CURRENT_TIME" ), FormatTime( DateTime.Now ) );
				TimeLastVisit.Text = String.Format( GetText( "last_visit" ), FormatDateTime( Mession.LastVisit ) );
				MarkAll.Text = GetText( "MARKALL" );

				if ( UnreadPrivate > 0 )
				{
					UnreadMsgs.Visible = true;
					UnreadMsgs.NavigateUrl = Forum.GetLink( Pages.cp_inbox );
					if ( UnreadPrivate == 1 )
						UnreadMsgs.Text = String.Format( GetText( "unread1" ), UnreadPrivate );
					else
						UnreadMsgs.Text = String.Format( GetText( "unread0" ), UnreadPrivate );
				}

				if ( ForumControl.LockedForum == 0 )
				{
					// PageLinks.AddLink( BoardSettings.Name, Forum.GetLink( Pages.forum ) );
                    PageLinks.AddLink(BoardSettings.Name, "/");

					if ( PageCategoryID != 0 )
					{
						PageLinks.AddLink( PageCategoryName, Forum.GetLink( Pages.forum, "c={0}", PageCategoryID ) );
						Welcome.Visible = false;
					}
				}

                //load remembered forum categories collapse info
                string[] catIDs = null;
                if (Request.Cookies["CollapsedForumCategories"] != null && (!string.IsNullOrEmpty(Request.Cookies["CollapsedForumCategories"].Value)))
                {
                    catIDs = Request.Cookies["CollapsedForumCategories"].Value.Split(',');
                }
                else if (!string.IsNullOrEmpty(System.Configuration.ConfigurationManager.AppSettings["DefaultCollapsedForumCategories"]))
                {
                    catIDs = System.Configuration.ConfigurationManager.AppSettings["DefaultCollapsedForumCategories"].Split(',');
                }
                if (catIDs != null)
                {
                    foreach (string catID in catIDs)
                    {
				        Mession.PanelState["categoryPanel" + catID] = PanelSessionState.CollapsiblePanelState.Collapsed;
                    }

                HttpCookie newCookie = new HttpCookie("CollapsedForumCategories", string.Join(",", catIDs));
                newCookie.Expires = DateTime.Now.AddYears(1);
                Response.Cookies.Add(newCookie);
                }

				BindData();
			}

		}

		protected void MarkAll_Click( object sender, System.EventArgs e )
		{
			Mession.LastVisit = DateTime.Now;
			BindData();
		}

		private void BindData()
		{
			DataSet ds = DB.board_layout( PageBoardID, PageUserID, PageCategoryID, null );
			CategoryList.DataSource = ds.Tables ["yaf_Category"];

			// Active users
			// Call this before forum_stats to clean up active users
			ActiveList.DataSource = DB.active_list( PageBoardID, null );

			// Latest forum posts
			// Shows the latest n number of posts on the main forum list page
			LatestPosts.DataSource = DB.topic_latest( PageBoardID, 7, PageUserID );

			// Forum statistics
			string key = string.Format( "BoardStats.{0}", PageBoardID );
			DataRow stats = ( DataRow ) Cache [key];
			if ( stats == null )
			{
				stats = DB.board_poststats( PageBoardID );
				Cache.Insert( key, stats, null, DateTime.Now.AddMinutes( 15 ), TimeSpan.Zero );
			}

			Stats.Text = String.Format( GetText( "stats_posts" ), stats ["posts"], stats ["topics"], stats ["forums"] );
			Stats.Text += "<br/>";

			if ( !stats.IsNull( "LastPost" ) )
			{
				Stats.Text += String.Format( GetText( "stats_lastpost" ),
					FormatDateTimeTopic( ( DateTime ) stats ["LastPost"] ),
					String.Format( "<a href=\"{0}\">{1}</a>", Forum.GetLink( Pages.profile, "u={0}", stats ["LastUserID"] ), Server.HtmlEncode( stats ["LastUser"].ToString() ) )
				);
				Stats.Text += "<br/>";
			}

			if ( BoardSettings.ShowMemberStats )
			{
				Stats.Text += String.Format( GetText( "stats_members" ), stats ["members"] );
				Stats.Text += "<br/>";
			}

			Stats.Text += String.Format( GetText( "stats_lastmember" ),
				String.Format( "<a href=\"{0}\">{1}</a>", Forum.GetLink( Pages.profile, "u={0}", stats ["LastMemberID"] ), Server.HtmlEncode( stats ["LastMember"].ToString() ) )
				);
			Stats.Text += "<br/>";

			DataRow activeStats = DB.active_stats( PageBoardID );
			activeinfo.Text = String.Format( "<a href=\"{3}\">{0}</a> - {1}, {2}.",
				String.Format( GetText( ( int ) activeStats ["ActiveUsers"] == 1 ? "ACTIVE_USERS_COUNT1" : "ACTIVE_USERS_COUNT2" ), activeStats ["ActiveUsers"] ),
				String.Format( GetText( ( int ) activeStats ["ActiveMembers"] == 1 ? "ACTIVE_USERS_MEMBERS1" : "ACTIVE_USERS_MEMBERS2" ), activeStats ["ActiveMembers"] ),
				String.Format( GetText( ( int ) activeStats ["ActiveGuests"] == 1 ? "ACTIVE_USERS_GUESTS1" : "ACTIVE_USERS_GUESTS2" ), activeStats ["ActiveGuests"] ),
				Forum.GetLink( Pages.activeusers )
				);

			activeinfo.Text += "<br/>" + string.Format( GetText( "MAX_ONLINE" ), BoardSettings.MaxUsers, FormatDateTimeTopic( BoardSettings.MaxUsersWhen ) );

            if (BoardSettings.ForumAd != null && BoardSettings.ForumAd.Trim().Length > 0)
            {
                lblForumAd.Text = "<div id='AD-text'><div class='inner'>" + BoardSettings.ForumAd + "</div></div>";
                lblForumAd.Visible = true;
            }
            else
            {
                lblForumAd.Visible = false;
            }

			UpdateActiveDiscussionsPanel();
			UpdateInformationPanel();

			DataBind();
		}

		protected string FormatLastPost( System.Data.DataRow row )
		{
			if ( !row.IsNull( "LastPosted" ) )
			{
				string minipost;
				if ( DateTime.Parse( row ["LastPosted"].ToString() ) > Mession.LastVisit )
					minipost = GetThemeContents( "ICONS", "ICON_NEWEST" );
				else
					minipost = GetThemeContents( "ICONS", "ICON_LATEST" );

				return String.Format( "{0}<br/>{1}<br/>{2}&nbsp;<a title=\"{4}\" href=\"{5}\"><img src=\"{3}\"></a>",
					FormatDateTimeTopic( Convert.ToDateTime( row ["LastPosted"] ) ),
					String.Format( GetText( "in" ), String.Format( "<a href=\"{0}\">{1}</a>", Forum.GetLink( Pages.posts, "t={0}", row ["LastTopicID"] ), row ["LastTopicName"] ) ),
					String.Format( GetText( "by" ), String.Format( "<a href=\"{0}\">{1}</a>", Forum.GetLink( Pages.profile, "u={0}", row ["LastUserID"] ), row ["LastUser"] ) ),
					minipost,
					GetText( "GO_LAST_POST" ),
					Forum.GetLink( Pages.posts, "m={0}#{0}", row ["LastMessageID"] )
					);
			}
			else
				return GetText( "NO_POSTS" );
		}

		protected string GetViewing( object o )
		{
			DataRow row = ( DataRow ) o;
			int nViewing = ( int ) row ["Viewing"];
			if ( nViewing > 0 )
				return "&nbsp;" + String.Format( GetText( "VIEWING" ), nViewing );
			else
				return "";
		}

		protected string GetForumIcon( object o )
		{
			DataRow row = ( DataRow ) o;
			bool locked = ( bool ) row ["Locked"];
			DateTime lastRead = GetForumRead( ( int ) row ["ForumID"] );
			DateTime lastPosted = row ["LastPosted"] != DBNull.Value ? ( DateTime ) row ["LastPosted"] : lastRead;

			string img, imgTitle;

			try
			{
				if ( locked )
				{
					img = GetThemeContents( "ICONS", "FORUM_LOCKED" );
					imgTitle = GetText( "ICONLEGEND", "Forum_Locked" );
				}
				else if ( lastPosted > lastRead )
				{
					img = GetThemeContents( "ICONS", "FORUM_NEW" );
					imgTitle = GetText( "ICONLEGEND", "New_Posts" );
				}
				else
				{
					img = GetThemeContents( "ICONS", "FORUM" );
					imgTitle = GetText( "ICONLEGEND", "No_New_Posts" );
				}
			}
			catch ( Exception )
			{
				img = GetThemeContents( "ICONS", "FORUM" );
				imgTitle = GetText( "ICONLEGEND", "No_New_Posts" );
			}

			return String.Format( "<img src=\"{0}\" title=\"{1}\"/>", img, imgTitle );
		}

		protected void ModeratorList_ItemCommand( object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e )
		{
			//AddLoadMessage("TODO: Fix this");
			//TODO: Show moderators
		}

		private void UpdateActiveDiscussionsPanel()
		{
			expandActiveDiscussions.ImageUrl = GetCollapsiblePanelImageURL( "ActiveDiscussions", PanelSessionState.CollapsiblePanelState.Expanded );
			ActiveDiscussionTBody.Visible = ( Mession.PanelState ["ActiveDiscussions"] == PanelSessionState.CollapsiblePanelState.Expanded );
		}

		private void UpdateInformationPanel()
		{
			expandInformation.ImageUrl = GetCollapsiblePanelImageURL( "Information", PanelSessionState.CollapsiblePanelState.Expanded );
			InformationTBody.Visible = ( Mession.PanelState ["Information"] == PanelSessionState.CollapsiblePanelState.Expanded );
		}

		protected void expandActiveDiscussions_Click( object sender, ImageClickEventArgs e )
		{
			// toggle the panel visability state...
			Mession.PanelState.TogglePanelState( "ActiveDiscussions", PanelSessionState.CollapsiblePanelState.Expanded );
			BindData();
		}

		protected void expandInformation_Click( object sender, ImageClickEventArgs e )
		{
			// toggle the panel visability state...
			Mession.PanelState.TogglePanelState( "Information", PanelSessionState.CollapsiblePanelState.Expanded );
			BindData();
		}

		protected void categoryList_ItemCommand( object source, RepeaterCommandEventArgs e )
		{
			if ( (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem) && e.CommandName == "panel" )
			{
				ImageButton tmpImage = ( ImageButton ) e.Item.FindControl( "expandCategory" );
				yaf.controls.ForumList tmpForumList = ( yaf.controls.ForumList ) e.Item.FindControl( "forumList" );

                //load existing catIDs from cookie["CollapsedForumCategories"]
                List<string> catIDs = new List<string>();
                if (Request.Cookies["CollapsedForumCategories"] != null && (!string.IsNullOrEmpty(Request.Cookies["CollapsedForumCategories"].Value)))
                {
                    foreach (string catID in Request.Cookies["CollapsedForumCategories"].Value.Split(','))
                    {
                        catIDs.Add(catID);
                    }
                }

                if (Mession.PanelState["categoryPanel" + e.CommandArgument] == PanelSessionState.CollapsiblePanelState.Collapsed)
                {
                    //remove collapsed cat id
                    if (catIDs.Contains(e.CommandArgument.ToString()))
                        catIDs.Remove(e.CommandArgument.ToString());
                }
                else
                {
                    //add collapsed cat id
                    if (!catIDs.Contains(e.CommandArgument.ToString()))
                        catIDs.Add(e.CommandArgument.ToString());
                }

                //update cookie["CollapsedForumCategories"]
                HttpCookie newCookie = new HttpCookie("CollapsedForumCategories", string.Join(",", catIDs.ToArray()));
                newCookie.Expires = DateTime.Now.AddYears(1);
                Response.Cookies.Add(newCookie);

				Mession.PanelState.TogglePanelState( "categoryPanel" + e.CommandArgument, PanelSessionState.CollapsiblePanelState.Expanded );

				BindData();
			}
		}

		protected void CategoryList_ItemDataBound( object sender, RepeaterItemEventArgs e )
		{
			if ( ( e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem ) )
			{
				ImageButton tmpImage = ( ImageButton ) e.Item.FindControl( "expandCategory" );
				yaf.controls.ForumList tmpForumList = ( yaf.controls.ForumList ) e.Item.FindControl( "forumList" );

				tmpImage.ImageUrl = GetCollapsiblePanelImageURL( "categoryPanel" + tmpImage.CommandArgument, PanelSessionState.CollapsiblePanelState.Expanded );
				tmpForumList.Visible = tmpForumList.Visible = ( Mession.PanelState ["categoryPanel" + tmpImage.CommandArgument] == PanelSessionState.CollapsiblePanelState.Expanded );
			}
		}
	}
}
