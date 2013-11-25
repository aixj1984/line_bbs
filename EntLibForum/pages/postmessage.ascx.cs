using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Text.RegularExpressions;

namespace yaf.pages
{
	/// <summary>
	/// Summary description for postmessage.
	/// </summary>
	public partial class postmessage : ForumPage
	{
		protected yaf.editor.ForumEditor Message;
		protected System.Web.UI.WebControls.Label NoEditSubject;

		public postmessage()
			: base( "POSTMESSAGE" )
		{

		}

		override protected void OnInit( System.EventArgs e )
		{
			// get the forum editor based on the settings
			Message = yaf.editor.EditorHelper.CreateEditorFromType( BoardSettings.ForumEditor );
			EditorLine.Controls.Add( Message );

			base.OnInit( e );
		}

		protected void Page_Load( object sender, System.EventArgs e )
		{
            ///////////////////////////////////////////////
            /// Updated by EntLib.com
            /// 增加回车自动触发按钮的Click 事件
            /// 2008-5-9
            snvTxt1.Attributes.Add("onkeydown", "if(event.keyCode==13){document.all." + PostReply.ClientID + ".focus();event.keyCode=13;return true;}");
            ///////////////////////////////////////////////

			DataRow currentRow = null;

			if ( Request.QueryString ["q"] != null )
			{
				using ( DataTable dt = DB.message_list( Request.QueryString ["q"] ) )
					currentRow = dt.Rows [0];

				if ( Convert.ToInt32( currentRow ["TopicID"] ) != PageTopicID )
					Data.AccessDenied();

				if ( !CanQuotePostCheck( currentRow ) )
					Data.AccessDenied();
			}
			else if ( Request.QueryString ["m"] != null )
			{
				using ( DataTable dt = DB.message_list( Request.QueryString ["m"] ) )
					currentRow = dt.Rows [0];

				if ( !CanEditPostCheck( currentRow ) )
					Data.AccessDenied();
			}

			if ( PageForumID == 0 )
				Data.AccessDenied();
			if ( Request ["t"] == null && !ForumPostAccess )
				Data.AccessDenied();
			if ( Request ["t"] != null && !ForumReplyAccess )
				Data.AccessDenied();

			//Message.EnableRTE = BoardSettings.AllowRichEdit;
			Message.StyleSheet = this.ThemeFile( "theme.css" );
			Message.BaseDir = Data.ForumRoot + "editors";

			Title.Text = GetText( "NEWTOPIC" );
			PollExpire.Attributes.Add( "style", "width:50px" );

			if ( !IsPostBack )
			{
				Priority.Items.Add( new ListItem( GetText( "normal" ), "0" ) );
				Priority.Items.Add( new ListItem( GetText( "sticky" ), "1" ) );
				Priority.Items.Add( new ListItem( GetText( "announcement" ), "2" ) );
				Priority.SelectedIndex = 0;

				Preview.Text = GetText( "preview" );
				PostReply.Text = GetText( "Save" );
				Cancel.Text = GetText( "Cancel" );
				CreatePoll.Text = GetText( "createpoll" );

				PriorityRow.Visible = ForumPriorityAccess;
				CreatePollRow.Visible = Request.QueryString ["t"] == null && ForumPollAccess;

				if ( ForumControl.LockedForum == 0 )
				{
					PageLinks.AddLink( BoardSettings.Name, Forum.GetLink( Pages.forum ) );
					PageLinks.AddLink( PageCategoryName, Forum.GetLink( Pages.forum, "c={0}", PageCategoryID ) );
				}
				PageLinks.AddForumLinks( PageForumID );

				if ( Request.QueryString ["t"] != null )
				{
					// new post...
					DataRow topic = DB.topic_info( Request.QueryString ["t"] );
					if ( ( ( int ) topic ["Flags"] & ( int ) TopicFlags.Locked ) == ( int ) TopicFlags.Locked )
						Response.Redirect( Request.UrlReferrer.ToString() );
					SubjectRow.Visible = false;
					Title.Text = GetText( "reply" );

				    LastPostsIFrame.Visible = true;
				    LastPostsIFrame.Attributes.Add( "src", "framehelper.aspx?g=lastposts&t=" + Request.QueryString ["t"] );
				}

				if ( Request.QueryString ["q"] != null )
				{
					// reply to post...
					bool isHtml = currentRow ["Message"].ToString().IndexOf( '<' ) >= 0;

					string tmpMessage = currentRow ["Message"].ToString();

					if ( BoardSettings.RemoveNestedQuotes )
					{
						RegexOptions m_options = RegexOptions.IgnoreCase | RegexOptions.Multiline | RegexOptions.Singleline;
						Regex quote = new Regex( @"\[quote(\=.*)?\](.*?)\[/quote\]", m_options );
						// remove quotes from old messages
						tmpMessage = quote.Replace( tmpMessage, "" );
					}

					Message.Text = String.Format( "[quote={0}]{1}[/quote]", currentRow ["username"], tmpMessage );
				}
				else if ( Request.QueryString ["m"] != null )
				{
					// edit message...
					string body = currentRow ["message"].ToString();
					Message.Text = body;
					Title.Text = GetText( "EDIT" );

					Subject.Text = Server.HtmlDecode( Convert.ToString( currentRow ["Topic"] ) );

					if ( ( Convert.ToInt32( currentRow ["TopicOwnerID"] ) == Convert.ToInt32( currentRow ["UserID"] ) ) || ForumModeratorAccess )
					{
						// allow editing of the topic subject
						Subject.Enabled = true;
					}
					else
					{
						// disable the subject
						Subject.Enabled = false;
					}

					CreatePollRow.Visible = false;
					Priority.SelectedItem.Selected = false;
					Priority.Items.FindByValue( currentRow ["Priority"].ToString() ).Selected = true;
				}

				From.Text = PageUserName;
				if ( User.IsAuthenticated )
					FromRow.Visible = false;

                SerialNumber1.Create();
			}
		}

