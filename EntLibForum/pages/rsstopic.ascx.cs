using System;
using System.Xml;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace yaf.pages
{
	/// <summary>
	/// Summary description for rss.
	/// </summary>
	public partial class rsstopic : ForumPage
	{
		public rsstopic()
			: base( "RSSTOPIC" )
		{
		}

		protected void Page_Load( object sender, System.EventArgs e )
		{
			// Put user code to initialize the page here
			RssFeed rf = new RssFeed();

			XmlTextWriter writer = new XmlTextWriter( Response.OutputStream, System.Text.Encoding.UTF8 );

			writer.Formatting = Formatting.Indented;
			rf.WriteRSSPrologue( writer, this );

			// Usage rf.AddRSSItem(writer, "Item Title", "http://test.com", "This is a test item");
            
			switch ( Request.QueryString ["pg"] )
			{
				case "posts":
					if ( !ForumReadAccess )
						Data.AccessDenied();

					if ( Request.QueryString ["t"] != null )
					{
						using ( DataTable dt = DB.post_list( PageTopicID, 1 ) )
						{
							foreach ( DataRow row in dt.Rows )
								rf.AddRSSItem( writer, row ["Subject"].ToString(), ServerURL + Forum.GetLink( Pages.posts, "t={0}", Request.QueryString ["t"] ), row ["Message"].ToString(), Convert.ToDateTime( row ["Posted"] ).ToString( "r" ) );
						}
					}

					break;
				case "forum":
					using ( DataTable dt = DB.forum_listread( PageBoardID, PageUserID, null, null ) )
					{
						foreach ( DataRow row in dt.Rows )
						{
							if ( row ["LastTopicID"] != DBNull.Value )
							{
								rf.AddRSSItem( writer, row ["Forum"].ToString(), ServerURL + Forum.GetLink( Pages.topics, "f={0}", row ["ForumID"] ), row ["Description"].ToString() );
							}
							else
							{
								rf.AddRSSItem( writer, row ["Forum"].ToString(), ServerURL + Forum.GetLink( Pages.topics, "f={0}", row ["ForumID"] ), row ["Description"].ToString() );
							}
						}
					}
					break;
				case "topics":
					if ( !ForumReadAccess )
						Data.AccessDenied();

					if ( Request.QueryString ["f"] != null )
					{
						string tSQL = "select Topic = a.Topic, TopicID = a.TopicID, Name = b.Name, Posted = a.Posted from yaf_Topic a, yaf_Forum b where a.ForumID=" + Request.QueryString ["f"] + " and b.ForumID = a.ForumID";
						using ( DataTable dt = DB.GetData( tSQL ) )
						{
							foreach ( DataRow row in dt.Rows )
							{
								rf.AddRSSItem( writer, row ["Topic"].ToString(), ServerURL + Forum.GetLink( Pages.posts, "t={0}", row ["TopicID"] ), row ["Topic"].ToString(), Convert.ToDateTime( row ["Posted"] ).ToString( "r" ) );
							}
						}
					}

					break;
				case "active":
					object categoryIDObject = null;
					if ( ForumControl.CategoryID != 0 ) categoryIDObject = ForumControl.CategoryID;

					using ( DataTable dt = DB.topic_active( PageBoardID, PageUserID, DateTime.Now + TimeSpan.FromHours( -24 ), categoryIDObject ) )
					{
						foreach ( DataRow row in dt.Rows )
						{
							rf.AddRSSItem( writer, row ["Subject"].ToString(), ServerURL + Forum.GetLink( Pages.posts, "t={0}", row ["LinkTopicID"] ), row ["Subject"].ToString() );
						}
					}
					break;
				default:
					break;
			}

			rf.WriteRSSClosing( writer );
			writer.Flush();

			writer.Close();

			Response.ContentEncoding = System.Text.Encoding.UTF8;
			Response.ContentType = "text/xml";
			Response.Cache.SetCacheability( HttpCacheability.Public );

			Response.End();
		}

		#region Web Form Designer generated code
		override protected void OnInit( EventArgs e )
		{
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
	}
}
