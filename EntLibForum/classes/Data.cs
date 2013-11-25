using System;
using System.Data;
using System.Web;

namespace yaf
{
	public enum AuthType
	{
		Guest,
		Forms,
		Windows,
		Rainbow,
		DotNetNuke,
		DotNetNuke3,
		Portal,
		Custom
	};

	public enum SEARCH_FIELD
	{
		sfMESSAGE = 0,
		sfUSER_NAME = 1
	}

	public enum SEARCH_WHAT
	{
		sfALL_WORDS = 0,
		sfANY_WORDS = 1,
		sfEXACT = 2
	}

	public enum ForumFlags : int
	{
		Locked = 1,
		Hidden = 2,
		IsTest = 4,
		Moderated = 8
	}

	public enum GroupFlags : int
	{
		IsAdmin = 1,
		IsGuest = 2,
		IsStart = 4,
		IsModerator = 8
	}

	public enum AccessFlags : int
	{
		ReadAccess = 1,
		PostAccess = 2,
		ReplyAccess = 4,
		PriorityAccess = 8,
		PollAccess = 16,
		VoteAccess = 32,
		ModeratorAccess = 64,
		EditAccess = 128,
		DeleteAccess = 256,
		UploadAccess = 512
	}

	public enum TopicFlags : int
	{
		Locked = 1,
		Deleted = 8
	}

	public enum UserFlags : int
	{
		IsHostAdmin = 1,
		Approved = 2
	}

	public enum RankFlags : int
	{
		IsStart = 1,
		IsLadder = 2
	}

	public enum EventLogTypes : int
	{
		Error = 0,
		Warning = 1,
		Information = 2
	}

	/// <summary>
	/// Summary description for Data.
	/// </summary>
	public class Data
	{
		public static string ForumRoot
		{
			get
			{
				try
				{
					string path = HttpContext.Current.Request.ApplicationPath;
					if ( !path.EndsWith( "/" ) ) path += "/";

					if (Config.Root != null)
					{	
						// use specified root
						path = Config.Root;
						if (path[0] != '/') path = path.Insert(0,"/");
						
					}

					if ( !path.EndsWith( "/" ) ) path += "/";

					return path;
				}
				catch ( Exception )
				{
					return "/";
				}
			}
		}

		public static AuthType GetAuthType
		{
			get
			{
                if ( Config.IsCustom )
				{
					return AuthType.Custom;
				}

				Type secType = System.Web.HttpContext.Current.User.Identity.GetType();

				if ( secType == typeof( System.Web.Security.FormsIdentity ) )
					return AuthType.Forms;
				else if ( secType == typeof( System.Security.Principal.WindowsIdentity ) )
					return AuthType.Windows;
				else if ( secType == typeof( System.Security.Principal.GenericIdentity ) )
					return AuthType.Guest;
				else
#if DEBUG
					throw new Exception(string.Format("Unknown security: {0}",secType));
#else
					return AuthType.Guest;
#endif
			}
		}

		public static void AccessDenied()
		{
			Forum.Redirect( Pages.info, "i=4" );
		}

		public static DataTable TimeZones()
		{
			using ( DataTable dt = new DataTable( "TimeZone" ) )
			{
				dt.Columns.Add( "Value", Type.GetType( "System.Int32" ) );
				dt.Columns.Add( "Name", Type.GetType( "System.String" ) );

                //dt.Rows.Add( new object [] { -720, "(GMT - 12:00) Enitwetok, Kwajalien" } );
                //dt.Rows.Add( new object [] { -660, "(GMT - 11:00) Midway Island, Samoa" } );
                //dt.Rows.Add( new object [] { -600, "(GMT - 10:00) Hawaii" } );
                //dt.Rows.Add( new object [] { -540, "(GMT - 9:00) Alaska" } );
                //dt.Rows.Add( new object [] { -480, "(GMT - 8:00) Pacific Time (US & Canada)" } );
                //dt.Rows.Add( new object [] { -420, "(GMT - 7:00) Mountain Time (US & Canada)" } );
                //dt.Rows.Add( new object [] { -360, "(GMT - 6:00) Central Time (US & Canada), Mexico City" } );
                //dt.Rows.Add( new object [] { -300, "(GMT - 5:00) Eastern Time (US & Canada), Bogota, Lima, Quito" } );
                //dt.Rows.Add( new object [] { -240, "(GMT - 4:00) Atlantic Time (Canada), Caracas, La Paz" } );
                //dt.Rows.Add( new object [] { -210, "(GMT - 3:30) Newfoundland" } );
                //dt.Rows.Add( new object [] { -180, "(GMT - 3:00) Brazil, Buenos Aires, Georgetown, Falkland Is." } );
                //dt.Rows.Add( new object [] { -120, "(GMT - 2:00) Mid-Atlantic, Ascention Is., St Helena" } );
                //dt.Rows.Add( new object [] { -60, "(GMT - 1:00) Azores, Cape Verde Islands" } );
                //dt.Rows.Add( new object [] { 0, "(GMT) Casablanca, Dublin, Edinburgh, London, Lisbon, Monrovia" } );
                //dt.Rows.Add( new object [] { 60, "(GMT + 1:00) Berlin, Brussels, Kristiansund, Madrid, Paris, Rome, Warsaw" } );
                //dt.Rows.Add( new object [] { 120, "(GMT + 2:00) Kaliningrad, South Africa" } );
                //dt.Rows.Add( new object [] { 180, "(GMT + 3:00) Baghdad, Riyadh, Moscow, Nairobi" } );
                //dt.Rows.Add( new object [] { 210, "(GMT + 3:30) Tehran" } );
                //dt.Rows.Add( new object [] { 240, "(GMT + 4:00) Adu Dhabi, Baku, Muscat, Tbilisi" } );
                //dt.Rows.Add( new object [] { 270, "(GMT + 4:30) Kabul" } );
                //dt.Rows.Add( new object [] { 300, "(GMT + 5:00) Ekaterinburg, Islamabad, Karachi, Tashkent" } );
                //dt.Rows.Add( new object [] { 330, "(GMT + 5:30) Bombay, Calcutta, Madras, New Delhi" } );
                //dt.Rows.Add( new object [] { 360, "(GMT + 6:00) Almaty, Colomba, Dhakra" } );
                //dt.Rows.Add( new object [] { 420, "(GMT + 7:00) Bangkok, Hanoi, Jakarta" } );
				dt.Rows.Add( new object [] { 480, "(GMT + 8:00) ����, ���, �¼���, ̨��" } );
                //dt.Rows.Add( new object [] { 540, "(GMT + 9:00) Osaka, Sapporo, Seoul, Tokyo, Yakutsk" } );
                //dt.Rows.Add( new object [] { 570, "(GMT + 9:30) Adelaide, Darwin" } );
                //dt.Rows.Add( new object [] { 600, "(GMT + 10:00) Melbourne, Papua New Guinea, Sydney, Vladivostok" } );
                //dt.Rows.Add( new object [] { 660, "(GMT + 11:00) Magadan, New Caledonia, Solomon Islands" } );
                //dt.Rows.Add( new object [] { 720, "(GMT + 12:00) Auckland, Wellington, Fiji, Marshall Island" } );
				return dt;
			}
		}