		private bool CanEditPostCheck( DataRow message )
		{
			bool postLocked = false;

			if ( !IsAdmin && BoardSettings.LockPosts > 0 )
			{
				DateTime edited = ( DateTime ) message ["Edited"];

				if ( edited.AddDays( BoardSettings.LockPosts ) < DateTime.Now )
					postLocked = true;
			}

			DataRow forumInfo, topicInfo;

			// get topic and forum information
			topicInfo = DB.topic_info( PageTopicID );
			using ( DataTable dt = DB.forum_list( PageBoardID, PageForumID ) )
				forumInfo = dt.Rows [0];

			return !postLocked && ( ( int ) forumInfo ["Flags"] & ( int ) ForumFlags.Locked ) != ( int ) ForumFlags.Locked && ( ( int ) topicInfo ["Flags"] & ( int ) TopicFlags.Locked ) != ( int ) TopicFlags.Locked && ( ( int ) message ["UserID"] == PageUserID || ForumModeratorAccess ) && ForumEditAccess;
		}

		private bool CanQuotePostCheck( DataRow message )
		{
			DataRow forumInfo, topicInfo;

			// get topic and forum information
			topicInfo = DB.topic_info( PageTopicID );
			using ( DataTable dt = DB.forum_list( PageBoardID, PageForumID ) )
				forumInfo = dt.Rows [0];

			return ( ( int ) forumInfo ["Flags"] & ( int ) ForumFlags.Locked ) != ( int ) ForumFlags.Locked && ( ( int ) topicInfo ["Flags"] & ( int ) TopicFlags.Locked ) != ( int ) TopicFlags.Locked && ForumReplyAccess;
		}

