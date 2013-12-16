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
using System.Text.RegularExpressions;
using System.IO;

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
                //显示时间控制
                string load_time_info = " &nbsp;<img src=\"../images/common/arrow2.gif\" alt=\"\" />&nbsp; ";
                load_time_info += String.Format( GetText( "CURRENT_TIME" ), FormatTime( DateTime.Now ) );
                //if (PageUserID == 1)//如果是游客，则显示当前时间，否则，显示上次登录时间
                {
                    load_time_info += "<span style=\"padding-left: 20px;\">";
                    load_time_info += "<img src=\"../images/common/arrow2.gif\" alt=\"\" />";
                    load_time_info += String.Format(GetText("last_visit"), FormatDateTime(Mession.LastVisit));
                    load_time_info += "    </span>";
                }

                //TimeNow.Text = String.Format( GetText( "CURRENT_TIME" ), FormatTime( DateTime.Now ) );
                //TimeLastVisit.Text = String.Format( GetText( "last_visit" ), FormatDateTime( Mession.LastVisit ) );
				//MarkAll.Text = GetText( "MARKALL" );

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

                    if (PageCategoryID != 0)
                    {
                        PageLinks.AddLink(PageCategoryName, Forum.GetLink(Pages.forum, "c={0}", PageCategoryID));
                        Welcome.Visible = false;
                        load_time_info = "";//清空div内容
                    }
                    else
                    {
                        PageLinks.Visible = false;
                    }
				}
                LoadTimeInfo = load_time_info;

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
			//CategoryList.DataSource = ds.Tables ["yaf_Category"];

			// Active users
			// Call this before forum_stats to clean up active users
			ActiveList.DataSource = DB.active_list( PageBoardID, null );

			// Latest forum posts
			// Shows the latest n number of posts on the main forum list page
			//LatestPosts.DataSource = DB.topic_latest( PageBoardID, 7, PageUserID );

			// Forum statistics
            this.Page.ClientScript.RegisterStartupScript(GetType(), "", "SetGloabInfo('" + PageBoardID + "', '" + PageUserID + "')", true);
			string key = string.Format( "BoardStats.{0}", PageBoardID );
			DataRow stats = ( DataRow ) Cache [key];
			if ( stats == null )
			{
				stats = DB.board_poststats( PageBoardID );
				Cache.Insert( key, stats, null, DateTime.Now.AddMinutes( 15 ), TimeSpan.Zero );
			}

			Stats.Text = String.Format( GetText( "stats_posts" ), stats ["posts"], stats ["topics"], stats ["forums"] );
			Stats.Text += "<br/>";

            //屏蔽掉了：最后由 {1} 发表于 {0}.
            //if (!stats.IsNull("LastPost"))
            //{
            //    Stats.Text += String.Format(GetText("stats_lastpost"),
            //        FormatDateTimeTopic((DateTime)stats["LastPost"]),
            //        String.Format("<a href=\"{0}\">{1}</a>", Forum.GetLink(Pages.profile, "u={0}", stats["LastUserID"]), Server.HtmlEncode(stats["LastUser"].ToString()))
            //    );
            //    Stats.Text += "<br/>";
            //}

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
            HotContentGenerate();
        }
        // add by zhiweiw 20131206
        private void HotContentGenerate()
        {
            lblHotInfo.Text = "";
            //
            lblHotInfo.Text += "<div class='main cl forumhot'>";
            lblHotInfo.Text += "<table width='100%' cellspacing='0' cellpadding='0'>";
            lblHotInfo.Text += "<tbody><tr> <td width='360px'>";
            // modify by zhiweiew 
            lblHotInfo.Text += "<div class='title_bar xg2'>最新图片</div>";
            lblHotInfo.Text += "<div class='flash'>";
            lblHotInfo.Text += "<div id='KinSlideshow'>";
            lblHotInfo.Text += " <script type='text/javascript' src='script/jquery.KinSlideshow-1.2.1.min.js'></script>";
            lblHotInfo.Text += GetImageInfo2();
            lblHotInfo.Text += "</div></div>";
            lblHotInfo.Text += "</td>";
            // modify by zhiweiw
            lblHotInfo.Text += "<td width='400px'> <div class='title_bar xg2'>";
            lblHotInfo.Text += "<ul id='tabswi1_A' class='tab_forumhot'>";
            lblHotInfo.Text += "<li class='switchNavItem' index='2' id='tab_li_1'><a href='javascript:;'  onmousemove='tabselect(1)'>最新贴吧</a></li>";
            lblHotInfo.Text += "<li class='switchNavItem' index='2' id='tab_li_2'><a href='javascript:;'  onmousemove='tabselect(2)'>热门帖子</a></li>";
            lblHotInfo.Text += "<li class='switchNavItem' index='2' id='tab_li_3'><a href='javascript:;'  onmousemove='tabselect(3)'>推荐帖子</a></li>";
            lblHotInfo.Text += "</ul></div>";
            lblHotInfo.Text += "<div id='tabswi1_B' class='pd cl'>";
            lblHotInfo.Text += "<div class='newHotB' name='hot_layer_1' id='hot_layer_1'  style='display:none'>";
            lblHotInfo.Text += "<ul class='hotlist'>";
            lblHotInfo.Text += GetLeastInfo();
            lblHotInfo.Text += "</div>";
            lblHotInfo.Text += "<div class='newHotB' name='hot_layer_2' id='hot_layer_2'  style='display:none'>";

            lblHotInfo.Text += "<ul class='hotlist'>";
            lblHotInfo.Text += GetHotInfo();

            lblHotInfo.Text += "</div>";
            lblHotInfo.Text += "<div class='newHotB' name='hot_layer_3' id='hot_layer_3'  style='display:none'>";
            lblHotInfo.Text += "<ul class='hotlist'>";
            lblHotInfo.Text += GetGroomInfo();
            //动态加载
            lblHotInfo.Text += "</div>";
            lblHotInfo.Text += "</div>";
            lblHotInfo.Text += "</td>";
            //// add by zhiweiw
            lblHotInfo.Text += "<td>";
            lblHotInfo.Text += "<div class='title_bar xg2'>文谷之星</div>";
            //lblHotInfo.Text += "<div style='width:225px;height:228px; border-left:1.5px dashed #000;border-color:#ff0000; overflow:hidden; padding-top:10px;'>";
            lblHotInfo.Text += "<div style='width:225px;height:228px; overflow:hidden; padding-top:10px;'>";
            lblHotInfo.Text += GetHotUser();

            lblHotInfo.Text += "</div>";
            lblHotInfo.Text += "</div>";

            lblHotInfo.Text += "</td>";

            // end add by zhiweiwe 
            lblHotInfo.Text += "</tr>";
            lblHotInfo.Text += "</tbody>";
            lblHotInfo.Text += "</table>";

        }
        protected string GetImageInfo2()
        {
            int count = 0;
            DataTable leastInfo = DB.topic_message_image(PageBoardID);
            string return_str = null;
            int rowcount = leastInfo.Columns.Count;
            int zcount = 0;
            foreach (DataRow dr in leastInfo.Rows)
            {
                zcount++;
                if (count <= 6)
                {
                    //获得文件名
                    string message = dr["Message"].ToString();
                    string username = dr["name"].ToString();
                    string title = dr["topic"].ToString();
                    string topicId = dr["TopicID"].ToString();
                    string path = "";
                    string fileName = "";
                    GetFilePathAndFileName(ref path, ref fileName, message, username);
                    if (path != null && fileName != null)
                    {
                        string FilePath = Server.MapPath("./") + path;
                        if (File.Exists(FilePath)) //判断当前JPG文件是否存在
                        {
                            string rarpath = Server.MapPath("./") + "cash/" + username + "/R_" + fileName;
                            string rarfolorpath = Server.MapPath("./") + "cash/" + username;
                            if (!File.Exists(rarpath))
                            {
                                Directory.CreateDirectory(rarfolorpath);
                                ImageUtility.ThumbAsJPG(FilePath, rarpath, 360, 240);
                            }
                            return_str += "<a href='default.aspx?g=posts&t=" + topicId + "' target='_blank'><img src='" + "cash/" + username + "/R_" + fileName + "' alt = '" + title + "' width='360' height='240' /></a>"; 
                        }
                    }
                }
                else
                {
                    break;
                }
            }
            return (return_str);
        }
        protected string GetImageInfo()
        {
            int count = 0;
            DataTable leastInfo = DB.topic_message_image(PageBoardID);
            string return_str = null;
            return_str = " var hotimagesarray = eval('[";
            //lblHotInfo.Text += " var hotimagesarray = eval('[{title:\"测试图片2\",img:\"cache/rotatethumbnail/r_629191002125.jpg\",url:\"showtopic-4.aspx\"}]');";
            int rowcount = leastInfo.Columns.Count;
            int zcount = 0;
            foreach (DataRow dr in leastInfo.Rows)
            {
                zcount++;
                if (count <= 5)
                {
                    //获得文件名
                    string message = dr["Message"].ToString();
                    string username = dr["name"].ToString();
                    string title = dr["topic"].ToString();
                    string topicId = dr["TopicID"].ToString();
                    string path = "";
                    string fileName = "";
                    GetFilePathAndFileName(ref path, ref fileName, message, username);
                    if (path != null && fileName != null)
                    {
                        string FilePath = Server.MapPath("./") + path;
                        if (File.Exists(FilePath)) //判断当前JPG文件是否存在
                        {
                            string rarpath = Server.MapPath("./") + "cash/" + username + "/R_" + fileName;
                            //string rarpath2 = Server.MapPath("./") + "cash/" + username + "/R_" + fileName;
                            string rarfolorpath = Server.MapPath("./") + "cash/" + username;
                            if (!File.Exists(rarpath))
                            {
                                Directory.CreateDirectory(rarfolorpath);
                                ImageUtility.ThumbAsJPG(FilePath, rarpath, 360, 240);
                                //ImageUtility.AddTextWatermarkAsJPG(rarpath1, title, rarpath2, ImageUtility.MarkPosition.MP_Bottom_Center);
                            }
                            if (count == 5 || zcount == rowcount)
                            {
                                return_str += "{title:\"" + title + "\",img:\"" + "cash/" + username + "/R_" + fileName + "\",url:\"default.aspx?g=posts&t=" + topicId + "\"}";
                            }
                            else
                            {
                                return_str += "{title:\"" + title + "\",img:\"" + "cash/" + username + "/R_" + fileName + "\",url:\"default.aspx?g=posts&t=" + topicId + "\"},";
                            } 
                        }
                    }
                }
                else
                {
                    break;
                }
            }
            return_str += "]');";
            return (return_str);
        }
        private void GetFilePathAndFileName(ref string path, ref string name, string message, string username)
        {

           //path = Regex.Replace(message, @"(?i)(<img[^>]*?src=(['""\s]?))((useruploadfiles/)?([^/\\]+[/\\])+?)([^\.]+\.[^'""]+)\2([^>]*?>)", @"$1file://\\Server\public\soft\$6$2$7");
            int firstPos = message.IndexOf("useruploadfiles/" + username + "/image/");
            string lower = message.ToLower();
            //{ "bmp", "gif", "jpeg", "jpg", "png" }
            int secondposjpg = lower.IndexOf(".jpg");
            int seconfposgif = lower.IndexOf(".gif");
            int seconfposjpeg = lower.IndexOf(".jpeg");
            int seconfposbmp = lower.IndexOf(".bmp");
            int secondPospng = lower.IndexOf(".png");
            int small_pos = 0x7FFFFFFF;
            int imglength = 0;
            if (secondposjpg != -1 && small_pos > secondposjpg)
            {
                small_pos = secondposjpg;
                imglength = 4;
            }
            if(seconfposgif != -1 && small_pos > seconfposgif)
            {
                 small_pos = seconfposgif;
                 imglength = 4;
            }
            if (seconfposjpeg != -1 && small_pos > seconfposjpeg)
            {
                small_pos = seconfposjpeg;
                imglength = 5;
            }
            if (seconfposbmp != -1 && small_pos > seconfposbmp)
            {
                small_pos = seconfposbmp;
                imglength = 4;
            }
            if (secondPospng != -1 && small_pos > secondPospng)
            {
                small_pos = secondPospng;
                imglength = 4;
            }
            if (small_pos != 0x7FFFFFFF)
            {
                path = message.Substring(firstPos, small_pos - firstPos + imglength);
                path = System.Web.HttpUtility.UrlDecode(path, System.Text.Encoding.UTF8);
                name= Path.GetFileName(path);
                //name = path.Substring(path.LastIndexOf("/"), path.Length - path.LastIndexOf("/"));
                //name = name.Trim('/');
                int j = 0;
            }
            else
            {
                path = null;
                name = null;
            }
        }
        protected string GetLeastInfo()
        {
            DataTable leastInfo = DB.topic_list_least(PageBoardID);
            string return_str = null;
            int count = 0;
            foreach (DataRow dr in leastInfo.Rows)
            {
                count++;
                return_str += "<li><a href='/default.aspx?g=forum&f=" + dr["forumId"].ToString() + "' target='_blank'>";
                return_str += "【" + dr["smallcate"].ToString() + "】</a><a href='/default.aspx?g=posts&t=" + dr["TopicID"].ToString() + "' target='_blank' class='xg2'>";
                return_str += dr["Topic"].ToString() + "</a>---发布时间：" + dr["Posted"].ToString() + "</li>";
                if(10 == count)
                {
                    break;
                }
            }
            return (return_str);
        }
        protected string GetHotInfo()
        {
            DataTable leastInfo = DB.topic_list_hot(PageBoardID);
            string return_str = null;
            int count = 0;
            foreach (DataRow dr in leastInfo.Rows)
            {
                count++;
                return_str += "<li><a href='/default.aspx?g=forum&f=" + dr["forumId"].ToString() + "' target='_blank'>";
                return_str += "【" + dr["smallcate"].ToString() + "】</a><a href='/default.aspx?g=posts&t=" + dr["TopicID"].ToString() + "' target='_blank' class='xg2'>";
                return_str += dr["Topic"].ToString() + "</a>---发布时间：" + dr["Posted"].ToString() + "</li>";
                if (10 == count)
                {
                    break;
                }
            }
            return (return_str);
        }
        protected string GetGroomInfo()
        {
            DataTable leastInfo = DB.topic_list_groom(PageBoardID);
            string return_str = null;
            int count = 0;
            foreach (DataRow dr in leastInfo.Rows)
            {
                count++;
                return_str += "<li><a href='/default.aspx?g=forum&f=" + dr["forumId"].ToString() + "' target='_blank'>";
                return_str += "【" + dr["smallcate"].ToString() + "】</a><a href='/default.aspx?g=posts&t=" + dr["TopicID"].ToString() + "' target='_blank' class='xg2'>";
                return_str += dr["Topic"].ToString() + "</a>---发布时间：" + dr["Posted"].ToString() + "</li>";
                if (10 == count)
                {
                    break;
                }
            }
            return (return_str);
        }
        protected string GetHotUser()
        {
            DataTable leastInfo = DB.user_list_hot(PageBoardID);
            string return_str = null;
            foreach (DataRow dr in leastInfo.Rows)
            {
                return_str += "<div style='width:50%;float:left;margin:0 0 0 5px;padding-left:8px;height: 23px;line-height: 23px;'>";
                //return_str += "<li>发帖总数： <em> " + dr["count"].ToString() + "</em>";
                if (dr["avatar"].ToString() == "")
                {
                    return_str += "<img src='/images/noavatar_small.gif' width='16' height='16'>";
                }
                else
                {
                    return_str += "<img src='" + dr["avatar"].ToString() + "' width='16' height='16'>";
                }

                return_str += "&nbsp;&nbsp;<a href='/default.aspx?g=profile&u=" + dr["userid"].ToString() + "' target='_blank'>" + dr["name"].ToString() + "</a>";

                return_str += "</div>";
                return_str += "<div style='width:40%;float:left;margin:0 0 0 5px;'>";
                return_str += "发帖总数:" + dr["count"].ToString();
                return_str += "</div>";
                //return_str += "<hr style='border: 1px dashed #ccc; width: 100%; height: 1px;' />";
            }
            return (return_str);
        }
        // end add by zhiweiw 
        protected string FormatLastPost(System.Data.DataRow row)
        {
            if (!row.IsNull("LastPosted"))
            {
                string minipost;
                if (DateTime.Parse(row["LastPosted"].ToString()) > Mession.LastVisit)
                    minipost = GetThemeContents("ICONS", "ICON_NEWEST");
                else
                    minipost = GetThemeContents("ICONS", "ICON_LATEST");

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
			//expandActiveDiscussions.ImageUrl = GetCollapsiblePanelImageURL( "ActiveDiscussions", PanelSessionState.CollapsiblePanelState.Expanded );
			//ActiveDiscussionTBody.Visible = ( Mession.PanelState ["ActiveDiscussions"] == PanelSessionState.CollapsiblePanelState.Expanded );
		}

		private void UpdateInformationPanel()
		{
			//expandInformation.ImageUrl = GetCollapsiblePanelImageURL( "Information", PanelSessionState.CollapsiblePanelState.Expanded );
			//InformationTBody.Visible = ( Mession.PanelState ["Information"] == PanelSessionState.CollapsiblePanelState.Expanded );
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
            // delete by aixj  删除掉点击事件
			//Mession.PanelState.TogglePanelState( "Information", PanelSessionState.CollapsiblePanelState.Expanded );
			//BindData();
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

        //--------------------------------
        /// <summary>
        /// 裁切字符串（中文按照两个字符计算）
        /// </summary>
        /// <param name="str">旧字符串</param>
        /// <param name="len">新字符串长度</param>
        /// <remarks>
        /// <para>注意：<ol>
        /// <li>若字符串被截断则会在末尾追加“...”，反之则直接返回原始字符串。</li>
        /// <li>参数 <paramref name="HtmlEnable"/> 为 false 时会先调用<see cref="uoLib.Common.Functions.HtmlFilter"/>过滤掉 Html 标签再进行裁切。</li>
        /// <li>中文按照两个字符计算。若指定长度位置恰好只获取半个中文字符，则会将其补全，如下面的例子：<br/>
        /// <code><![CDATA[
        /// string str = "感谢使用uoLib。";
        /// string A = CutStr(str,4);   // A = "感谢..."
        /// string B = CutStr(str,5);   // B = "感谢使..."
        /// ]]></code></li>
        /// </ol>
        /// </para>
        /// </remarks>
        public static string CutStr(string str, int len)
        {
            if (str == null || str.Length == 0 || len <= 0) { return string.Empty; }

            int l = str.Length;

            #region 计算长度
            int clen = 0;//当前长度 
            while (clen < len && clen < l)
            {
                //每遇到一个中文，则将目标长度减一。
                if ((int)str[clen] > 128) 
                {
                    len--;
                }
                clen++;
            }
            #endregion

            if (clen < l)
            {
                return str.Substring(0, clen) + "...";
            }
            else
            {
                return str;
            }
        }
        
        /// <summary>
        /// 获取字符串长度。与string.Length不同的是，该方法将中文作 2 个字符计算。
        /// </summary>
        /// <param name="str">目标字符串</param>
        /// <returns></returns>
        public static int GetLength(string str)
        {
            if (str == null || str.Length == 0) { return 0; }

            int l = str.Length;
            int realLen = l;

            #region 计算长度
            int clen = 0;//当前长度 
            while (clen < l)
            {
                //每遇到一个中文，则将实际长度加一。
                if ((int)str[clen] > 128) { realLen++; }
                clen++;
            }
            #endregion

            return realLen;
        }
        //--------------------------------------------
	}
}