		public static DataTable Themes()
		{
			using ( DataTable dt = new DataTable( "Themes" ) )
			{
				dt.Columns.Add( "Theme", typeof( string ) );
				dt.Columns.Add( "FileName", typeof( string ) );

				System.IO.DirectoryInfo dir = new System.IO.DirectoryInfo( System.Web.HttpContext.Current.Request.MapPath( String.Format( "{0}themes", Data.ForumRoot ) ) );
				System.IO.FileInfo [] files = dir.GetFiles( "*.xml" );
				foreach ( System.IO.FileInfo file in files )
				{
					try
					{
						System.Xml.XmlDocument doc = new System.Xml.XmlDocument();
						doc.Load( file.FullName );

						DataRow dr = dt.NewRow();
						dr ["Theme"] = doc.DocumentElement.Attributes ["theme"].Value;
						dr ["FileName"] = file.Name;
						dt.Rows.Add( dr );
					}
					catch ( Exception )
					{
					}
				}
				return dt;
			}
		}

		public static DataTable Languages()
		{
			using ( DataTable dt = new DataTable( "Languages" ) )
			{
				dt.Columns.Add( "Language", typeof( string ) );
				dt.Columns.Add( "FileName", typeof( string ) );

				System.IO.DirectoryInfo dir = new System.IO.DirectoryInfo( System.Web.HttpContext.Current.Request.MapPath( String.Format( "{0}languages", ForumRoot ) ) );
				System.IO.FileInfo [] files = dir.GetFiles( "*.xml" );
				foreach ( System.IO.FileInfo file in files )
				{
					try
					{
						System.Xml.XmlDocument doc = new System.Xml.XmlDocument();
						doc.Load( file.FullName );
						DataRow dr = dt.NewRow();
						dr ["Language"] = doc.DocumentElement.Attributes ["language"].Value;
						dr ["FileName"] = file.Name;
						dt.Rows.Add( dr );
					}
					catch ( Exception )
					{
					}
				}
				return dt;
			}
		}

		static public DataTable TopicTimes()
		{
			return TopicTimes( null );
		}

		static public DataTable TopicTimes( yaf.pages.ForumPage basePage )
		{
			using ( DataTable dt = new DataTable( "TopicTimes" ) )
			{
				dt.Columns.Add( "TopicText", typeof( string ) );
				dt.Columns.Add( "TopicValue", typeof( int ) );

				string [] tTextArray = { "all", "last_day", "last_two_days", "last_week", "last_two_weeks", "last_month", "last_two_months", "last_six_months", "last_year" };
				string [] tTextArrayProp = { "All", "Last Day", "Last Two Days", "Last Week", "Last Two Weeks", "Last Month", "Last Two Months", "Last Six Months", "Last Year" };

				for ( int i = 0; i < 8; i++ )
				{
					DataRow dr = dt.NewRow();
					dr ["TopicText"] = ( basePage == null ) ? tTextArrayProp [i] : basePage.GetText( tTextArray [i] );
					dr ["TopicValue"] = i;
					dt.Rows.Add( dr );
				}
				return dt;
			}
		}

		static public bool IsLocal
		{
			get
			{
				string s = HttpContext.Current.Request.ServerVariables ["SERVER_NAME"];
				return s != null && s.ToLower() == "localhost";
			}
		}

		#region Version Information

		static public string AppVersionName
		{
			get
			{
				return "2.0";
			}
		}
		static public int AppVersion
		{
			get
			{
				return 22;
			}
		}

		static public DateTime AppVersionDate
		{
			get
			{
				return new DateTime( 2008, 05, 01 );			
            }
		}
		#endregion
	}
}