		protected void PostReply_Click( object sender, System.EventArgs e )
		{
            // 去除验证码
            //if (!SerialNumber1.CheckSN(snvTxt1.Text))
            //{
            //    AddLoadMessage("请输入正确的验证码!");
            //    SerialNumber1.Create();
            //    return;
            //}

			if ( SubjectRow.Visible && Subject.Text.Length <= 0 )
			{
				AddLoadMessage( GetText( "need_subject" ) );
				return;
			}

            ///////////////////////////////////////////////////
            ///// updated by http://www.EntLib.com
            //// date 2008.9.8
            //////////////////////////////////////////////////
            if (Message.Text.Trim().Length < 5)
            {
                AddLoadMessage("请输入回复内容（必须大于5个字符）！");
                return;
            }

            ///////////////////////////////////////////////////

			if ( PollRow1.Visible )
			{
				if ( Question.Text.Trim().Length == 0 )
				{
					AddLoadMessage( GetText( "NEED_QUESTION" ) );
					return;
				}

				string p1 = PollChoice1.Text.Trim();
				string p2 = PollChoice2.Text.Trim();
				if ( p1.Length == 0 || p2.Length == 0 )
				{
					AddLoadMessage( GetText( "NEED_CHOICES" ) );
					return;
				}
			}


			// see if there is a post delay
			if ( !( IsAdmin || IsModerator ) && BoardSettings.PostFloodDelay > 0 )
			{
				// see if they've past that delay point
				if ( Mession.LastPost > DateTime.Now.AddSeconds( -BoardSettings.PostFloodDelay ) && Request.QueryString ["m"] == null )
				{
					AddLoadMessage( String.Format( GetText( "wait" ), ( Mession.LastPost - DateTime.Now.AddSeconds( -BoardSettings.PostFloodDelay ) ).Seconds ) );
					return;
				}
			}

			long TopicID;
			long nMessageID = 0;
			object replyTo = null;

			if ( Request.QueryString ["q"] != null )
				replyTo = int.Parse( Request.QueryString ["q"] );
			else
				// Let save procedure find first post
				replyTo = -1;

			string msg = Message.Text;

			Mession.LastPost = DateTime.Now;

			if ( Request.QueryString ["t"] != null )
			{
				if ( !ForumReplyAccess )
					Data.AccessDenied();

				TopicID = long.Parse( Request.QueryString ["t"] );
				// make message flags
				MessageFlags tFlags = new MessageFlags();

				tFlags.IsHTML = Message.UsesHTML;
				tFlags.IsBBCode = Message.UsesBBCode;

				if ( !DB.message_save( TopicID, PageUserID, msg, User.IsAuthenticated ? null : From.Text, Request.UserHostAddress, null, replyTo, tFlags.BitValue, ref nMessageID ) )
					TopicID = 0;
			}
			else if ( Request.QueryString ["m"] != null )
			{
				if ( !ForumEditAccess )
					Data.AccessDenied();

				string SubjectSave = "";
				if ( Subject.Enabled ) SubjectSave = Server.HtmlEncode( Subject.Text );

				// make message flags
				MessageFlags tFlags = new MessageFlags();

				tFlags.IsHTML = Message.UsesHTML;
				tFlags.IsBBCode = Message.UsesBBCode;

				DB.message_update( Request.QueryString ["m"], Priority.SelectedValue, msg, SubjectSave, tFlags.BitValue );
				TopicID = PageTopicID;
				nMessageID = long.Parse( Request.QueryString ["m"] );
			}
			else
			{
				if ( !ForumPostAccess )
					Data.AccessDenied();

				object PollID = null;

				if ( PollRow1.Visible )
				{

					int daysPollExpire = 0;
					object datePollExpire = null;

					try
					{
						daysPollExpire = Convert.ToInt32( PollExpire.Text.Trim() );
					}
					catch
					{

					}

					if ( daysPollExpire > 0 )
					{
						datePollExpire = DateTime.Now.AddDays( daysPollExpire );
					}

					PollID = DB.poll_save( Question.Text,
						PollChoice1.Text,
						PollChoice2.Text,
						PollChoice3.Text,
						PollChoice4.Text,
						PollChoice5.Text,
						PollChoice6.Text,
						PollChoice7.Text,
						PollChoice8.Text,
						PollChoice9.Text,
						datePollExpire );
				}

				// make message flags
				MessageFlags tFlags = new MessageFlags();

				tFlags.IsHTML = Message.UsesHTML;
				tFlags.IsBBCode = Message.UsesBBCode;

				string subject = Server.HtmlEncode( Subject.Text );
				TopicID = DB.topic_save( PageForumID, subject, msg, PageUserID, Priority.SelectedValue, PollID, User.IsAuthenticated ? null : From.Text, Request.UserHostAddress, null, tFlags.BitValue, ref nMessageID );
			}

			// Check if message is approved
			bool bApproved = false;
			using ( DataTable dt = DB.message_list( nMessageID ) )
				foreach ( DataRow row in dt.Rows )
					bApproved = ( ( int ) row ["Flags"] & 16 ) == 16;

			// Create notification emails
			if ( bApproved )
			{
				Utils.CreateWatchEmail( this, nMessageID );
				Forum.Redirect( Pages.posts, "m={0}&#{0}", nMessageID );
			}
			else
			{
				// Tell user that his message will have to be approved by a moderator
				//AddLoadMessage("Since you posted to a moderated forum, a forum moderator must approve your post before it will become visible.");
				string url = Forum.GetLink( Pages.topics, "f={0}", PageForumID );
				Forum.Redirect( Pages.info, "i=1&url={0}", Server.UrlEncode( url ) );
			}
		}

		protected void CreatePoll_Click( object sender, System.EventArgs e )
		{
			CreatePollRow.Visible = false;
			PollRow1.Visible = true;
			PollRow2.Visible = true;
			PollRow3.Visible = true;
			PollRow4.Visible = true;
			PollRow5.Visible = true;
			PollRow6.Visible = true;
			PollRow7.Visible = true;
			PollRow8.Visible = true;
			PollRow9.Visible = true;
			PollRow10.Visible = true;
			PollRowExpire.Visible = true;
		}

		protected void Cancel_Click( object sender, System.EventArgs e )
		{
			if ( Request.QueryString ["t"] != null || Request.QueryString ["m"] != null )
			{
				// reply to existing topic or editing of existing topic
				Forum.Redirect( Pages.posts, "t={0}", PageTopicID );
			}
			else
			{
				// new topic -- cancel back to forum
				Forum.Redirect( Pages.topics, "f={0}", PageForumID );
			}
		}

		protected void Preview_Click( object sender, System.EventArgs e )
		{
			PreviewRow.Visible = true;

			MessageFlags tFlags = new MessageFlags();
			tFlags.IsHTML = Message.UsesHTML;
			tFlags.IsBBCode = Message.UsesBBCode;

			string body = FormatMsg.FormatMessage( this, Message.Text, tFlags );

			using ( DataTable dt = DB.user_list( PageBoardID, PageUserID, true ) )
			{
				if ( !dt.Rows [0].IsNull( "Signature" ) )
					body += "<br/><hr noshade/>" + FormatMsg.FormatMessage( this, dt.Rows [0] ["Signature"].ToString(), new MessageFlags() );
			}

			PreviewCell.InnerHtml = body;
		}

		protected string FormatBody( object o )
		{
			DataRowView row = ( DataRowView ) o;
			string html = FormatMsg.FormatMessage( this, row ["Message"].ToString(), new MessageFlags( Convert.ToInt32( row ["Flags"] ) ) );

			string messageSignature = row ["Signature"].ToString();

			if ( messageSignature != string.Empty )
			{
				MessageFlags flags = new MessageFlags();
				flags.IsHTML = false;
				messageSignature = FormatMsg.FormatMessage( this, messageSignature, flags );
				html += "<br/><hr noshade/>" + messageSignature;
			}

			return html;
		}
	}
}
