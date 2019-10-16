if exists(select * from information_schema.tables where table_schema = N'dbo' and table_name = N'subscriptionsummarydetail')
	begin
			IF NOT EXISTS(SELECT 1 FROM sys.columns  WHERE Name = N'MarkUpPercentage' AND Object_ID = Object_ID(N'dbo.subscriptionsummarydetail'))
			alter table subscriptionsummarydetail add MarkUpPercentage [float] NULL
			
			IF NOT EXISTS(SELECT 1 FROM sys.columns  WHERE Name = N'SalesPrice' AND Object_ID = Object_ID(N'dbo.subscriptionsummarydetail'))
			
			alter table subscriptionsummarydetail add [SalesPrice] [float] NULL
			
			IF NOT EXISTS(SELECT 1 FROM sys.columns  WHERE Name = N'SeatLimit' AND Object_ID = Object_ID(N'dbo.subscriptionsummarydetail'))
			
			alter table subscriptionsummarydetail add SeatLimit [float] NULL
			
			IF NOT EXISTS(SELECT 1 FROM sys.columns  WHERE Name = N'TaxStatus' AND Object_ID = Object_ID(N'dbo.subscriptionsummarydetail'))
			alter table subscriptionsummarydetail add TaxStatus [nvarchar](50) NULL
			
			IF NOT EXISTS(SELECT 1 FROM sys.columns  WHERE Name = N'SeatLimitStartTime' AND Object_ID = Object_ID(N'dbo.subscriptionsummarydetail'))
			alter table subscriptionsummarydetail add SeatLimitStartTime [datetime] NULL
			
			IF NOT EXISTS(SELECT 1 FROM sys.columns  WHERE Name = N'SeatLimitEndTime' AND Object_ID = Object_ID(N'dbo.subscriptionsummarydetail'))
			alter table subscriptionsummarydetail add SeatLimitEndTime [datetime] NULL
			
			IF NOT EXISTS(SELECT 1 FROM sys.columns  WHERE Name = N'SeatCounter' AND Object_ID = Object_ID(N'dbo.subscriptionsummarydetail'))
			alter table subscriptionsummarydetail add SeatCounter [int] NULL
			
			IF NOT EXISTS(SELECT 1 FROM sys.columns  WHERE Name = N'TemporarySeatLimit' AND Object_ID = Object_ID(N'dbo.subscriptionsummarydetail'))
			alter table subscriptionsummarydetail add TemporarySeatLimit [float] NULL
			
			--Start Table SubscriptionSummaryDetail
			IF EXISTS(SELECT 1  FROM sys.key_constraints WHERE name = (N'PK_SubscriptionSummaryDetail') AND parent_object_id = OBJECT_ID(N'dbo.SubscriptionSummaryDetail'))
			ALTER TABLE [dbo].[SubscriptionSummaryDetail] DROP CONSTRAINT [PK_SubscriptionSummaryDetail] WITH ( ONLINE = OFF )
			
			IF NOT EXISTS(SELECT 1 FROM sys.columns  WHERE Name = N'tblSubsId' AND Object_ID = Object_ID(N'dbo.subscriptionsummarydetail'))
			ALTER TABLE [dbo].[SubscriptionSummaryDetail] ADD [tblSubsId]  int NOT NULL identity(1,1) 

			IF NOT EXISTS(SELECT 1  FROM sys.key_constraints WHERE name = (N'PK_SubscriptionSummaryDetail') AND parent_object_id = OBJECT_ID(N'dbo.SubscriptionSummaryDetail'))
			ALTER TABLE [dbo].[SubscriptionSummaryDetail] ADD  CONSTRAINT [PK_SubscriptionSummaryDetail] PRIMARY KEY CLUSTERED ([tblSubsId]);
			--END Table SubscriptionSummaryDetail

			IF  EXISTS (SELECT 1  FROM sys.foreign_keys WHERE name = (N'FK_CompanyOrder_Company') AND parent_object_id = OBJECT_ID(N'dbo.CompanyOrder'))
			ALTER TABLE [dbo].[CompanyOrder] DROP CONSTRAINT [FK_CompanyOrder_Company]

			IF  EXISTS (SELECT 1  FROM sys.foreign_keys WHERE name = (N'FK_CompanyOrder_OrderHeader') AND parent_object_id = OBJECT_ID(N'dbo.CompanyOrder'))
			ALTER TABLE [dbo].[CompanyOrder] DROP CONSTRAINT [FK_CompanyOrder_OrderHeader]

			IF  EXISTS (SELECT 1  FROM sys.foreign_keys WHERE name = (N'FK_Enduser_Company') AND parent_object_id = OBJECT_ID(N'dbo.Enduser'))
			ALTER TABLE [dbo].[Enduser] DROP CONSTRAINT [FK_Enduser_Company]

			IF  EXISTS (SELECT 1  FROM sys.foreign_keys WHERE name = (N'FK_OrderLine_OrderHeader') AND parent_object_id = OBJECT_ID(N'dbo.OrderLine'))
			ALTER TABLE [dbo].[OrderLine] DROP CONSTRAINT [FK_OrderLine_OrderHeader]

			--Start Table OrderHeader
			IF EXISTS(SELECT 1  FROM sys.key_constraints WHERE parent_object_id = OBJECT_ID(N'dbo.OrderHeader') and type='PK')
			BEGIN
				DECLARE @SQL VARCHAR(4000)
				SET @SQL = 'ALTER TABLE dbo.OrderHeader DROP CONSTRAINT |ConstraintName| '
				SET @SQL = REPLACE(@SQL, '|ConstraintName|', ( SELECT   name
                                               FROM     sys.key_constraints
                                               WHERE    type = 'PK'
                                                        AND parent_object_id = OBJECT_ID(N'dbo.OrderHeader')
                                             ))

				EXEC (@SQL)
			END
			
			IF NOT EXISTS(SELECT 1 FROM sys.columns  WHERE Name = N'OrderId' AND Object_ID = Object_ID(N'dbo.OrderHeader'))
			ALTER TABLE [dbo].[OrderHeader] ADD [OrderId]  int NOT NULL identity(1,1) 

			IF NOT EXISTS(SELECT 1  FROM sys.key_constraints WHERE name = (N'PK_OrderHeader') AND parent_object_id = OBJECT_ID(N'dbo.OrderHeader'))
			ALTER TABLE [dbo].[OrderHeader] ADD  CONSTRAINT [PK_OrderHeader] PRIMARY KEY CLUSTERED ([OrderId]);
			--End Table OrderHeader

			--Start Table OrderLine
			IF EXISTS(SELECT 1  FROM sys.key_constraints WHERE name = (N'PK_OrderLine') AND parent_object_id = OBJECT_ID(N'dbo.OrderLine'))
			ALTER TABLE [dbo].[OrderLine] DROP CONSTRAINT [PK_OrderLine] WITH ( ONLINE = OFF )

			IF NOT EXISTS(SELECT 1  FROM sys.key_constraints WHERE name = (N'PK_OrderLine') AND parent_object_id = OBJECT_ID(N'dbo.OrderLine'))
			ALTER TABLE [dbo].[OrderLine] ADD  CONSTRAINT [PK_OrderLine] PRIMARY KEY CLUSTERED ([LineId]);
			--END Table OrderLine

			IF NOT EXISTS(SELECT 1 FROM sys.columns  WHERE Name = N'EndUserPONumber' AND Object_ID = Object_ID(N'dbo.OrderHeader'))
			ALTER TABLE [dbo].[OrderHeader] ADD [EndUserPONumber] nvarchar(50)

			IF NOT EXISTS(SELECT 1 FROM sys.columns  WHERE Name = N'CompanyName' AND Object_ID = Object_ID(N'dbo.Enduser'))
			ALTER TABLE [dbo].[Enduser] ADD [CompanyName] nvarchar(255)

			IF EXISTS(SELECT 1 FROM sys.columns  WHERE Name = N'EndCustomerEmail' AND Object_ID = Object_ID(N'dbo.subscriptionsummarydetail'))
			ALTER TABLE [dbo].[SubscriptionSummaryDetail] ALTER COLUMN [EndCustomerEmail] [nvarchar](100) NULL

			IF NOT EXISTS(SELECT 1 FROM sys.columns  WHERE Name = N'EndCustomerId' AND Object_ID = Object_ID(N'dbo.subscriptionsummarydetail'))
			ALTER TABLE [dbo].[SubscriptionSummaryDetail] ADD [EndCustomerId] [nvarchar](50) NULL

			IF NOT EXISTS(SELECT 1 FROM sys.columns  WHERE Name = N'EndCustomerId' AND Object_ID = Object_ID(N'dbo.Company'))
			ALTER TABLE [dbo].[Company] ADD [EndCustomerId] [nvarchar](50) NULL

			IF NOT EXISTS(SELECT 1 FROM sys.columns  WHERE Name = N'Status' AND Object_ID = Object_ID(N'dbo.subscriptionsummarydetail'))
			ALTER TABLE [dbo].[SubscriptionSummaryDetail] ADD [Status] [nvarchar](20) NULL

			IF NOT EXISTS(SELECT 1 FROM sys.columns  WHERE Name = N'ResellerPO' AND Object_ID = Object_ID(N'dbo.subscriptionsummarydetail'))
			ALTER TABLE [dbo].[SubscriptionSummaryDetail] ADD [ResellerPO] [nvarchar](50) NULL

			IF NOT EXISTS(SELECT 1 FROM sys.columns  WHERE Name = N'EndCustomerPO' AND Object_ID = Object_ID(N'dbo.subscriptionsummarydetail'))
			ALTER TABLE [dbo].[SubscriptionSummaryDetail] ADD [EndCustomerPO] [nvarchar](50) NULL
	END
ELSE
	begin
		SET ANSI_NULLS ON

		SET QUOTED_IDENTIFIER ON

		CREATE TABLE [dbo].[SubscriptionSummaryDetail](
			[OrderNumber] [nvarchar](50) NOT NULL,
			[VendorId] [nvarchar](50) NULL,
			[VendorName] [nvarchar](50) NULL,
			[SKU] [nvarchar](50) NULL,
			[SkuName] [nvarchar](max) NULL,
			[Quantity] [nvarchar](50) NULL,
			[Article] [nvarchar](50) NULL,
			[PaymentMethod] [nvarchar](50) NULL,
			[EndCustomerName] [nvarchar](50) NULL,
			[EndCustomerEmail] [nvarchar](100) NULL,
			[Company] [nvarchar](50) NULL,
			[OrderSource] [nvarchar](50) NULL,
			[UnitPrice] [nvarchar](50) NULL,
			[CurrencySymbol] [nvarchar](50) NULL,
			[CurrencyCode] [nvarchar](50) NULL,
			[CreatedDate] [datetime] NULL,
			[UpdatedDate] [datetime] NULL,
			[LineStatus] [nvarchar](50) NULL,
			[Domain] [nvarchar](50) NULL,
			[MsSubscriptionId] [nvarchar](50) NULL,
			[MicrosoftId] [nvarchar](50) NULL,
			[SubscriptionHistoryJson] [nvarchar](max) NULL,
			[SubscriptionId] [uniqueidentifier] NOT NULL,
			[MappingStatus] [nvarchar](50) NULL,
			[MarkUpPercentage] [float] NULL,
			[SalesPrice] [float] NULL,
			[SeatLimit] [float] NULL,
			[TaxStatus] [nvarchar](50) NULL,
			[SeatLimitStartTime] [datetime] NULL,
			[SeatLimitEndTime] [datetime] NULL,
			[SeatCounter] [int] NULL,
			[TemporarySeatLimit] [float] NULL,
			[tblSubsId] [int] IDENTITY(1,1) NOT NULL,
			[EndCustomerId] [nvarchar](50) NULL,
			[Status] [nvarchar](20) NULL,
			[ResellerPO] [nvarchar](50) NULL,
			[EndCustomerPO] [nvarchar](50) NULL,
		 CONSTRAINT [PK_SubscriptionSummaryDetail] PRIMARY KEY CLUSTERED 
		(
			[tblSubsId] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	END

if not exists(select * from information_schema.tables where table_schema = N'dbo' and table_name = N'__MigrationHistory')
	begin
			/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 6/12/2018 11:32:59 AM ******/
			SET ANSI_NULLS ON
			
			SET QUOTED_IDENTIFIER ON
			
			SET ANSI_PADDING ON
			
			CREATE TABLE [dbo].[__MigrationHistory](
				[MigrationId] [nvarchar](150) NOT NULL,
				[ContextKey] [nvarchar](300) NOT NULL,
				[Model] [varbinary](max) NOT NULL,
				[ProductVersion] [nvarchar](32) NOT NULL,
			CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
			(
				[MigrationId] ASC,
				[ContextKey] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
			
			
			SET ANSI_PADDING OFF
	end
	
if not exists(select * from information_schema.tables where table_schema = N'dbo' and table_name = N'AspNetRoles')
	begin
			/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 6/12/2018 11:32:59 AM ******/
			SET ANSI_NULLS ON
			
			SET QUOTED_IDENTIFIER ON
			
			CREATE TABLE [dbo].[AspNetRoles](
				[Id] [nvarchar](128) NOT NULL,
				[Name] [nvarchar](256) NOT NULL,
			CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
			(
				[Id] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY]
	end
			
	
if not exists(select * from information_schema.tables where table_schema = N'dbo' and table_name = N'AspNetUserClaims')
	begin
			/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 6/12/2018 11:32:59 AM ******/
			SET ANSI_NULLS ON
			
			SET QUOTED_IDENTIFIER ON
			
			CREATE TABLE [dbo].[AspNetUserClaims](
				[Id] [int] IDENTITY(1,1) NOT NULL,
				[UserId] [nvarchar](128) NOT NULL,
				[ClaimType] [nvarchar](max) NULL,
				[ClaimValue] [nvarchar](max) NULL,
			CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
			(
				[Id] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	end	

	
if not exists(select * from information_schema.tables where table_schema = N'dbo' and table_name = N'AspNetUserLogins')
	begin
			/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 6/12/2018 11:32:59 AM ******/
			SET ANSI_NULLS ON
			
			SET QUOTED_IDENTIFIER ON
			
			CREATE TABLE [dbo].[AspNetUserLogins](
				[LoginProvider] [nvarchar](128) NOT NULL,
				[ProviderKey] [nvarchar](128) NOT NULL,
				[UserId] [nvarchar](128) NOT NULL,
			CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
			(
				[LoginProvider] ASC,
				[ProviderKey] ASC,
				[UserId] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY]
	end	
	
	
if not exists(select * from information_schema.tables where table_schema = N'dbo' and table_name = N'AspNetUserRoles')
	begin
	/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 6/12/2018 11:32:59 AM ******/
	SET ANSI_NULLS ON
	
	SET QUOTED_IDENTIFIER ON
	
	CREATE TABLE [dbo].[AspNetUserRoles](
		[UserId] [nvarchar](128) NOT NULL,
		[RoleId] [nvarchar](128) NOT NULL,
	CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
	(
		[UserId] ASC,
		[RoleId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	
	end
		
	
if not exists(select * from information_schema.tables where table_schema = N'dbo' and table_name = N'AspNetUsers')
	begin
		/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 6/12/2018 11:32:59 AM ******/
	SET ANSI_NULLS ON
	
	SET QUOTED_IDENTIFIER ON
	
	CREATE TABLE [dbo].[AspNetUsers](
		[Id] [nvarchar](128) NOT NULL,
		[Email] [nvarchar](256) NULL,
		[EmailConfirmed] [bit] NOT NULL,
		[PasswordHash] [nvarchar](max) NULL,
		[SecurityStamp] [nvarchar](max) NULL,
		[PhoneNumber] [nvarchar](max) NULL,
		[PhoneNumberConfirmed] [bit] NOT NULL,
		[TwoFactorEnabled] [bit] NOT NULL,
		[LockoutEndDateUtc] [datetime] NULL,
		[LockoutEnabled] [bit] NOT NULL,
		[AccessFailedCount] [int] NOT NULL,
		[UserName] [nvarchar](256) NOT NULL,
	CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	
	end

if not exists(select * from information_schema.tables where table_schema = N'dbo' and table_name = N'Company')
	begin
		/****** Object:  Table [dbo].[Company]    Script Date: 6/12/2018 11:32:59 AM ******/
	SET ANSI_NULLS ON
	
	SET QUOTED_IDENTIFIER ON

	CREATE TABLE [dbo].[Company](
		[CompanyId] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
		[Name] [nvarchar](255) NOT NULL,
		[Created] [datetime] NOT NULL,
		[CreatedBy] [nvarchar](250) NOT NULL,
		[EndCustomerId] [nvarchar](50) NULL,
	 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
	(
		[CompanyId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END

if not exists(select * from information_schema.tables where table_schema = N'dbo' and table_name = N'CompanyOrder')	
	BEGIN
		/****** Object:  Table [dbo].[CompanyOrder]    Script Date: 11/6/2018 1:42:00 PM ******/
		SET ANSI_NULLS ON
		
		SET QUOTED_IDENTIFIER ON
		
		CREATE TABLE [dbo].[CompanyOrder](
			[RecordId] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
			[CompanyId] [numeric](18, 0) NOT NULL,
			[SalesOrderId] [nvarchar](50) NOT NULL,
			[Created] [datetime] NULL,
			[CreatedBy] [nvarchar](100) NULL,
		 CONSTRAINT [PK_CompanyOrder] PRIMARY KEY CLUSTERED 
		(
			[RecordId] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]
	END
	
if not exists(select * from information_schema.tables where table_schema = N'dbo' and table_name = N'Configs')	
	begin
	/****** Object:  Table [dbo].[Configs]    Script Date: 6/12/2018 11:32:59 AM ******/
	SET ANSI_NULLS ON
	
	SET QUOTED_IDENTIFIER ON
	
	CREATE TABLE [dbo].[Configs](
		[Id] [int] IDENTITY(1,1) NOT NULL,
		[Key] [nvarchar](max) NULL,
		[Value] [nvarchar](max) NULL,
		[Type] [nvarchar](max) NULL,
	CONSTRAINT [PK_dbo.Configs] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	end	
	
if not exists(select * from information_schema.tables where table_schema = N'dbo' and table_name = N'Enduser')		
	BEGIN
		SET ANSI_NULLS ON

		SET QUOTED_IDENTIFIER ON

		CREATE TABLE [dbo].[Enduser](
			[EnduserId] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
			[SAPEnduserId] [uniqueidentifier] NULL,
			[CompanyId] [numeric](18, 0) NULL,
			[Created] [datetime] NULL,
			[CreatedBy] [nvarchar](255) NULL,
			[Email] [nvarchar](255) NOT NULL,
			[Name] [nvarchar](255) NOT NULL,
			[CompanyName] [nvarchar](255) NULL,
		CONSTRAINT [PK_Enduser] PRIMARY KEY CLUSTERED 
		(
			[EnduserId] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]
	END
	
if not exists(select * from information_schema.tables where table_schema = N'dbo' and table_name = N'Logs')		
	begin
	/****** Object:  Table [dbo].[Logs]    Script Date: 6/12/2018 11:32:59 AM ******/
	SET ANSI_NULLS ON
	
	SET QUOTED_IDENTIFIER ON
	
	CREATE TABLE [dbo].[Logs](
		[Message] [nvarchar](max) NULL,
		[ErrorCode] [nvarchar](max) NULL,
		[Result] [nvarchar](max) NULL,
		[Key] [int] NULL,
		[IsSuccess] [bit] NULL,
		[IsValid] [bit] NULL,
		[DateTime] [datetime] NULL,
		[Browser] [nvarchar](50) NULL,
		[CurrentExecutionFilePath] [nvarchar](max) NULL,
		[RequestType] [nvarchar](50) NULL,
		[UserHostAddress] [nvarchar](max) NULL,
		[UserHostName] [nvarchar](max) NULL
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	
	end	
	
if not exists(select * from information_schema.tables where table_schema = N'dbo' and table_name = N'OrderHeader')	
	begin
	/****** Object:  Table [dbo].[OrderHeader]    Script Date: 6/12/2018 11:32:59 AM ******/
	SET ANSI_NULLS ON
	
	SET QUOTED_IDENTIFIER ON
	
	CREATE TABLE [dbo].[OrderHeader](
		[OrderNumber] [nvarchar](50) NOT NULL,
		[OrderDate] [datetime] NULL,
		[OrderType] [nvarchar](50) NULL,
		[EndUserName] [nvarchar](100) NULL,
		[EndUserEmail] [nvarchar](100) NULL,
		[TotalSalesPrice] [numeric](18, 2) NULL,
		[Status] [nvarchar](50) NULL,
		[Domain] [nvarchar](100) NULL,
		[CurrencySymbol] [nvarchar](10) NULL,
		[CurrencyCode] [nvarchar](10) NULL,
		[LastUpdated] [datetime] NULL,
		[OrderJson] [nvarchar](max) NULL,
		[PONumber] [nvarchar](50) NULL,
		[OrderId] [int] IDENTITY(1,1) NOT NULL,
		[EndUserPONumber] [nvarchar](50) NULL,
	 CONSTRAINT [PK_OrderHeader] PRIMARY KEY CLUSTERED 
	(
		[OrderId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

	end	
	
	
	
if not exists(select * from information_schema.tables where table_schema = N'dbo' and table_name = N'OrderLine')	
	begin
		/****** Object:  Table [dbo].[OrderLine]    Script Date: 11/6/2018 1:44:36 PM ******/
		SET ANSI_NULLS ON
		
		SET QUOTED_IDENTIFIER ON
		
		CREATE TABLE [dbo].[OrderLine](
			[LineId] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
			[OrderNumber] [nvarchar](50) NOT NULL,
			[Sku] [nvarchar](50) NOT NULL,
			[SkuName] [nvarchar](200) NULL,
			[ManufacturerPartNumber] [nvarchar](50) NULL,
			[UnitPrice] [numeric](18, 0) NULL,
			[Quantity] [nvarchar](50) NULL,
			[LineStatus] [nvarchar](50) NULL,
			[CurrencySymbol] [nvarchar](10) NULL,
			[CurrencyCode] [nvarchar](10) NULL,
		 CONSTRAINT [PK_OrderLine] PRIMARY KEY CLUSTERED 
		(
			[LineId] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]
	end
	
	
if not exists(select * from information_schema.tables where table_schema = N'dbo' and table_name = N'Product')	
	begin
	/****** Object:  Table [dbo].[Product]    Script Date: 6/12/2018 11:32:59 AM ******/
	SET ANSI_NULLS ON
	
	SET QUOTED_IDENTIFIER ON
	
	CREATE TABLE [dbo].[Product](
		[Id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
		[Sku] [nvarchar](50) NOT NULL,
		[SkuName] [nvarchar](200) NULL,
		[ManufacturerPartNumber] [nvarchar](50) NULL,
		[Article] [nvarchar](50) NULL,
		[VendorMapId] [nvarchar](100) NULL,
		[ProductType] [nvarchar](50) NULL,
		[QtyMin] [int] NULL,
		[QtyMax] [int] NULL,
		[LastUpdated] [datetime] NULL,
	CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC,
		[Sku] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	end	
	
	
if not exists(select * from information_schema.tables where table_schema = N'dbo' and table_name = N'SiteContent')	
	begin
	/****** Object:  Table [dbo].[SiteContent]    Script Date: 6/12/2018 11:32:59 AM ******/
	SET ANSI_NULLS ON
	
	SET QUOTED_IDENTIFIER ON
	
	CREATE TABLE [dbo].[SiteContent](
		[Id] [int] IDENTITY(1,1) NOT NULL,
		[Key] [nvarchar](100) NULL,
		[Value] [nvarchar](max) NULL
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	end
	
IF EXISTS(select 1 from INFORMATION_SCHEMA.TABLES where table_schema = N'dbo' and table_name = N'ImageLibrary')
	DROP TABLE [dbo].[ImageLibrary]

CREATE TABLE [dbo].[ImageLibrary](
	[UniqueId] [uniqueidentifier] NOT NULL,
	[ManufacturingPartNumber] [nvarchar](max) NULL,
	[ImageUrl] [nvarchar](max) NULL,
	[SkuName] [nvarchar](max) NULL,
	[VendorName] [nvarchar](max) NULL,
 CONSTRAINT [PK_ImageLibrary] PRIMARY KEY CLUSTERED 
(
	[UniqueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]




INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'617e03f8-7f11-41c8-b488-01d9fabe598b', N'56433e2b33784b35867d31ebb879deac', N'Phase%206%20Images/Dynamics%20365%20for%20Customer%20Service%20Enterprise%20Edition%20Device.jpg', N'Dynamics 365 for Customer Service Enterprise Edition Device', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'5de24a85-a10d-406b-9d5a-025e1a8275d5', N'e9025a4459b1497ba5bef148006549ba', N'Phase%202%20Images/Microsoft%20365%20E3%20(Government%20Pricing).png', N'Microsoft 365 E3 (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'2870a97a-2aa5-4154-b79e-02b347eec21f', N'39504991553b48c2bdf4ea47f93bf784', N'Phase3%20Images/Windows%2010%20Enterprise%20E3.jpg', N'Windows 10 Enterprise E3', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'b889c97d-1118-4a83-bbb0-0320a4e52573', N'14c61739b45a42c0832cd330972d3173', N'Phase%205%20Images/Skype%20for%20Business%20Online%20(Plan%202).jpg', N'Skype for Business Online (Plan 2)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'476fdfd8-402c-4b45-a4c9-0420f9a1d5ac', N'0678a59abf0f4872a7a687246890a432', N'Phase%202%20Images/Microsoft%20365%20Business%20Preview.png', N'Microsoft 365 Business Preview', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'74fe8cfe-837d-4df8-bca7-0699dac9568f', N'195416c13447423ab37bee59a99a19c4', N'New%20Images%20with%20Product%20Name/Exchange%20Online%20Plan%201.png', N'Exchange Online Plan 1', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'd3e9a9d0-38e4-40ba-993c-06f07bd883f2', N'a3f4ab4e62394ecba85977369dca1c08', N'Phase3%20Images/Yammer%20Enterprise.png', N'Yammer Enterprise', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'd00a8b39-eb0f-4503-bc5a-070ba6fc6b81', N'5c25bdb6b2614dc2a60fa062be73d031', N'Phase%202%20Images/Office%20365%20ProPlus%20for%20students%20%20use%20benefit.png', N'Office 365 ProPlus for students  use benefit', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'b283434c-384a-4ba7-a8bd-0aff9246ef2f', N'ecb1b235b7da4cd1a329c33bab25cfe5', N'Phase4%20Images/Dynamics%20365%20for%20Customer%20Service%20Enterprise%20Edition%20CRMOL%20Basic%20(Qualified%20Offer).jpg', N'Dynamics 365 for Customer Service Enterprise Edition CRMOL Basic (Qualified Offer)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'48d6474d-c861-4eaf-b959-0b596cf48ace', N'6b551829de8c41e5867841d52c27aee8', N'Phase%202%20Images/Microsoft%20365%20E3%20(Government%20Pricing).png', N'Office 365 Enterprise E3 (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'bb71f991-dc5f-4af8-ac58-0bdbd3db302a', N'1ec5a993077943a9a857ac8fe83e977b', N'Phase4%20Images/Dynamics%20365%20Unf%20Ops%20Plan%2C%20Ent%20Edition.png', N'Dynamics 365 Unf Ops Plan, Ent Edition', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'7cc80ede-724d-43bc-b97b-0bed073d8f6e', N'10a5330e4ebc404197a41bd3cb3557bb', N'Phase4%20Images/Project%20Online%20Professional%20(Nonprofit%20Staff%20Pricing).png', N'Project Online Professional (Nonprofit Staff Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'82af99fb-96ae-4188-b42a-0d0f64466894', N'3891169e232345f795c24497cda23d1c', N'Phase3%20Images/Office%20365%20A5%20for%20students.png', N'Office 365 A5 for students', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'd2fe8c95-af2e-45db-8555-0e3bba349130', N'1a90ee132cb44785bb0f542813f00a37', N'Dynamics%20365%20Business%20Central%20Essential.png', N'Dynamics 365 Business Central Essential', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'cc2b0f13-f9b9-4abd-aa4d-0f720eff9722', N'35a36b80270a44bf929000545d350866', N'New%20Images%20with%20Product%20Name/Exchange%20Online%20Kiosk.jpg', N'Exchange Online Kiosk', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'e482a7a5-70a2-4f31-9196-1054fc919c38', N'2828be9546ba4f91b2fd0bef192ecf60', N'Phase%202%20Images/Exchange%20Online%20Archiving%20for%20Exchange%20Online.PNG', N'Exchange Online Archiving for Exchange Online', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'fd86928e-075c-494e-8909-11757e8dbcf5', N'62f287453f174337be15ea4b8c8dc872', N'Phase%202%20Images/Windows%2010%20Enterprise%20E3.jpg', N'Windows 10 Enterprise E3', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'1d88266e-df3f-4d14-9068-11f535ea0438', N'73a04bc3ff6f46f3ad24288c0d831074', N'Phase%206%20Images/Dynamics%20365%20Unf%20Ops%20Plan%2C%20Ent%20Edition%20From%20SA%20From%20AX%20Ent%20Func%20(Qualified%20Offer).jpg', N'Dynamics 365 for Customer Service Enterprise Edition (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'314fae99-7406-446f-b6eb-13008c406cc6', N'3db5387179924c6fbe2f845ec9842c73', N'Phase%205%20Images/Dynamics%20365%20for%20Sales%20Professional%20Add-On%20for%20CRM%20Basic%20(Qualified%20Offer).png', N'Dynamics 365 for Sales Professional Add-On for CRM Basic (Qualified Offer)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'5cce33db-5d0e-4ebb-a3d1-14f3bd1294a8', N'a9d8546b4e194d08b8e26814f2c2d8b1', N'Phase3%20Images/Office%20365%20Advanced%20Threat%20Protection%20for%20faculty.png', N'Office 365 Advanced Threat Protection for faculty', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'bc4b8c70-185d-4e7a-9fa1-16c587ac8a5d', N'778a4dce00144d538647314ef2b091d2', N'New%20Images%20with%20Product%20Name/Microsoft%20365%20A1.png', N'Microsoft 365 A1', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'7ff84499-58f8-40d0-9bc5-18aaaef5082a', N'52e3b82a80354fd98f42a709c6e6aaac', N'Phase4%20Images/Dynamics%20365%20for%20Customer%20Service%20Enterprise%20Edition%20CRMOL%20Professional%20(Qualified%20Offer).jpg', N'Dynamics 365 for Customer Service Enterprise Edition CRMOL Professional (Qualified Offer)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'ec1cd367-5cd5-4195-a531-191b979483f0', N'7f9757343e604a1a9200084befa083e6', N'Phase4%20Images/Dynamics%20365%20Enterprise%20Edition%20-%20Additional%20Database%20Storage%20(Government%20Pricing).jpg', N'Dynamics 365 Enterprise Edition - Additional Database Storage (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'70981f47-f864-4f6a-9b14-1b1d0d7ec753', N'4d2fc9b96b6941e8b039885839d40475', N'Phase%202%20Images/Dynamics%20365%20for%20Team%20Members%20Enterprise%20Edition%20(SMB%20Offer).jpg', N'Dynamics 365 for Team Members Enterprise Edition (SMB Offer)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'33e96862-2a59-4307-be3c-1da12711d223', N'038f253848134a9493a38e2425ac78a2', N'Dynamics%20365%20Unified%20Operations%20-%20Activity%20Cloud%20A.PNG', N'Dynamics 365 for Operations Activity, Enterprise Edition Cloud Add-on from AX Functional (Qualified Offer)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'0c1fbdd8-cddc-4bde-9540-1db84e8e9424', N'd903a2dbbf6f443483f121ba44017813', N'Phase%206%20Images/Exchange%20Online%20Protection.png', N'Exchange Online Protection', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'133b458b-4ad8-4d33-8ebb-1e439aacb083', N'249eaae150df42d08d69ca66d53248b6', N'Phase3%20Images/Microsoft%20Intune%20for%20Education%20for%20Faculty.jpg', N'Microsoft Intune for Education for Faculty', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'745ed8b4-6953-4ca7-998a-1ed0b460eade', N'2f707c7c243349a5a4379ca7cf40d3eb', N'Phase%206%20Images/Exchange%20Online%20(Plan%202).png', N'Exchange Online (Plan 2)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'113bced8-e158-4285-9432-1eddc7134406', N'5b2900bc50674c1799be1560a8e8e6a1', N'Phase4%20Images/Dynamics%20365%20for%20Talent%2C%20Ent%20Edition.png', N'Dynamics 365 for Talent, Ent Edition', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'4f0a0559-ef40-4ba6-9299-211e91d0ad13', N'68f6373c31cb43f0bfaa85f3688f8cfb', N'Phase4%20Images/Customer%20Lockbox.png', N'Customer Lockbox', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'9422088f-2518-498e-a8c3-224ba17de025', N'5d8c82e0438641298b3b5b5c193d1138', N'Phase3%20Images/Office%20365%20Cloud%20App%20Security.png', N'Office 365 Cloud App Security', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'bdfe0133-1d57-4a59-a499-22928e805397', N'e646756874524ad6948fea83a1d8c69c', N'Phase%205%20Images/Dynamics%20365%20Customer%20Engagement%20Plan%20Enterprise%20Edition%20Add-On%20for%20CRM%20Pro%20(Qualified%20Offer).jpg', N'Dynamics 365 Customer Engagement Plan Enterprise Edition Add-On for CRM Pro (Qualified Offer)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'4e0ab596-9dd7-4a68-9680-22e582d3cc4c', N'8c484fd01f3f44fbb6d226ca107273f6', N'Phase%206%20Images/Office%20365%20A5%20for%20faculty.png', N'Office 365 A5 for faculty', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'e8909df5-f32a-42af-b51d-233d72ae9523', N'ffb8bb8995734e76840f6521450325a1', N'Phase%206%20Images/Microsoft%20Dynamics%20CRM%20Online%20Basic.png', N'Microsoft Dynamics CRM Online Basic', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'ee45c9fc-fc00-4a09-8c76-23554505fd2b', N'06312e72b89a42adbd9ab13c72b16526', N'Phase%206%20Images/Visio%20Online%20Plan%201%20for%20faculty.png', N'Visio Online Plan 1 for faculty', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'c26529a6-0045-4804-9e45-24268f25e7a6', N'fc233c3f25bc4bba8984860ce561af86', N'Phase%202%20Images/Skype%20for%20Business%20Plus%20CAL.png', N'Skype for Business Plus CAL', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'e9dd00d8-d41a-433f-8a2e-25cf35375789', N'67b82638fdf8456b8d3632737a3b2a9b', N'Phase%205%20Images/Dynamics%20365%20Enterprise%20Edition%20-%20Additional%20Portal.jpg', N'Dynamics 365 Enterprise Edition - Additional Portal', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'50af0c48-d6be-433d-af64-2713e6ec3f42', N'cabdfc9357864224bfd335d58f833b35', N'Phase%205%20Images/Power%20BI%20Pro%20(Nonprofit%20Staff%20Pricing).png', N'Power BI Pro (Nonprofit Staff Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'eb943abe-282f-43af-acf7-27d6e08e78e8', N'00b2aa797da2422985efb413e2b770a9', N'New%20Images%20with%20Product%20Name/Dynamics%20365%20for%20Sales%20Enterprise%20Edition%20Qualified%20Offer%20for%20CRMOL%20Pro%20Add-', N'Dynamics 365 for Sales Enterprise Edition Qualified Offer for CRMOL Pro Add-On to O365 Users for Students', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'23196542-fe4c-47e7-9773-28166ce28dbd', N'91fd106f4b2c493895acf54f74e9a239', N'New%20Images%20with%20Product%20Name/Office%20365%20Enterprise%20E1.png', N'Office 365 Enterprise E1', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'd3ed1bfa-6c5d-4ccb-abb4-2b663bcdce1a', N'eb93319f34eb45fd92bf6c4bdf63120d', N'Phase3%20Images/Microsoft%20Intune%20for%20Education%20for%20Students.jpg', N'Microsoft Intune for Education for Students', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'6c27b6d0-fd40-46b1-a567-2e005e400dff', N'35eb491f5484496e978bf349eed3c699', N'Phase%202%20Images/Office%20365%20ProPlus%20for%20faculty.png', N'Office 365 ProPlus for faculty', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'7ddf2cb8-5af0-4296-83f3-2f649e520d45', N'bf1f69071f8e4f05b3274896d1395c15', N'Phase%206%20Images/OneDrive%20for%20Business%20(Plan%202).jpg', N'OneDrive for Business (Plan 2)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'b7f024f0-0a4c-4689-990f-2f8cbbda2b72', N'37402a1d0c6e4d49baae0e45bd8ecb44', N'New%20Images%20with%20Product%20Name/Enterprise%20Mobility%20%2B%20Security%20E5.jpg', N'Enterprise Mobility + Security E5', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'bb2c1356-9de3-4f46-9d0d-2fe795f8abef', N'f2c42110ec7b4434b55e1a9e456ac2f0', N'Phase3%20Images/Windows%2010%20Enterprise%20E5.png', N'Windows 10 Enterprise E5', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'794c64a1-24e7-4c18-b1cd-30f9773dd4f3', N'f0451b384b714babb7a134cc6d666afe', N'Phase%206%20Images/Dynamics%20365%20for%20Team%20Members%20Enterprise%20Edition%20(Government%20Pricing).jpg', N'Dynamics 365 for Team Members Enterprise Edition (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'4050ca86-dcd9-495f-913a-3116100a9a1e', N'800f4f3bcfe142c19cea675512810488', N'Phase%202%20Images/Power%20BI%20Pro.PNG', N'Power BI Pro', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'fe317041-db04-4457-afc9-3121e7bbfa19', N'031c9e4748024248838e778fb1d2cc05', N'New%20Images%20with%20Product%20Name/Office%20365%20Business%20Premium.png', N'Office 365 Business Premium', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'2a409b0a-76e2-4ec1-a7f5-33acb0b453c8', N'6b645205ac524dc8a7d5437cbd7dbf9b', N'Phase3%20Images/Enterprise%20Mobility%20%2B%20Security%20E3%20for%20Faculty.jpg', N'Enterprise Mobility + Security E3 for Faculty', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'acb7bbde-925a-4264-be84-33e16647bcf1', N'6374124668c54ae28a2d333b9eda85d4', N'Phase4%20Images/Project%20Online%20with%20Project%20for%20Office%20365.png', N'Project Online with Project for Office 365', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'd3886c7a-83e2-4525-8b1c-3481d7cd9666', N'c082b70a0e6347ca9cf75a962a920452', N'Phase3%20Images/Exchange%20Online%20Archiving%20for%20Exchange%20Server.png', N'Exchange Online Archiving for Exchange Server', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'2878e30c-d3ac-41bd-9208-3538ce330b82', N'231cc8524fbf4102b54c0c2274a43280', N'New%20Images%20with%20Product%20Name/Nimble%20Business.jpg', N'Nimble Business', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'b166bc3e-0b49-4d13-aaee-37357e99bae1', N'8909e28e583242f49886b0a5545f3645', N'Phase%205%20Images/Office%20365%20Enterprise%20E4.png', N'Office 365 Enterprise E4', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'89af5e77-c0d2-4e6f-9d78-37b5170818b9', N'eaf7db4cb6af403da865ea289b4fa306', N'Phase%202%20Images/Windows%2010%20Enterprise%20A5%20for%20faculty.png', N'Windows 10 Enterprise A5 for faculty', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'6a25010c-a1fd-42b5-b508-37b5347d3843', N'195416c13447423ab37bee59a99a19c4', N'Phase%205%20Images/Exchange%20Online%20(Plan%201).png', N'Exchange Online (Plan 1)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'6b44dcbb-ae69-4b22-821b-39c4b754d495', N'cfc69058510640bd81e444e0e29034b2', N'Phase%202%20Images/Office%20365%20Enterprise%20E1%20(Government%20Pricing).jpg', N'Office 365 Enterprise E1 (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'98318514-52f5-4414-897b-3a9e6638aa58', N'5eb287f2f34f4bc8a8b0c2e9b23f7430', N'Phase4%20Images/Dynamics%20365%20for%20Field%20Service%20Enterprise%20Edition.jpg', N'Dynamics 365 for Field Service Enterprise Edition', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'97201068-cc58-442e-bcbd-3c690df2cc42', N'09fdfa2ea64e4589a5503416214d2594', N'Phase3%20Images/Dynamics%20365%20Customer%20Engagement%20Plan%20Enterprise%20Edition%20Qualified%20Offer%20for%20CRMOL%20Pro%20Add-On%20to%20O365%20Users.jpg', N'Dynamics 365 Customer Engagement Plan Enterprise Edition Qualified Offer for CRMOL Pro Add-On to O365 Users', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'd1b4af92-4cf0-4210-83a0-3d5aac64a588', N'6fbad345b7de42a6b6ab79b363d0b371', N'New%20Images%20with%20Product%20Name/Office%20365%20F1.png', N'Office 365 F1', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'83ea91af-2d41-44b2-a71c-3de7cb2de280', N'4260988e990d479cae7bf01ce8e1bb4d', N'Phase%202%20Images/Phone%20System.png', N'Phone System', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'30bc514b-5a0f-4aed-a1ea-3e4ad5501728', N'88f9eb8a063645e8a601553e0a48aa9e', N'Phase%205%20Images/Dynamics%20365%20Business%20Central%20External%20Accountant.png', N'Dynamics 365 Business Central External Accountant', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'77e614cc-1b94-4c58-8fe8-3f3e24b690c2', N'ec0d51df916f4455a0965ab08f58dbd2', N'Phase4%20Images/Exchange%20Online%20(Plan%202)%20(Government%20Pricing).png', N'Exchange Online (Plan 2) (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'cc9a9096-9491-4375-a7c5-3f9a2db5da34', N'ee10cbd27a1245debe110c2c7c6eeeb1', N'Microsoft-Logo-PNG-Transparent-Image.png', N'Minecraft: Education Edition (per user)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'748b84a2-dbfc-4b14-b7c2-402a5c1fbfaf', N'2b6f895ddfd34fb58c8c1a551c9db59a', N'Phase3%20Images/Office%20365%20ProPlus%20(Government%20Pricing).png', N'Office 365 ProPlus (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'a01fb5ae-b59e-40ea-bdd4-408661f304f7', N'ffb8bb8995734e76840f6521450325a1', N'New%20Images%20with%20Product%20Name/Microsoft%20Dynamics%20CRM%20Online%20Basic.png', N'Microsoft Dynamics CRM Online Basic', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'4d9352ea-e54c-4cc4-bcd2-41fe6f51098b', N'525a468b18eb4d4bb55602e2699de020', N'Phase%206%20Images/Microsoft%20PowerApps%20Plan%202.png', N'Microsoft PowerApps Plan 2', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'262ab89b-100a-430d-b3b1-42afda9f172d', N'be57ff4c100c4f1fb82df1c5ab63a665', N'New%20Images%20with%20Product%20Name/Office%20365%20ProPlus.png', N'Office 365 ProPlus', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'deb075dd-efee-4ced-b056-44177db22192', N'37402a1d0c6e4d49baae0e45bd8ecb44', N'Phase%206%20Images/Enterprise%20Mobility%20%2B%20Security%20E5.jpg', N'Enterprise Mobility + Security E5', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'e98cfbdf-2d51-40c3-8d11-44f4d85c75a5', N'24cc266d6fd34b85b9c84d5f587521ac', N'Phase%202%20Images/Exchange%20Online%20(Plan%201)%20(Government%20Pricing).png', N'Exchange Online (Plan 1) (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'e2443a27-92c5-4d43-ac0f-4544718790ef', N'2cc27733938b40f7a6cfb6889565a669', N'Phase%206%20Images/Office%20365%20Business%20Premium.png', N'Office 365 Business Premium', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'6d89386b-2b51-4d0a-ae9c-45581e684305', N'85538938525a44a5bae3b316adc79159', N'Phase3%20Images/Dynamics%20365%20Customer%20Engagement%20Plan%20Enterprise%20Edition%20CRMOL%20Professional%20(Qualified%20Offer).jpg', N'Dynamics 365 Customer Engagement Plan Enterprise Edition for Faculty CRMOL Professional (Qualified Offer) ', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'087256be-a44d-4f08-bf7e-46c621c9a856', N'90d3615eaa96478eb6ce8eb1e9a96b4b', N'Phase3%20Images/OneDrive%20for%20Business%20(Plan%201).png', N'OneDrive for Business (Plan 1)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'85c66d42-e2b4-4b38-91ad-46f92d8ca9f0', N'410fcf83972a4ac6a90bf8d55b69e26e', N'Phase%205%20Images/Project%20Online%20Professional%20(Government%20Pricing).png', N'Project Online Professional (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'85482684-0a63-4238-9e6c-47969b2b542d', N'd903a2dbbf6f443483f121ba44017813', N'New%20Images%20with%20Product%20Name/Exchange%20Online%20Protection.png', N'Exchange Online Protection', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'37af5c4e-6ceb-48c3-b4f4-488a0c45bb95', N'a044b16a186143088086a3a3b506fac2', N'Phase%202%20Images/Office%20365%20Enterprise%20E5.png', N'Office 365 Enterprise E5', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'643252cc-44d0-4c2d-94c2-4b1f71122ada', N'cd4fc620c23048999942dc186179a762', N'Phase3%20Images/Dynamics%20365%20for%20Team%20Members%20Enterprise%20Edition%20Tier%202%20(100-249%20Users).jpg', N'Dynamics 365 for Team Members Enterprise Edition Tier 2 (100-249 Users)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'1b67a98d-3d8a-47b9-b206-4db8c014afa8', N'c0fadb1c994044059c282ed7405cb01b', N'Phase%206%20Images/Dynamics%20365%20for%20Sales%20Enterprise%20Edition%20for%20Faculty%20%20%20(Device).jpg', N'Dynamics 365 for Sales Enterprise Edition for Faculty   (Device)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'8b9be051-959a-4653-a85a-4e70c66eec2d', N'a6c260a7545c42f7bb27461c1e131534', N'Phase4%20Images/Skype%20for%20Business%20Online%20(Plan%202)%20(Government%20Pricing).jpg', N'Skype for Business Online (Plan 2) (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'00bcb88c-a1a1-4747-ba76-4ec9b50e1496', N'11e3c9a924a24cfd9f60a9797d68e296', N'Phase%205%20Images/Project%20for%20Office%20365%20(Government%20Pricing).png', N'Project for Office 365 (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'39a3a828-2987-4e3a-9e34-504cdba1e510', N'560FA38104854A44AAD77133825B7E36', N'Phase%205%20Images/DYNAMICS%20365%20BUSINESS%20CENTRAL%20ESSENTIAL%20FROM%20DPL%20OR%20BUS%20ED%20(QUALIFIED%20OFFER).png', N'DYNAMICS 365 BUSINESS CENTRAL ESSENTIAL FROM DPL OR BUS ED (QUALIFIED OFFER)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'e6390bb1-20f5-4461-acfe-5057a22e90e9', N'd431de8a1ac249dda6f507f3a0a880ff', N'New%20Images%20with%20Product%20Name/Microsoft%20Dynamics%20CRM%20Online%20Essential.png', N'Microsoft Dynamics CRM Online Essential', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'd3398079-69b8-449c-a6bf-51a094564d8c', N'5c9fd4ccedce44a88e9107df09744609', N'New%20Images%20with%20Product%20Name/Office%20365%20Business.png', N'Office 365 Business', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'c61d8b09-4343-4cfd-83ec-529e768bcf16', N'796b6b5f613c4e24a17ceba730d49c02', N'Phase%206%20Images/Office%20365%20Enterprise%20E3.png', N'Office 365 Enterprise E3', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'55ae0ded-097d-477b-8002-534ac6e125fc', N'2389eb32a60d474a936c5feb8ab06aad', N'Phase%205%20Images/Microsoft%20PowerApps%20Plan%201.png', N'Microsoft PowerApps Plan 1', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'54dbfddc-e5d8-40eb-9e99-53a6a83959dd', N'8817b694eea343f39b0b4dcec5fb9f47', N'Phase%205%20Images/Dynamics%20365%20for%20Sales%20Enterprise%20Edition%20(Nonprofit%20Staff%20Pricing).png', N'Dynamics 365 for Sales Enterprise Edition (Nonprofit Staff Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'c76644c6-1d08-41eb-86a7-544bc3b46474', N'DC990904BFC245C89F8A29E2E9F88B09', N'Phase%205%20Images/DYNAMICS%20365%20FOR%20SALES%20ENTERPRISE%20EDITION%20FROM%20SA%20FOR%20CRM%20BASIC%20(QUALIFIED%20OFFER).png', N'DYNAMICS 365 FOR SALES ENTERPRISE EDITION FROM SA FOR CRM BASIC (QUALIFIED OFFER)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'caf65741-028c-47ad-98b7-5577c2832c87', N'4d8f3b9029b34e7bb37c4a435ddef1d9', N'Phase%205%20Images/Common%20Area%20Phone.png', N'Common Area Phone', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'0d5e67b9-f3ed-418c-98bc-56f0900b6bc7', N'f9707a06e6734bc2a0b1b994b6fcc4b4', N'Phase3%20Images/Dynamics%20365%20for%20Team%20Members%20Enterprise%20Edition%20for%20Faculty.jpg', N'Dynamics 365 for Team Members Enterprise Edition for Faculty', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'c5e67101-e265-4d85-bed1-5c192d5dcf28', N'f7ad4eaff2ef42dcb43c425ce393435c', N'Phase4%20Images/Microsoft%20365%20E3%20(Nonprofit%20Staff%20Pricing).png', N'Microsoft 365 E3 (Nonprofit Staff Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'0e4c5142-1216-4518-be3a-5c3eef594a6d', N'4b608b643a274373854cfd33115a8ce1', N'Phase3%20Images/Windows%2010%20Enterprise%20E3%20VDA.png', N'Windows 10 Enterprise E3 VDA', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'15f46fd6-7da1-4546-a660-5e7fbb168641', N'ec0a704693d540e0bc61bcb0276c14e4', N'Phase%206%20Images/Project%20Online%20Essentials%20for%20students.png', N'Project Online Essentials for students', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'a8ce20b4-1075-4190-b6e3-5f23dfcb10d8', N'db2e705fb82a4024a3d5d88e12f2db35', N'Phase%202%20Images/Microsoft%20Intune%20Device.jpg', N'Microsoft Intune Device', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'2a2e8612-fd41-46ab-a476-5f6496df0164', N'461d7db7ec674671bf9b22efde413f0f', N'Phase4%20Images/Enterprise%20Mobility%20%2B%20Security%20E3%20(Government%20Pricing).jpg', N'Enterprise Mobility + Security E3 (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'1b8bfa96-61ea-4631-b100-5f6dba599fd6', N'f72752c83e374c9ba1a069e8442068dc', N'New%20Images%20with%20Product%20Name/Dynamics%20365%20Business%20Central%20Team%20Member.png', N'Dynamics 365 Business Central Team Member', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'e9c06e4c-3610-45f0-a94a-6028ad439b46', N'36bab559e4cc4f2b89498eda97150446', N'Phase%206%20Images/Office%20365%20Business.png', N'Office 365 Business', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'5d7c9b55-b274-4faa-ae74-61b49df96a4c', N'be57ff4c100c4f1fb82df1c5ab63a665', N'Phase%205%20Images/Office%20365%20ProPlus.png', N'Office 365 ProPlus', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'b238b2be-2729-4b8c-9063-640b3b305c72', N'9309e59fc1994a2b9fd4bc3ea0adfdea', N'Phase%205%20Images/Visio%20Online%20Plan%202%20(Nonprofit%20Staff%20Pricing).png', N'Visio Online Plan 2 (Nonprofit Staff Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'bb52e319-afde-4c7d-8d17-64d382aaf960', N'd85c876222e444c097fe27ed3fc4e61a', N'New%20Images%20with%20Product%20Name/Project%20Online%20Premium.png', N'Project Online Premium', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'dc96b58a-176a-42d1-8c2d-64f610c5aec6', N'725d513222a742d88a9b988549a565f7', N'Phase4%20Images/Dynamics%20365%20Plan%20Enterprise%20Edition.jpg', N'Dynamics 365 Plan Enterprise Edition', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'155bfab8-9883-4572-bd92-653c3dc9f692', N'9e196c649a0a435ab16ef103eff6bb91', N'Phase3%20Images/Dynamics%20365%20for%20Sales%20Enterprise%20Edition%20Qualified%20Offer%20for%20CRMOL%20Pro%20Add-On%20to%20O365%20Users.png', N'Dynamics 365 for Sales Enterprise Edition Qualified Offer for CRMOL Pro Add-On to O365 Users', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'c90febf9-c8ae-4ba6-9c57-67ac3fd38cd3', N'12fa4fd4828342f19876321c98c74962', N'Phase3%20Images/Office%20365%20Business%20Premium%20(Nonprofit%20Staff%20Pricing).png', N'Office 365 Business Premium (Nonprofit Staff Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'5ce6414b-8f68-4332-814d-692a8953056c', N'7eb5101bb8934d6392ca72df3c71fafc', N'Phase%202%20Images/Office%20365%20A3%20for%20faculty.png', N'Office 365 A3 for faculty', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'eeef41b7-e8a7-4e3b-9d44-693b2af6c6bf', N'69c67983cf78410283f63e5fd246864f', N'Phase%202%20Images/SharePoint%20Online%20(Plan%202).png', N'SharePoint Online (Plan 2)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'66dda010-809d-4bdd-9e35-69f3e96be572', N'a3a8a72399a24129bc40046e6768f7a3', N'Phase4%20Images/Project%20Online%20Professional%20for%20faculty.png', N'Project Online Professional for faculty', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'0047ae52-7172-4d9a-a897-6a0b14ce0125', N'40d28d5500064bb08f4137ac05df5dc7', N'Phase3%20Images/Domestic%20Calling%20Plan%20(120%20min).png', N'Domestic Calling Plan (120 min)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'f698a674-1bad-4764-a6b6-6a5f2b31fc79', N'4ac3982ab9a043bb96394585284702be', N'Phase%202%20Images/Office%20365%20A3%20for%20students%20use%20benefit.png', N'Office 365 A3 for students use benefit', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'03993e5e-0797-4b86-afb9-6d957896c84c', N'14c61739b45a42c0832cd330972d3173', N'New%20Images%20with%20Product%20Name/OneDrive%20for%20Business%20(Plan%202).jpg', N'Skype for Business Online Plan 2', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'c7eeffea-6f30-4f1d-a977-6eda144818cd', N'bd938f12058f4927bba3ae36b1d2501c', N'New%20Images%20with%20Product%20Name/Office%20365%20Buysiness%20Essentials.png', N'Office 365 Business Essentials', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'9358c5de-0aeb-4874-bfa8-6f36f1be3268', N'df67a19b60bc42849b2070ca4fa3c16a', N'Phase%205%20Images/Dynamics%20365%20for%20Field%20Service%2C%20Enterprise%20Edition%20-%20Resource%20Scheduling%20Optimization.jpg', N'Dynamics 365 for Field Service Enterprise Edition - Resource Scheduling Optimization', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'fff4a59a-f94a-4dce-b80b-70562cefa62b', N'6abad564ac47410494dba31e1c2729ef', N'Phase%206%20Images/Dynamics%20365%20for%20Team%20Members%20Enterprise%20Edition%20Tier%203%20(250-499%20Users).jpg', N'Dynamics 365 for Team Members Enterprise Edition Tier 3 (250-499 Users)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'10a8e060-9a11-4b70-aea4-71265aa990e0', N'3bab1b9de4e14c3094b83a6ebd4952b8', N'Phase4%20Images/Dynamics%20365%20for%20Customer%20Service%20Enterprise%20Edition%20Qualified%20Offer%20for%20CRMOL%20Pro%20Add-On%20to%20O365%20Users.jpg', N'Dynamics 365 for Customer Service Enterprise Edition Qualified Offer for CRMOL Pro Add-On to O365 Users', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'ac28ff43-ae1a-473c-94ba-736a883268e9', N'1c796fd118724f518224125e144c9a5b', N'Phase%205%20Images/Dynamics%20365%20Business%20Central%20Team%20Member%20from%20DPL%20or%20Bus%20Ed%20(Qualified%20Offer).png', N'Dynamics 365 Business Central Team Member from DPL or Bus Ed (Qualified Offer)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'b55d5d78-f4fe-4af7-9722-73cc72af49e3', N'c57a709a965a4924981684698b913c4b', N'Phase4%20Images/Dynamics%20365%20Customer%20Engagement%20Plan%20Enterprise%20Edition%20(Government%20Pricing)%20Tier%201%20(1-99%20users).jpg', N'Dynamics 365 Customer Engagement Plan Enterprise Edition (Government Pricing) Tier 1 (1-99 users)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'8bf562d4-8c56-4740-b817-74103c908804', N'98fa9c4def56448086cbb10d49effa73', N'Phase4%20Images/Power%20BI%20Pro%20for%20faculty.png', N'Power BI Pro for faculty', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'9091f503-31bd-4886-abf1-753a2d001dc9', N'78a7b9b15a304993b549fd9a1ae0bce2', N'Phase4%20Images/Dynamics%20365%20for%20Team%20Members%20Enterprise%20Edition%20Add-On%20for%20CRM%20Essentials%20(Qualified%20Offer).jpg', N'Dynamics 365 for Team Members Enterprise Edition Add-On for CRM Essentials (Qualified Offer)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'e47227f8-1c18-43ca-9755-798f93f07ac8', N'c94271d8b4314a25a3c5a57737a1c909', N'Phase%202%20Images/Audio%20Conferencing.png', N'Audio Conferencing', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'9f76e0c9-1768-4f08-a9f7-7adcf6efb2ce', N'6b648c1ef47246c0837909f50a3315e0', N'Phase3%20Images/Office%20365%20Advanced%20Compliance.jpg', N'Office 365 Advanced Compliance', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'6e16761b-4442-44d4-8356-7d8e3bf0ec26', N'5E8853ED611C4F9CAF21540BA351A636', N'Phase%205%20Images/DOMESTIC%20CALLING%20PLAN%20FOR%20FACULTY.png', N'DOMESTIC CALLING PLAN FOR FACULTY', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'd9c776c4-3f57-481c-ad77-7e8a486c2a20', N'4f01c23ac1254e94aac4e7b741c98052', N'Phase3%20Images/Dynamics%20365%20for%20Sales%20and%20Customer%20Service%2C%20Enterprise%20Edition%20(SMB%20Offer).png', N'Dynamics 365 for Sales and Customer Service, Enterprise Edition (SMB Offer)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'fb226fcf-c405-4483-815b-7f52afb91aae', N'd85c876222e444c097fe27ed3fc4e61a', N'Phase%205%20Images/Project%20Online%20Premium.png', N'Project Online Premium', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'ce8d7cd7-cabc-44e6-82f0-80f9282384d7', N'9fb981e19531402e875cc69957137939', N'Phase%205%20Images/Dynamics%20365%20for%20Sales%20Enterprise%20Edition%20Device.png', N'Dynamics 365 for Sales Enterprise Edition Device', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'b00626f0-3be2-474b-b019-85337208263c', N'3f22d04e935346c1bf48b6b0c0a55a66', N'Phase3%20Images/Visio%20Online%20Plan%201.png', N'Visio Online Plan 1', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'1eb5693a-ce3d-4c5b-9221-85eafdc0830f', N'84690799e0434de3b4bd3e6493283c92', N'Phase3%20Images/Office%20365%20Advanced%20Threat%20Protection%20(Government%20Pricing).png', N'Office 365 Advanced Threat Protection (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'0682544e-5ea6-4287-8674-86b27abb975a', N'b5df991297fb45a2bb072c65060f05cb', N'Phase%205%20Images/Dynamics%20365%20for%20Talent%2C%20Ent%20Edition%20for%20Faculty.png', N'Dynamics 365 for Talent  Ent Edition for Faculty', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'edaff626-12a3-4ffc-816b-88404a9b22a9', N'bb9c932455d142e4901445801c1fbe46', N'Phase%202%20Images/Dynamics%20365%20for%20Sales%20Enterprise%20Edition%20CRMOL%20Professional%20(Qualified%20Offer).png', N'Dynamics 365 for Sales Enterprise Edition CRMOL Professional (Qualified Offer)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'a670cf4c-d23a-4d65-ba1b-887cba8cc0d1', N'3451a3b08cda44a7bad7c30be81c4aaa', N'Phase%202%20Images/Microsoft%20365%20F1.png', N'Microsoft 365 F1', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'587009a5-fda9-4bcb-9bb2-89d8715818a2', N'70f4684593944c6e93503c0040b2eb4d', N'Phase3%20Images/Dynamics%20365%20for%20Sales%20Professional.png', N'Dynamics 365 for Sales Professional', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'65644992-ddc7-4170-aa9d-8a4ae6a5f090', N'a2706f86868d4048989b0c69e5c76b63', N'Phase%202%20Images/Office%20365%20Advanced%20Threat%20Protection.png', N'Office 365 Advanced Threat Protection', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'39a699ed-4d57-4709-9b6a-8bce2bc3791d', N'7db6d84bc060471c955a40cdc01fb945', N'Phase4%20Images/Dynamics%20365%20for%20Team%20Members%20Enterprise%20Edition%20for%20Faculty%20(SMB%20Offer).jpg', N'Dynamics 365 for Team Members Enterprise Edition for Faculty (SMB Offer) ', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'b87195c3-2e7a-4d9e-a8f8-8c87891fc0b8', N'c60e9cc57339479e8003285f6bd195c7', N'Phase%202%20Images/Office%20365%20A1%20for%20students.png', N'Office 365 A1 for students', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'a84614c3-8ecd-49fa-a179-8c986a2dd82d', N'79c29af73cd04a6fb182a81e31dec84e', N'Phase%202%20Images/Enterprise%20Mobility%20%2B%20Security%20E3.jpg', N'Enterprise Mobility + Security E3', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'157d1405-9daf-479c-a3bf-8db8fba71ddb', N'd6c7b548335144488c89144325ec4f32', N'Phase3%20Images/Microsoft%20365%20F1%20(Government%20Pricing).png', N'Microsoft 365 F1 (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'7203f424-4428-4b39-a26e-8ec04c6e8d00', N'b0b0890df5bc404e898e7b6932766528', N'Phase4%20Images/Visio%20Online%20Plan%202%20(Government%20Pricing).png', N'Visio Online Plan 2 (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'd817128e-2575-412e-9a63-8fdbe5741323', N'BEC91CBF367741E3AFB8BF98DB7B9BD4', N'Phase3%20Images/WINDOWS%2010%20ENTERPRISE%20A3%20FOR%20FACULTY.png', N'WINDOWS 10 ENTERPRISE A3 FOR FACULTY', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'505f7a48-10e6-4c81-8855-947c1cd37473', N'83dca3b93d6c45478c5fba1f69b130f8', N'Phase%202%20Images/Office%20365%20Enterprise%20E1%20(Nonprofit%20Staff%20Pricing).jpg', N'Office 365 Enterprise E1 (Nonprofit Staff Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'bf82ea05-a44d-4125-ad7b-9530fac407a0', N'e64090724dc442e892c1a24abed5d524', N'Phase%206%20Images/Enterprise%20Mobility%20%2B%20Security%20E3%20(Nonprofit%20Staff%20Pricing).jpg', N'Enterprise Mobility + Security E3 (Nonprofit Staff Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'995f92a5-c8b0-4299-b43f-995d70931d7b', N'61795cab2abd43f688e9c9adae5746e0', N'New%20Images%20with%20Product%20Name/Microsoft%20365%20Business.png', N'Microsoft 365 Business', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'3a7ddef0-ad60-4ab9-88fa-99e1326bbd4f', N'512e27aa19d14c38b2cb5813375c8201', N'Phase%202%20Images/Office%20365%20A1%20for%20faculty.png', N'Office 365 A1 for faculty', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'6051623d-b36c-4829-8b13-9a4bf41a9fb7', N'3dd9350b27d6450193a4c8d107f1de47', N'Phase%205%20Images/Microsoft%20Flow%20Plan%201.png', N'Microsoft Flow Plan 1', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'28bce5a8-6fcf-471b-89a1-9b469fc125c2', N'0f598efef3304d79b79fc9480bb7ce3e', N'Phase%202%20Images/Domestic%20Calling%20Plan.png', N'Domestic Calling Plan', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'25af6fde-3969-4e20-8a55-9b8a3ac0c20f', N'91fd106f4b2c493895acf54f74e9a239', N'Phase%206%20Images/Office%20365%20Enterprise%20E1.png', N'Office 365 Enterprise E1', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'9c6d3420-ca7c-4afe-8b1b-9bb115c2fac0', N'9b7e5904c73f4d26bc83ad5b7f21409b', N'Phase4%20Images/Office%20365%20Advanced%20Threat%20Protection%20(Nonprofit%20Staff%20Pricing).png', N'Office 365 Advanced Threat Protection (Nonprofit Staff Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'3038b3e9-3900-4d1d-8fd4-9cfce3f7d69d', N'ced5f6932d4040ae88489809ab1b0ee9', N'Phase4%20Images/Intune%20Extra%20Storage.png', N'Intune Extra Storage', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'99e8f6f2-b515-4832-8c0d-9e4842ba32bf', N'cfe0bb2db53942289c5c97c1cee84fe0', N'Phase3%20Images/Dynamics%20365%20Customer%20Engagement%20Plan%20Enterprise%20Edition%20for%20Faculty%20Tier%201%20(1-99%20users).jpg', N'Dynamics 365 Customer Engagement Plan Enterprise Edition for Faculty Tier 1 (1-99 users) ', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'110ada40-ffae-44c8-aaeb-9e541ebbfa3d', N'f6ff8458159f4a9995184bb58ee6205f', N'Phase4%20Images/Dynamics%20365%20Customer%20Engagement%20Plan%20Enterprise%20Edition%20for%20Faculty%20From%20SA%20for%20CRM%20Pro%20(Qualified%20Offer).jpg', N'Dynamics 365 Customer Engagement Plan Enterprise Edition for Faculty From SA for CRM Pro (Qualified Offer) ', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'b4480920-5465-4f6b-b006-9f552bcde2b6', N'30c8f7848eb946e6bf69a8fae07022e4', N'Phase%206%20Images/Project%20Online%20Essentials%20for%20faculty.png', N'Project Online Essentials for faculty', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'37396276-7048-4c7f-abb3-9f7a0d87346b', N'aca0c06c890d4abb83cfbc519a2565e5', N'Phase%202%20Images/Skype%20for%20Business%20Online%20(Plan%201).png', N'Skype for Business Online (Plan 1)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'43ce2286-18e8-4178-a4b6-9f9deaff151a', N'3396e762af9642f1bea45c97a1efa94f', N'Phase4%20Images/Dynamics%20365%20Enterprise%20Edition%20-%20Additional%20Non-Production%20Instance.jpg', N'Dynamics 365 Enterprise Edition - Additional Non-Production Instance', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'cabbf8b4-28ea-4068-94b9-a057f0aae805', N'35a36b80270a44bf929000545d350866', N'Phase%205%20Images/Exchange%20Online%20Kiosk.jpg', N'Exchange Online Kiosk', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'46deec61-4bcf-4f0b-a9cd-a1e718a38e61', N'04e69be93bf044618eeec83dae1439c8', N'Phase4%20Images/Dynamics%20365%20Customer%20Engagement%20Plan%20Enterprise%20Edition%20CRMOL%20Basic%20(Qualified%20Offer).jpg', N'Dynamics 365 Customer Engagement Plan Enterprise Edition CRMOL Basic (Qualified Offer)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'dc440923-4759-4539-aa74-a32b94b8988b', N'10d1f0710c9842548ca35bf13d771e3d', N'Phase%202%20Images/Microsoft%20365%20A3%20for%20students%20use%20benefit.png', N'Microsoft 365 A3 for students use benefit', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'2e81008d-cbf1-4025-a7e9-a3b3d2d58535', N'efe1183a8fa04138bf0a5ae271ab6e3c', N'Phase%205%20Images/Office%20365%20Threat%20Intelligence.png', N'Office 365 Threat Intelligence', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'f71e058a-48a9-404e-9ec5-a54b4813733c', N'a6acbc1c9d2a482aabdadfb9285e301e', N'Phase%206%20Images/Power%20BI%20Pro%20(Government%20Pricing).png', N'Power BI Pro (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'c0dc012e-fdff-40c1-9c69-a6553dc21bc4', N'ed617729445644c1b094563c938a760f', N'Phase%206%20Images/Dynamics%20365%20for%20Sales%20Enterprise%20Edition%20(Government%20Pricing).png', N'Dynamics 365 for Sales Enterprise Edition (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'589f7018-2225-4bb5-a533-a659ca9ad5d3', N'8bdbb60be52643e992efab760c8e0b72', N'Phase3%20Images/Microsoft%20365%20E5.png', N'Microsoft 365 E5', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'11bdba28-0a67-496b-b053-a6782521ca58', N'fb33e24a349a4ed2868bc5492381fb5c', N'Phase%206%20Images/Dynamics%20365%20for%20Sales%20Enterprise%20Edition%20for%20Faculty%20CRMOL%20Professional%20(Qualified%20Offer).png', N'Dynamics 365 for Sales Enterprise Edition for Faculty CRMOL Professional (Qualified Offer) ', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'09e41671-cc5d-48fc-b3e3-a7b384fe6de5', N'4f7ecaf1e9d64cac9687e22eb3dfdd70', N'Phase4%20Images/Office%20365%20Enterprise%20E5%20without%20Audio%20Conferencing.png', N'Office 365 Enterprise E5 without Audio Conferencing', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'3ae532df-d7aa-479f-a91a-a97f9debee8a', N'cb0387306cbe47b9afd4ca7fa5d0c39b', N'New%20Images%20with%20Product%20Name/Exchange%20Online%20Archiving%20for%20Exchange%20Online%20(Government%20Pricing).png', N'Exchange Online Archiving for Exchange Online Government Pricing', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'1d7e3a6c-25c7-4c1b-aa11-aa7cf6258f05', N'5c9fd4ccedce44a88e9107df09744609', N'Phase%205%20Images/Office%20365%20Business.png', N'Office 365 Business', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'c4435096-1361-4e99-b74f-aa864661996a', N'61795cab2abd43f688e9c9adae5746e0', N'Phase%206%20Images/Microsoft%20365%20Business.png', N'Microsoft 365 Business', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'5992b6cc-a114-4d0b-9670-acfea12a54c2', N'51e95709dc354780904022278cb7c0e1', N'New%20Images%20with%20Product%20Name/Microsoft%20InTune.jpg', N'Microsoft InTune', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'81553072-a535-4211-8877-b2e594f14659', N'05933b8304d14ac6bfcddbbbfc834483', N'Phase%202%20Images/Business%20Apps%20(free).png', N'Business Apps (free)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'185c528a-5200-4a1a-a9d3-b40eb64a9f32', N'0cca44d668e9476294ee31ece98783b9', N'20Images/Exchange%20Online%20Protection%20(Government%20Pricing).png?raw=true', N'Exchange Online Protection (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'8885dd3d-26f4-4e7f-ba39-b41e067ef0fc', N'cf4d7d0dd6ed4a5cbd02c73dd1844575', N'Phase%205%20Images/Dynamics%20365%20for%20Finance%20and%20Operations%20Business%20Edition.png', N'Dynamics 365 for Finance and Operations Business Edition', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'c4633a45-7d5f-4c00-b79b-b81ac12ce820', N'a56baa74d4e349fdb228ca0b62d08bad', N'Phase%202%20Images/Project%20Online%20Professional.png', N'Project Online Professional', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'f48e76b1-089f-462f-ad23-b8b06d0ba35d', N'331E415094DF45178D5C9346DEEA7665', N'Phase%205%20Images/PHONE%20SYSTEM%20FOR%20FACULTY.png', N'PHONE SYSTEM FOR FACULTY', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'5c0e3b86-e5ac-4b0a-a3de-baae340da2b3', N'1f1d89ab6c524a16a9b6b358edb27aab', N'Phase%205%20Images/Project%20Online%20Premium%20without%20Project%20Client.png', N'Project Online Premium without Project Client', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'a97d82e0-c718-45d1-97c6-bb04d001fbf9', N'0198ee56db844f71a798f5a497ce20d6', N'Phase4%20Images/Visio%20Online%20Plan%202%20for%20faculty.png', N'Visio Online Plan 2 for faculty', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'1ea90608-bd86-4732-9343-bc7612d2a733', N'2f707c7c243349a5a4379ca7cf40d3eb', N'New%20Images%20with%20Product%20Name/Exchange%20Online%20(Plan%202).png', N'Exchange Online Plan 2', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'abca5cfd-bd76-4481-bb32-bd6594ce38f3', N'dbd1035156314a01a64300e8ff14e7b2', N'Phase4%20Images/Microsoft%20Cloud%20App%20Security.png', N'Microsoft Cloud App Security', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'6ccfe302-7acf-4c2a-a049-be3a228cffa2', N'348c75ca8a294cfa98701dbcee3fdbd2', N'Phase%202%20Images/Windows%2010%20Enterprise%20E3%20(local%20only).jpg', N'Windows 10 Enterprise E3 (local only)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'5c39e49a-e6b1-4e17-a269-beb9ab4223d8', N'5f86062eb7a4497fbfcb2b8899d66651', N'Phase4%20Images/Dynamics%20365%20Business%20Central%20Premium%20from%20DPL%20or%20Bus%20Ed%20(Qualified%20Offer).png', N'Dynamics 365 Business Central Premium from DPL or Bus Ed (Qualified Offer)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'c1df4e94-f588-4a5d-aee9-bf1829871b58', N'fbf0328a8b0f47a69483dc2b36183fce', N'Phase%202%20Images/Dynamics%20365%20Enterprise%20Edition%20-%20Additional%20Database%20Storage.jpg', N'Dynamics 365 Enterprise Edition - Additional Database Storage', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'6f8447bc-3cdb-444a-875c-c56a76871b72', N'30e97275fad848d4bc0a81840365c119', N'Phase%205%20Images/Dynamics%20365%20Business%20Central%20External%20Accountant.png', N'Dynamics 365 Business Central Premium', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'56aa8f75-638d-4cab-a98b-c5a2527ae296', N'51e95709dc354780904022278cb7c0e1', N'Phase%206%20Images/Intune.png', N'Intune', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'99ab36f4-9a9e-49b7-84d9-c720bdce3e6a', N'031c9e4748024248838e778fb1d2cc05', N'Phase%205%20Images/Office%20365%20Business%20Premium.png', N'Office 365 Business Premium', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'8f91fb0f-b696-4ea4-b723-c89122cb5226', N'996EE1BAD999497B89858E19F7D3334E', N'Phase%205%20Images/MICROSOFT%20365%20BUSINESS%20(NONPROFIT%20STAFF%20PRICING).png', N'MICROSOFT 365 BUSINESS (NONPROFIT STAFF PRICING)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'3c9917c2-0b04-4a5b-a677-c89d6c7ebbcc', N'512f56e69f9443458a5bfb74420c7857', N'Phase%206%20Images/Dynamics%20365%20for%20Sales%20Enterprise%20Edition%20for%20Faculty.jpg', N'Dynamics 365 for Sales Enterprise Edition for Faculty', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'ad0fc2c0-77aa-4d3e-b3d4-caf7b6c9be79', N'16e05c5cb53642a0a26ed920c267d723', N'Phase4%20Images/Dynamics%20365%20for%20Operations%2C%20Ent%20Edition%20device.png', N'Dynamics 365 for Operations, Ent Edition device', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'c01c12a8-c891-436a-adb6-cbbfccadc740', N'5392a891cf7a47c2abf2e9d131cad575', N'Phase3%20Images/Office%20365%20Business%20Essentials%20(Nonprofit%20Staff%20Pricing).png', N'Office 365 Business Essentials (Nonprofit Staff Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'aa005885-0af7-4cb4-a578-cbd7be8e23c0', N'ff7a4f5b497342418c4380f2be39311d', N'Phase%202%20Images/SharePoint%20Online%20(Plan%201).png', N'SharePoint Online (Plan 1)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'7fc59882-7c09-4930-a59c-cd20a41249ed', N'93FF54BA3CC54DFA9E7CF2B9B49E3FB5', N'Phase%202%20Images/MICROSOFT%20INTUNE%20FOR%20EDUCATION%20FOR%20FACULTY%20SUB%20LICENSE%20ADD-ON.jpg', N'MICROSOFT INTUNE FOR EDUCATION FOR FACULTY SUB LICENSE ADD-ON', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'a6d05906-f671-4256-b7be-cd3b0950ff33', N'bb30b48653be4ecfbb856f50979f0579', N'Phase3%20Images/Dynamics%20365%20Customer%20Engagement%20Plan%20Enterprise%20Edition%20Tier%201%20(1-99%20users).jpg', N'Dynamics 365 Customer Engagement Plan Enterprise Edition Tier 1 (1-99 users)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'2ebbf32e-dcfd-4f56-9bc4-cf381b6cf5bb', N'349fc43df26247039f469b030fb9a6f9', N'Phase%206%20Images/Dynamics%20365%20Customer%20Engagement%20Plan%20Enterprise%20Edition%20Tier%202%20(100-249%20Users).jpg', N'Dynamics 365 Customer Engagement Plan Enterprise Edition Tier 2 (100-249 Users)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'6b3af380-a731-4cc9-9f29-d04264f050cc', N'405D71A7D6A04E80B6ED98D7DBA00DEF', N'Phase%205%20Images/PROJECT%20ONLINE%20PREMIUM%20(GOVERNMENT%20PRICING).png', N'PROJECT ONLINE PREMIUM (GOVERNMENT PRICING)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'0f374a18-e288-4037-815b-d1f2dd5dc831', N'4443cb9e651e4295be7c5bc89d1e3916', N'Phase3%20Images/Microsoft%20Dynamics%20CRM%20Online%20Add-On%20to%20Office%20365.png', N'Microsoft Dynamics CRM Online Add-On to Office 365', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'28c7a843-93cd-4a7d-a0a3-d30040d68dd7', N'aa98032c5403472fb24ff6654846b15d', N'Phase4%20Images/Office%20365%20Business%20Premium%20(Syndication%20Transition).png', N'Office 365 Business Premium (Syndication Transition)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'67bd86fd-64c8-439e-a91a-d3856a6ecc16', N'd3bca131477247bc9c2ee4040f82268c', N'Phase%202%20Images/Project%20For%20Office%20365.PNG', N'Project for Office 365', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'28d15a46-7848-4373-9dc1-d3b08b84c20f', N'63e05d17a2724bfca847313b16002a9a', N'Phase%202%20Images/Enterprise%20Mobility%20%2B%20Security%20E5%20for%20Faculty.jpg', N'Enterprise Mobility + Security E5 for Faculty', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'022f5b91-e95a-4989-acf3-d4df3285832e', N'8b81ff1a72804bba827d265dc702c583', N'Phase%202%20Images/Dynamics%20365%20for%20Team%20Members%20Enterprise%20Edition%20(SMB%20Offer).jpg', N'Dynamics 365 for Sales Enterprise Edition (SMB Offer)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'01bd726f-64a4-4b7b-815d-d58d316c6d77', N'921cb1b8a2894437a0b811104bcc3cba', N'Phase4%20Images/Microsoft%20Dynamics%20CRM%20Online.png', N'Microsoft Dynamics CRM Online', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'a302497e-af88-46d8-b811-d61ff359879f', N'b2016e73d9ad4758b8b8d5c001bdf411', N'Phase4%20Images/Office%20365%20Business%20Essentials%20(Syndication%20Transition).png', N'Office 365 Business Essentials (Syndication Transition)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'a8e1e346-db49-40f8-b060-d6ae5a888903', N'10a0470dfbd44a4c907589af0c24414d', N'Phase%206%20Images/Windows%2010%20Enterprise%20A3%20for%20students.png', N'Windows 10 Enterprise A3 for students', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'53209325-f6d9-4778-9de4-d6be75c94c42', N'a6c5a40070b4458faaf9dade77a70418', N'Phase%202%20Images/Dynamics%20365%20for%20Team%20Members%20Enterprise%20Edition.jpg', N'Dynamics 365 for Team Members Enterprise Edition', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'146fa799-1a14-4a63-b69f-d864acfd7f32', N'39a723969c4346e28bb9efef342c8f76', N'Phase4%20Images/Microsoft%20Flow%20Plan%202.png', N'Microsoft Flow Plan 2', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'cb46397c-90db-46db-9644-d903e59a674d', N'a4179d30cc0949f0977edc2cb70b874f', N'Phase3%20Images/Project%20Online%20Essentials.png', N'Project Online Essentials', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'a23c1ff4-6afc-479e-ac55-da991b2766a4', N'8c484fd01f3f44fbb6d226ca107273f6', N'New%20Images%20with%20Product%20Name/Office%20365%20A5%20for%20faculty.png', N'Office 365 A5 for faculty', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'c0265021-7d9b-4d19-a325-dc76fc0bfa30', N'6ce1ccc88b184e1ba1c4f89de9904389', N'Phase%205%20Images/Office%20365%20F1%20(Government%20Pricing).png', N'Office 365 F1 (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'5b8e3709-a755-4b2c-acf9-de0a1cb712df', N'41bc6d75e7b94bd8a91afdee2f5f8af5', N'Phase4%20Images/Microsoft%20365%20Business%20Pilot.png', N'Microsoft 365 Business Pilot', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'8516e52a-189c-490a-a500-de0f0d9449b2', N'9c584cf183264ff48a230a833ddbcab0', N'Phase3%20Images/Microsoft%20365%20A3%20for%20faculty.png', N'Microsoft 365 A3 for faculty', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'bc2e0367-a046-4322-b32e-dff2349d9e90', N'80FC6C74CC94478D97B08455593A5987', N'Phase%205%20Images/DOMESTIC%20CALLING%20PLAN%20(120%20MIN)%20FOR%20FACULTY.png', N'DOMESTIC CALLING PLAN (120 MIN) FOR FACULTY', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'a5b9d961-14e3-487c-8ceb-e00178a253ca', N'8f827dc95d954321b4b3a0ee086d02a3', N'Phase4%20Images/OneDrive%20for%20Business%20(Plan%201)%20(Government%20Pricing).png', N'OneDrive for Business (Plan 1) (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'1d63cb6c-44bd-41a0-ae19-e33bb15887a4', N'2b3b8d2d10aa4be4b5fd7f2feb0c3091', N'Phase%202%20Images/Microsoft%20365%20E3.png', N'Microsoft 365 E3', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'836bbcb6-5a5a-43c4-9361-e38cc947f247', N'71c5d4a8a6b54fe6a4110c3cf35dae81', N'Phase%205%20Images/Dynamics%20365%20Customer%20Engagement%20Plan%20Enterprise%20Edition%20From%20SA%20for%20CRM%20Pro%20(Qualified%20Offer).jpg', N'Dynamics 365 Customer Engagement Plan Enterprise Edition From SA for CRM Pro (Qualified Offer)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'781f0538-68d8-4b61-bf6a-e475dbd1ca3b', N'f7f342b3177c41f288967b06c54fc977', N'Phase%206%20Images/Windows%2010%20Enterprise%20E5.png', N'Windows 10 Enterprise E5', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'e1b60629-5cb1-4331-8c15-e509dc98f637', N'2d691bc1f5cb4639836a04af74bb1eb5', N'Phase%205%20Images/Dynamics%20365%20Customer%20Engagement%20Plan%20Enterprise%20Edition%20From%20SA%20for%20CRM%20Basic%20(Qualified%20Offer).jpg', N'Dynamics 365 Customer Engagement Plan Enterprise Edition From SA for CRM Basic (Qualified Offer)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'79a3ad3c-710e-4af5-8ea5-e52563970320', N'e5aeedc5e2f04099aa4595802034d7f8', N'Phase%202%20Images/Dynamics%20365%20for%20Sales%20Enterprise%20Edition.png', N'Dynamics 365 for Sales Enterprise Edition', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'7f39fd26-1e29-463f-a9fd-e53e6a16bd82', N'b4d4b7f4408943b69c44de97b760fb11', N'Phase%202%20Images/Visio%20Online%20Plan%202.PNG', N'Visio Online Plan 2', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'3ed27b2c-7af0-4577-b3e2-e5fdee8fab70', N'd55a6d588bd04732bda4b03b4786eaf4', N'Phase%206%20Images/Dynamics%20365%20Unf%20Ops%20Plan%2C%20Ent%20Edition%20From%20SA%20From%20AX%20Ent%20Func%20(Qualified%20Offer).jpg', N'Dynamics 365 Unf Ops Plan Ent Edition From SA From AX Ent/Func (Qualified Offer)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'fdd8ceb9-eb30-4ef7-b7c3-e7cce8a4379f', N'844b77b73c4442bb9d29aefd8be7e093', N'Phase4%20Images/Enterprise%20Mobility%20%2B%20Security%20E5%20for%20Students.jpg', N'Enterprise Mobility + Security E5 for Students', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'bf4c8001-ef93-42c0-80e9-eb4fc6a6d5c3', N'22b61e04b7eb44059cb36a4407b9f95a', N'Phase3%20Images/Exchange%20Online%20Kiosk%20(Government%20Pricing).jpg', N'Exchange Online Kiosk (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'026ea7c1-be32-4155-b83e-ed9698cce4e1', N'9344b43b3b9d45ab8f88b258a0e7d283', N'Phase4%20Images/SharePoint%20Online%20(Plan%202)%20(Government%20Pricing).png', N'SharePoint Online (Plan 2) (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'60cfe038-c761-45cf-8330-edeccea8d80b', N'5699c6f3cc7a421290428f85ce30f4e0', N'Phase3%20Images/Office%20365%20ProPlus%20for%20students.png', N'Office 365 ProPlus for students', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'8710c924-29d8-40d7-8ae2-ee0a9ac950fa', N'ae1d079828fa44608c67c09b3ac7133d', N'Phase3%20Images/Skype%20for%20Business%20Online%20(Plan%201)%20(Government%20Pricing).png', N'Skype for Business Online (Plan 1) (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'5262d61c-9bc7-464c-9791-ee7f05229806', N'53fc25f766394f78bb443c2dfec3ed40', N'Phase%202%20Images/Office%20365%20Extra%20File%20Storage.png', N'Office 365 Extra File Storage', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'10f38f81-84da-40ab-b8aa-eec28c8aa621', N'dd3b57a351834ff89e3c321f4298b58d', N'Phase4%20Images/Microsoft%20365%20A3%20for%20students.png', N'Microsoft 365 A3 for students', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'329efb5d-c583-42ad-85b2-ef333392d180', N'2d2144e5ad6b4a0bbbaabf959eb23df5', N'Phase4%20Images/Dynamics%20365%20for%20Sales%20Professional%20CRMOL%20Basic%20(Qualified%20Offer).png', N'Dynamics 365 for Sales Professional CRMOL Basic (Qualified Offer)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'bfcfd844-d0c3-47fa-a186-f2070adf11bd', N'd27f14dfaece49bdb769d4e28a24963e', N'Phase3%20Images/Office%20365%20Enterprise%20E3%20(Nonprofit%20Staff%20Pricing).png', N'Office 365 Enterprise E3 (Nonprofit Staff Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'82b6b560-28c0-415e-8070-f297191c0636', N'796b6b5f613c4e24a17ceba730d49c02', N'New%20Images%20with%20Product%20Name/Office%20365%20Enterprise%20E3.png', N'Office 365 Enterprise E3', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'a3f6182a-58b3-4325-87d4-f2fa2be66068', N'696a7e6b401749b989d6028e9d1aeb26', N'Phase3%20Images/Dynamics%20365%20Customer%20Engagement%20Plan%20Enterprise%20Edition%20for%20Faculty%20CRMOL%20Professional%20(Qualified%20Offer).jpg', N'Dynamics 365 Customer Engagement Plan Enterprise Edition CRMOL Professional (Qualified Offer)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'ef5c5d8b-be28-48f9-b91b-f425312d3a2a', N'ded34535507f42468370f9180318c537', N'Phase3%20Images/Domestic%20%26%20International%20Calling%20Plan.PNG', N'Domestic and International Calling Plan', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'377aa605-e597-4433-81d9-f51810fa3a6a', N'6130626ebee04e768abbe919b0ec9483', N'Phase%205%20Images/Dynamics%20365%20for%20Operations%20Activity%2C%20Ent%20Edition.png', N'Dynamics 365 for Operations Activity Ent Edition', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'0d47709b-3823-4c68-8ca5-f51c6698037d', N'bf1f69071f8e4f05b3274896d1395c15', N'New%20Images%20with%20Product%20Name/Skype%20for%20Business%20Online%20(Plan%202).jpg', N'OneDrive for Business Plan 2', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'acfbdcaa-e179-4391-bef4-f6db5fc922b5', N'45320ec99b8e49d0b900f14141a0abd1', N'Phase4%20Images/Microsoft%20MyAnalytics.png', N'Microsoft MyAnalytics', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'1d278651-6587-49be-8d67-f82a56d23ce6', N'57b722c2c4354bfb9bc880509213a13a', N'Phase%206%20Images/Microsoft%20365%20F1%20(Nonprofit%20Staff%20Pricing).png', N'Microsoft 365 F1 (Nonprofit Staff Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'fdcf74f9-272e-4755-b87e-f8bf3ebbdccd', N'2bd75585880a432590606a12cf002c97', N'Phase%205%20Images/Enterprise%20Mobility%20%2B%20Security%20E3%20for%20Students.jpg', N'Enterprise Mobility + Security E3 for Students', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'bb42332e-b241-4225-8056-f981341b6ac2', N'a536b3a814814633adfed7356f6f4188', N'Phase3%20Images/Dynamics%20365%20for%20Sales%20Enterprise%20Edition%20CRMOL%20Basic%20(Qualified%20Offer).png', N'Dynamics 365 for Sales Enterprise Edition CRMOL Basic (Qualified Offer)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'b4c07a4a-d8ca-49fd-9365-fa091f6f9fc2', N'3ea7e32065e245f0abf56f6fabb2255b', N'Phase3%20Images/Office%20365%20Extra%20File%20Storage%20(Government%20Pricing).png', N'Office 365 Extra File Storage (Government Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'3da96456-7568-44bd-8abe-fa51e0fede00', N'6fbad345b7de42a6b6ab79b363d0b371', N'Phase%205%20Images/Office%20365%20F1.png', N'Office 365 F1', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'84498e05-69c7-4414-8726-fa865e55c089', N'e9251d030fe342d7847ac2fe1c84542e', N'Phase%206%20Images/Office%20365%20ProPlus%20(Nonprofit%20Staff%20Pricing).png', N'Office 365 ProPlus (Nonprofit Staff Pricing)', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'ed26a51f-6fd6-4dcb-813f-fb4b48cc1b05', N'6A261AFF44C544A4B76641E3E7AAE7E3', N'Phase3%20Images/MICROSOFT%20INTUNE%20FOR%20FACULTY.jpg', N'MICROSOFT INTUNE FOR FACULTY', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'7b13d842-c578-4097-b72e-fd23112e78e7', N'58cd657367844467b2fc1a06bb874ed6', N'Phase4%20Images/Dynamics%20365%20for%20Customer%20Service%20Enterprise%20Edition.jpg', N'Dynamics 365 for Customer Service Enterprise Edition', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'3c894125-d269-403d-ab78-fe2d19ef6ef9', N'2bcf9fe88b654fcf9240419203fb8cf4', N'Phase4%20Images/Dynamics%20365%20Enterprise%20Edition%20-%20Additional%20Production%20Instance.jpg', N'Dynamics 365 Enterprise Edition - Additional Production Instance', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'9d511c2b-29e9-4832-b3bf-fee7f6760edf', N'615cbbc10b6c43fa99c5ada5a0965500', N'Phase%205%20Images/Dynamics%20365%20for%20Operations%2C%20Enterprise%20Edition%20-%20Sandbox%20Tier%202%20Standard%20Acceptance%20Testing.png', N'Dynamics 365 for Operations Enterprise Edition - Sandbox Tier 2:Standard Acceptance Testing', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'd49e0fb1-f32a-4a8e-8d06-ff6562971a98', N'1b6263c0b8fd470698db89d2ace5c1bf', N'Phase3%20Images/Office%20365%20A3%20for%20students.png', N'Office 365 A3 for students', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'e41ddb43-af73-4116-a774-ff82f20a5708', N'ddbae3c0f8834823a1e94ffa47ab0c5b', N'Phase%205%20Images/Dynamics%20365%20for%20Operations%2C%20Enterprise%20Edition%20-%20Sandbox%20Tier%201%20Developer%20%26%20Test%20Instance.png', N'Dynamics 365 for Operations Enterprise Edition - Sandbox Tier 1:Developer & Test Instance', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'42f77ce0-387e-41a5-928c-ff855bde783f', N'df406c185deb4f8b9af30f743fffedc9', N'Phase%205%20Images/Dynamics%20365%20for%20Project%20Service%20Automation%20Enterprise%20Edition.png', N'Dynamics 365 for Project Service Automation Enterprise Edition', N'Microsoft')
INSERT [dbo].[ImageLibrary] ([UniqueId], [ManufacturingPartNumber], [ImageUrl], [SkuName], [VendorName]) VALUES (N'ad8bb2fb-5681-4997-9e82-fff3442827f7', N'bd938f12058f4927bba3ae36b1d2501c', N'Phase%205%20Images/Office%20365%20Business%20Essentials.png', N'Office 365 Business Essentials', N'Microsoft')



IF NOT EXISTS(SELECT * FROM sys.indexes WHERE name = 'RoleNameIndex' AND object_id = OBJECT_ID('AspNetRoles'))
    BEGIN
        -- Index with this name, on this table does NOT exist
   
	SET ANSI_PADDING ON
	/****** Object:  Index [RoleNameIndex]    Script Date: 6/12/2018 11:32:59 AM ******/
	CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
	(
		[Name] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
 END		

IF NOT EXISTS(SELECT * FROM sys.indexes WHERE name = 'IX_UserId' AND object_id = OBJECT_ID('AspNetUserClaims'))
    BEGIN
	SET ANSI_PADDING ON
	/****** Object:  Index [IX_UserId]    Script Date: 6/12/2018 11:32:59 AM ******/
	CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
	(
		[UserId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	End

IF NOT EXISTS(SELECT * FROM sys.indexes WHERE name = 'IX_UserId' AND object_id = OBJECT_ID('AspNetUserLogins'))
    BEGIN
	SET ANSI_PADDING ON
	
	
	/****** Object:  Index [IX_UserId]    Script Date: 6/12/2018 11:32:59 AM ******/
	CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
	(
		[UserId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	End

IF NOT EXISTS(SELECT * FROM sys.indexes WHERE name = 'IX_RoleId' AND object_id = OBJECT_ID('AspNetUserRoles'))
    BEGIN
	SET ANSI_PADDING ON
	/****** Object:  Index [IX_RoleId]    Script Date: 6/12/2018 11:32:59 AM ******/
	CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]
	(
		[RoleId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	End

IF NOT EXISTS(SELECT * FROM sys.indexes WHERE name = 'IX_UserId' AND object_id = OBJECT_ID('AspNetUserRoles'))
    BEGIN
	SET ANSI_PADDING ON
	/****** Object:  Index [IX_UserId]    Script Date: 6/12/2018 11:32:59 AM ******/
	CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]
	(
		[UserId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	End

IF NOT EXISTS(SELECT * FROM sys.indexes WHERE name = 'UserNameIndex' AND object_id = OBJECT_ID('AspNetUsers'))
    BEGIN
	SET ANSI_PADDING ON
	/****** Object:  Index [UserNameIndex]    Script Date: 6/12/2018 11:32:59 AM ******/
	CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
	(
		[UserName] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	End


	

IF  EXISTS (SELECT *  FROM sys.foreign_keys WHERE name = (N'FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId') AND parent_object_id = OBJECT_ID(N'dbo.AspNetUserClaims'))
BEGIN
		
		    ALTER TABLE dbo.AspNetUserClaims DROP CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
END

			ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
			REFERENCES [dbo].[AspNetUsers] ([Id])
			ON DELETE CASCADE
			
			ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]



IF  EXISTS (SELECT *  FROM sys.foreign_keys WHERE name = (N'FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId') AND parent_object_id = OBJECT_ID(N'dbo.AspNetUserLogins'))
BEGIN
			ALTER TABLE dbo.AspNetUserLogins DROP CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
end
			ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
			REFERENCES [dbo].[AspNetUsers] ([Id])
			ON DELETE CASCADE
			
			ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]



IF  EXISTS (SELECT *  FROM sys.foreign_keys WHERE name = (N'FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId') AND parent_object_id = OBJECT_ID(N'dbo.AspNetUserRoles'))
BEGIN
			ALTER TABLE dbo.AspNetUserRoles DROP CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
end


			ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
			REFERENCES [dbo].[AspNetRoles] ([Id])
			ON DELETE CASCADE
			
			ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]


IF  EXISTS (SELECT *  FROM sys.foreign_keys WHERE name = (N'FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId') AND parent_object_id = OBJECT_ID(N'dbo.AspNetUserRoles'))
BEGIN
			ALTER TABLE dbo.AspNetUserRoles DROP CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
end

			ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
			REFERENCES [dbo].[AspNetUsers] ([Id])
			ON DELETE CASCADE
			
			ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]	
	
/****** Object:  StoredProcedure [dbo].[procGetEndUserCompany]    Script Date: 6/12/2018 11:32:59 AM ******/

IF OBJECT_ID('procGetEndUserCompany') IS not NULL

/****** Object:  StoredProcedure [dbo].[procGetEndUserCompany]    Script Date: 7/26/2018 5:06:23 PM ******/
DROP PROCEDURE [dbo].[procGetEndUserCompany]

GO

/****** Object:  StoredProcedure [dbo].[procGetEndUserCompany]    Script Date: 7/26/2018 5:06:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[procGetEndUserCompany]
	@Email nvarchar(50)
AS
BEGIN
	select C.[Name], C.EndCustomerId 
		from Company C INNER JOIN Enduser EU
			on C.Name=EU.CompanyName
	where EU.Email = @Email
END
	
GO

/****** Object:  StoredProcedure [dbo].[procGetCompanySalesOrders]    Script Date: 6/12/2018 11:32:59 AM ******/

IF OBJECT_ID('procGetCompanySalesOrders') IS not NULL

/****** Object:  StoredProcedure [dbo].[procGetCompanySalesOrders]    Script Date: 7/26/2018 5:06:23 PM ******/
DROP PROCEDURE [dbo].[procGetCompanySalesOrders]

GO

/****** Object:  StoredProcedure [dbo].[procGetCompanySalesOrders]    Script Date: 7/26/2018 5:06:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


	CREATE procedure [dbo].[procGetCompanySalesOrders]
	
		@CompanyId numeric(18,0),
		@EndUser nvarchar(100),
		@SalesOrderNo nvarchar(100),
		@rowCount int,
		@Pageno int
	
	as
	
	begin
	declare @fromRow as int,@TotalRecords as int
									
	set @fromRow=@rowCount*@Pageno 
	
	Declare @temp table(
		companyId int
		)
	
	Insert into @temp
	Select CompanyId
	From EndUser
	Where Email like '%'+@EndUser + '%' or name like '%'+@EndUser + '%'
	
	If (IsNull(@EndUser,'')> '')
	Begin
		
		Set @CompanyId = -1
	End
	
	select	@TotalRecords = COUNT(C.CompanyId)
	From Company C , CompanyOrder S	
	Where C.CompanyId = S.CompanyId and
		(IsNUll(@CompanyId,0) = 0 or (C.CompanyId = @CompanyId or C.CompanyId in (select CompanyId from @temp))) and
		(IsNUll(@SalesOrderNo,'') = '' or S.SalesOrderId like '%' + @SalesOrderNo +'%') 
	
	select * from(
				select  ROW_NUMBER() over (order by C.Name) Row, C.Name CompanyName, S.SalesOrderId, C.CompanyId, RecordId, S.Created , S.CreatedBy,@TotalRecords TotalRecords
				From     CompanyOrder S	Left Join Company C
				on   S.CompanyId = C.CompanyId
				Where C.CompanyId = S.CompanyId and
					(IsNUll(@CompanyId,0) = 0 or (C.CompanyId = @CompanyId or C.CompanyId in (select CompanyId from @temp))) and
					(IsNUll(@SalesOrderNo,'') = '' or S.SalesOrderId like '%' + @SalesOrderNo +'%') 
				) r
	Where Row between @fromRow-@rowCount+1 AND  @fromRow
	
	
	end
	

GO



	
	
	/****** Object:  StoredProcedure [dbo].[procGetSubscriptionSummary]    Script Date: 6/12/2018 11:32:59 AM ******/
	
IF OBJECT_ID('procGetSubscriptionSummary') IS not NULL

/****** Object:  StoredProcedure [dbo].[procGetSubscriptionSummary]    Script Date: 7/26/2018 5:35:19 PM ******/
DROP PROCEDURE [dbo].[procGetSubscriptionSummary]
GO

/****** Object:  StoredProcedure [dbo].[procGetSubscriptionSummary]    Script Date: 7/26/2018 5:35:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[procGetSubscriptionSummary]
  @PageSize INT, 
  @PageNum  INT,
  @CompanyName nvarchar(50),
  @Domain nvarchar(50),
  @ProductName nvarchar(50),
  @ResellerPO nvarchar(50),
  @OrderNumber nvarchar(50),
  @EditProductStatus bit, 
  @EndCustomerId nvarchar(50)
	as
begin
	if(@EditProductStatus = 0)
	begin
		;WITH TempResult AS(
		
		    SELECT (case when isnull(SSD.Domain,'') = '' then ISNULL(OH.Domain,'') else SSD.Domain End) Domain, SSD.OrderNumber, SSD.SkuName, SSD.SKU, 
				isnull(SSD.Quantity,'') Quantity, SSD.SubscriptionId, SSD.Company, SSD.MappingStatus, isnull(SSD.LineStatus,'') LineStatus,
				SSD.CreatedDate, isnull(SSD.ResellerPO,'') PONumber, isnull(SSD.[Status],'') [Status], isnull(SSD.CreatedDate,'') OrderDate,
				SSD.UnitPrice,SSD.MarkUpPercentage,SSD.SeatLimit,SSD.TaxStatus,SSD.SeatLimitStartTime,SSD.SeatLimitEndTime,SSD.SeatCounter,SSD.CurrencySymbol,SSD.MicrosoftId
		
		    FROM SubscriptionSummaryDetail SSD 
				left join OrderHeader OH on SSD.OrderNumber=OH.OrderNumber 
				left join OrderLine OL on SSD.OrderNumber = OL.OrderNumber and SSD.SKU = OL.Sku
			where (SSD.EndCustomerId = @EndCustomerId) and
			(ISnull(@Domain,'')= '' or SSD.Domain like '%' + @Domain + '%') and
			(ISnull(@ProductName,'')= '' or SSD.SkuName like '%' + @ProductName + '%') and
			(ISnull(@ResellerPO,'')= '' or OH.PONumber like '%' + @ResellerPO + '%') and
			(ISnull(@OrderNumber,'')= '' or SSD.OrderNumber like '%' + @OrderNumber + '%') and 
			ISNULL(SSD.UnitPrice,'0') <> '0' and
			ISNULL(SSD.[Status],'') <> 'cancelled'
		),
		 TempCount AS (
		    SELECT COUNT(1) AS MaxRows FROM TempResult
		)
		SELECT  Domain,OrderNumber,SkuName,SKU,Quantity,SubscriptionId,Company,MappingStatus,LineStatus,PONumber,[Status],OrderDate,CreatedDate,MaxRows,UnitPrice,MarkUpPercentage,SeatLimit,
		   TaxStatus,SeatLimitStartTime,SeatLimitEndTime,SeatCounter,CurrencySymbol,MicrosoftId
		FROM TempResult, TempCount
		
		ORDER BY TempResult.OrderNumber
		    OFFSET (@PageNum-1)*@PageSize ROWS
		    FETCH NEXT @PageSize ROWS ONLY
	
	End
	if(@EditProductStatus = 1)
	begin
		;WITH TempResult AS(
			SELECT 
		    * 
			FROM
		    (
		         SELECT (case when isnull(SSD.Domain,'') = '' then ISNULL(OH.Domain,'') else SSD.Domain End) Domain, SSD.OrderNumber, SSD.SkuName, SSD.SKU,
				 isnull(SSD.Quantity,'') Quantity, SSD.SubscriptionId, SSD.Company, SSD.MappingStatus, isnull(SSD.LineStatus,'') LineStatus,
				 SSD.CreatedDate, isnull(SSD.ResellerPO,'') PONumber, isnull(SSD.[Status],'') [Status], isnull(SSD.CreatedDate,'') OrderDate,
				 isnull(SSD.UnitPrice,'')UnitPrice, isnull(SSD.SalesPrice,'')SalesPrice, isnull(SSD.MarkUpPercentage,'')MarkUpPercentage, isnull(SSD.SeatLimit,'') SeatLimit,
		         ROW_NUMBER() OVER (PARTITION BY SSD.SkuName ORDER BY SSD.SkuName DESC) rownumber
		         FROM SubscriptionSummaryDetail SSD 
					left join OrderHeader OH on SSD.OrderNumber=OH.OrderNumber 
					left join OrderLine OL on SSD.OrderNumber = OL.OrderNumber and SSD.SKU = OL.Sku
				where (SSD.EndCustomerId = @EndCustomerId) and
				(ISnull(@Domain,'')= '' or SSD.Domain like '%' + @Domain + '%') and
				(ISnull(@ProductName,'')= '' or SSD.SkuName like '%' + @ProductName + '%') and
				(ISnull(@ResellerPO,'')= '' or OH.PONumber like '%' + @ResellerPO + '%') and
				(ISnull(@OrderNumber,'')= '' or SSD.OrderNumber like '%' + @OrderNumber + '%') and 
				ISNULL(SSD.UnitPrice,'0') <> '0' and
				ISNULL(SSD.[Status],'') <> 'cancelled') a 
				WHERE rownumber = 1
		),TempCount AS (
		    SELECT COUNT(1) AS MaxRows FROM TempResult
		)
			SELECT  Domain,OrderNumber,SkuName,SKU,Quantity,SubscriptionId,Company,MappingStatus,LineStatus,PONumber,[Status],OrderDate,CreatedDate,MaxRows,UnitPrice,SalesPrice,MarkUpPercentage,SeatLimit
		FROM TempResult, TempCount
	End
End

GO

IF OBJECT_ID('procGetUsers') IS not NULL
/****** Object:  StoredProcedure [dbo].[procGetUsers]    Script Date: 7/27/2018 2:35:41 PM ******/
DROP PROCEDURE [dbo].[procGetUsers]
GO

/****** Object:  StoredProcedure [dbo].[procGetUsers]    Script Date: 7/27/2018 2:35:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[procGetUsers]
(
	@Id numeric(18,0),
	@UserName nvarchar(100),
	@CompanyName nvarchar(100),
	@rowCount int,
	@pageNo int,
	@orderBy nvarchar(50),
	@CompanyId numeric(18,0),
	@Email nvarchar(50)
)
as

begin

	declare @fromRow as int,@TotalRecords as int
	set @fromRow=@rowCount*@Pageno 

	select	@TotalRecords =  COUNT(U.EnduserId) 	
	From	EndUser U join Company C
		on		U.CompanyName = C.Name 
	Where	(U.EnduserId = @Id OR @Id = 0)
		and (U.Name = ''  or U.Name like IsnULL(@UserName,'') + '%') 
		and (Isnull(@CompanyName,'') = '' or C.Name = @CompanyName) 
		and (Isnull(@Email,'') = '' or U.Email = @Email)


	select * from(
			 select   ROW_NUMBER() over (order by C.Name ) as Row, U.EnduserId, U.Name EndUserName, C.Name CompanyName, U.Email, @TotalRecords TotalRecords
			 From	EndUser U join Company C
				on		U.CompanyName = C.Name 
			Where	(U.EnduserId = @Id OR @Id = 0)
				and (U.Name = ''  or U.Name like IsnULL(@UserName,'') + '%') 
				and (Isnull(@CompanyName,'') = '' or C.Name = @CompanyName) 
				and (Isnull(@Email,'') = '' or U.Email = @Email)
	        ) r
	Where Row between @fromRow-@rowCount+1 AND  @fromRow

end


GO

IF OBJECT_ID('procGetUserSubscriptions') IS not NULL
/****** Object:  StoredProcedure [dbo].[procGetUserSubscriptions]    Script Date: 7/27/2018 2:38:28 PM ******/
DROP PROCEDURE [dbo].[procGetUserSubscriptions]
GO

/****** Object:  StoredProcedure [dbo].[procGetUserSubscriptions]    Script Date: 7/27/2018 2:38:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[procGetUserSubscriptions]
(
  @PageSize INT, 
  @PageNum  INT,
  @EndUserEmail nvarchar(50),
  @EndUserName nvarchar(50),
  @ProductName nvarchar(50),
  @EndCustomerId nvarchar(50)
)
AS
BEGIN
	declare @CompanyDetail as table(companyId nvarchar(50))
	declare @CompanyDetail1 as table(companyName nvarchar(50), EndCustomerId nvarchar(50))
	--insert into @CompanyDetail
	--Select companyid from Enduser where Email = @EndUserEmail
 
	insert into @CompanyDetail1
	Select E.CompanyName,C.EndCustomerId 
	from Enduser E inner join Company C 
		on E.CompanyName=C.Name 
	where Email = @EndUserEmail

	--Insert into @CompanyDetail1
	--select C.name from Company C inner join @CompanyDetail CD on CD.CompanyId = C.CompanyId
	;WITH TempResult AS(
		SELECT SSD.Domain, SSD.OrderNumber, SSD.SkuName, SSD.SKU, isnull(SSD.Quantity,'') Quantity, SSD.SubscriptionId, 
				SSD.Company, SSD.MappingStatus, SSD.LineStatus, SSD.CreatedDate, SSD.ResellerPO PONumber, SSD.[Status],
				SSD.CreatedDate As OrderDate, SSD.UnitPrice,SSD.MarkUpPercentage,
				isnull(SSD.SeatLimit,'')SeatLimit,isnull(SSD.TaxStatus,'')TaxStatus,isnull(SSD.SeatLimitStartTime,'')SeatLimitStartTime,isnull(SeatLimitEndTime,'')SeatLimitEndTime,
				isnull(SSD.SeatCounter,'')SeatCounter,isnull(SSD.CurrencySymbol,'')CurrencySymbol, SSD.EndCustomerPO EndUserPONumber
		FROM SubscriptionSummaryDetail SSD left join OrderLine OL on SSD.OrderNumber = OL.OrderNumber and SSD.SKU = OL.Sku
			inner Join @CompanyDetail1 cd1 on cd1.EndCustomerId = ssd.EndCustomerId
			left join OrderHeader OH on SSD.OrderNumber=OH.OrderNumber 
		where (ISnull(@ProductName,'')= '' or SSD.SkuName like '%' + @ProductName + '%') 
			and	SSD.MappingStatus = 'MAPPED' 
			and ISNULL(OH.[Status],'') <> 'cancelled'
			and SSD.EndCustomerId = @EndCustomerId
		), TempCount AS (
		SELECT COUNT(1) AS MaxRows 
			FROM TempResult
	)

	SELECT  Domain,OrderNumber,SkuName,SKU,Quantity,SubscriptionId,Company,MappingStatus,LineStatus,PONumber,[Status],OrderDate,CreatedDate,MaxRows,UnitPrice,MarkUpPercentage,SeatLimit,
		TaxStatus,SeatLimitStartTime,SeatLimitEndTime,SeatCounter,CurrencySymbol,EndUserPONumber
	FROM TempResult, TempCount
	ORDER BY TempResult.MappingStatus
		OFFSET (@PageNum-1)*@PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY
END
GO


IF OBJECT_ID('procInsertIntoLogs') IS not NULL
/****** Object:  StoredProcedure [dbo].[procInsertIntoLogs]    Script Date: 7/27/2018 2:39:25 PM ******/
DROP PROCEDURE [dbo].[procInsertIntoLogs]
GO

/****** Object:  StoredProcedure [dbo].[procInsertIntoLogs]    Script Date: 7/27/2018 2:39:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[procInsertIntoLogs]
(
@message nvarchar(max),
@ErrorCode nvarchar(max),
@Result nvarchar(max),
@Key int,
@IsSuccess bit,
@IsValid bit,
@TimeStamp datetime,
@Browser nvarchar(max),
@CurrentExecutionFilePath nvarchar(max),
@RequestType nvarchar(max),
@UserHostAddress nvarchar(max),
@UserHostName nvarchar(max)

)
as
begin
insert into Logs([Message],ErrorCode,Result,[Key],IsSuccess,IsValid,[DateTime],Browser,CurrentExecutionFilePath,RequestType,
UserHostAddress,UserHostName) values (@message,@ErrorCode,@Result,@Key,@IsSuccess,@IsValid,@TimeStamp,@Browser,@CurrentExecutionFilePath,
@RequestType,@UserHostAddress,@UserHostName)
end

GO


IF OBJECT_ID('procIsUserAuthorizeToIncreaseSeat') IS not NULL
/****** Object:  StoredProcedure [dbo].[procIsUserAuthorizeToIncreaseSeat]    Script Date: 7/27/2018 2:40:29 PM ******/
DROP PROCEDURE [dbo].[procIsUserAuthorizeToIncreaseSeat]
GO

/****** Object:  StoredProcedure [dbo].[procIsUserAuthorizeToIncreaseSeat]    Script Date: 7/27/2018 2:40:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[procIsUserAuthorizeToIncreaseSeat]
(
 @Quantity nvarchar(max),
 @SKU nvarchar(50),
 @SeatCounter int,
 @OrderNumber nvarchar(50),
 @OriginalQuantity int
)
as

BEGIN
	DECLARE @Response as bit,@counter int,@SeatLimitEndTime dateTime,@TemporarySeatLimit int,@SeatLimit int

	SELECT @counter = ISNULL(SSD.SeatCounter,0) , @TemporarySeatLimit = ISNULL(TemporarySeatLimit,0),@SeatLimit = ISNULL(SeatLimit,0),
			@SeatLimitEndTime = ISNULL(SeatLimitEndTime,0) from SubscriptionSummaryDetail SSD where SSD.OrderNumber = @OrderNumber and SSD.SKU = @SKU 

	If(@SeatLimit > 0)
	BEGIN
		IF(getdate() > ISNULL(@SeatLimitEndTime,0))
		BEGIN
			Update SubscriptionSummaryDetail
			set SeatCounter = 0,TemporarySeatLimit = @SeatLimit
			where OrderNumber = @OrderNumber and SKU = @SKU 
			set @counter = 0
		END

		IF(@counter = 0 )
		BEGIN
			IF(@Quantity > @TemporarySeatLimit)
			BEGIN
				set @Response = 0
			END
			ELSE
			BEGIN
				Update SubscriptionSummaryDetail
				set SeatLimitStartTime = GETDATE(),SeatLimitEndTime = SeatLimitStartTime + 1,SeatCounter = @counter + 1
				where OrderNumber = @OrderNumber and SKU = @SKU 
				set @Response = 1
			END
		END
		ELSE
		BEGIN
			if(@Quantity > @TemporarySeatLimit)
			Begin
				set @Response = 0 
			End
			Else
			Begin
				select @SeatLimitEndTime = ISNULL(SSD.SeatLimitEndTime,0) from SubscriptionSummaryDetail SSD where SSD.OrderNumber = @OrderNumber and SSD.SKU = @SKU 
				if(getDate() > @SeatLimitEndTime)
				begin
					set @Response = 0
				end
				ELSE
				Begin
					Update SubscriptionSummaryDetail
					set SeatCounter = @counter + 1
					where OrderNumber = @OrderNumber and SKU = @SKU 
				
					set @Response = 1
				End
			END
		END
	END
	ELSE
		set @Response = 1

	select Cast(@Response as bit) 'Response'
END
GO

IF OBJECT_ID('procXmlDeleteCompanyOrderMapping') IS not NULL

/****** Object:  StoredProcedure [dbo].[procXmlDeleteCompanyOrderMapping]    Script Date: 7/27/2018 2:41:13 PM ******/
DROP PROCEDURE [dbo].[procXmlDeleteCompanyOrderMapping]
GO

/****** Object:  StoredProcedure [dbo].[procXmlDeleteCompanyOrderMapping]    Script Date: 7/27/2018 2:41:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[procXmlDeleteCompanyOrderMapping]
 @recordIds xml
 As
 BEGIN

 Declare @SalesOrderTable table(SalesOrderId nvarchar(50)) /*table to store salesorderid */
 insert into @SalesOrderTable(SalesOrderId) 
 select salesorderid
	From	CompanyOrder
	Where	RecordId in ( 
							Select c.value('.','numeric(18,0)')    
							From 
								 @recordIds.nodes('RecordIds/RecordId') T(c)
						  )
 
   delete from companyorder where SalesOrderId in(select SalesOrderId from @SalesOrderTable) 
   delete from orderline where OrderNumber  in(select SalesOrderId from @SalesOrderTable) 
   delete from OrderHeader where OrderNumber in(select SalesOrderId from @SalesOrderTable) 
  END
GO

IF OBJECT_ID('procXmlGetOrders') IS not NULL

/****** Object:  StoredProcedure [dbo].[procXmlGetOrders]    Script Date: 7/27/2018 2:42:03 PM ******/
DROP PROCEDURE [dbo].[procXmlGetOrders]
GO

/****** Object:  StoredProcedure [dbo].[procXmlGetOrders]    Script Date: 7/27/2018 2:42:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[procXmlGetOrders]
(
	@IsAdmin bit,
	@UserEmailId nvarchar(100),
	@OrderNumber nvarchar(50),
	@UserName nvarchar(100),
	@SkuName nvarchar(100),
	@rowCount int,
	@Pageno int,
	@CompanyName nvarchar(100)
)
as

begin
  

Declare @fromRow as int,@TotalRecords as int, @CompanyId as int                                   
set @fromRow=@rowCount*@Pageno   

Select @CompanyId = (Select Top 1 Companyid from Enduser where Email = @UserEmailId),
       @UserName = Isnull(@UserName,''), @UserEmailId = ISNULL(@UserEmailId,''),
	  @SkuName = ISNULL(@SkuName,''), @OrderNumber = ISNULL(@OrderNumber,''), @CompanyName = ISNULL(@CompanyName,'')

Set @TotalRecords = ( 
					   Select	 Count(OrderNumber) 
					   From	 (
								Select  Oh.OrderNumber,
									   (
										  Select	P.SkuName '@SkuName' 
										  From	OrderLine Ol join Product P on Ol.Sku = P.Sku
										  Where	Ol.OrderNumber = Oh.OrderNumber and 
												Ol.SkuName like '%' + @SkuName + '%'
										  for	xml path('OrderLine'), root('OrderLines'),Type 
									   ) OrderLines 
								From	   OrderHeader Oh Join CompanyOrder Co on Oh.OrderNumber = Co.SalesOrderId
								Where  (Oh.Status <> 'Cancelled') and ( (@IsAdmin = 1) or (Co.CompanyId = @CompanyId )) and
									  (@OrderNumber = '' or Oh.OrderNumber like '%' + @OrderNumber + '%') and
									  (Oh.EndUserName like '%' + @UserName + '%') and
									  ((@IsAdmin = 0 or @CompanyName = '') or 
									   (Co.CompanyId in (Select CompanyId 
													 from Company 
													 where name like '%' + @CompanyName + '%'
													 )
									   )
									  )					 
							 ) Result
					   Where	 OrderLines is not null
				  )



    Select * From (
				Select ROW_NUMBER() over (order by C.Name) Row, Oh.OrderNumber,Oh.OrderDate,Oh.OrderType,Oh.Status,Oh.Domain,Oh.EndUserName,
					  Oh.EndUserEmail,Oh.TotalSalesPrice,Oh.CurrencySymbol,Oh.CurrencyCode,@TotalRecords TotalRecords, C.CompanyId, C.Name CompanyName,
				    (
					   Select	 Ol.LineId '@LineId', Ol.Sku '@Sku',P.SkuName '@SkuName' ,Ol.Quantity '@Quantity' ,Ol.UnitPrice '@UnitPrice',
							 Ol.ManufacturerPartNumber '@ManufacturerPartNumber',Ol.LineStatus '@LineStatus',Ol.CurrencySymbol '@CurrencySymbol',
							 Ol.CurrencyCode '@CurrencyCode'
					   From	 OrderLine Ol join Product P on Ol.Sku = P.Sku
					   Where	 Ol.OrderNumber = Oh.OrderNumber and 
							 Ol.SkuName like '%' + @SkuName + '%'
					   for	 xml path('OrderLine'), root('OrderLines'),Type 
				    ) OrderLines 
				From  OrderHeader Oh Join CompanyOrder Co on Oh.OrderNumber = Co.SalesOrderId
					 Join Company C on Co.CompanyId = C.CompanyId
				Where  (Oh.Status <> 'Cancelled') and ( (@IsAdmin = 1) or (Co.CompanyId = @CompanyId )) and
									  (@OrderNumber = '' or Oh.OrderNumber like '%' + @OrderNumber + '%') and
									  (Oh.EndUserName like '%' + @UserName + '%') and
									  ((@IsAdmin = 0 or @CompanyName = '') or 
									   (Co.CompanyId in (Select CompanyId 
													 from Company 
													 where name like '%' + @CompanyName + '%'
													 )
									   )
									  )					 
			 ) Result
    Where	  (Row Between @fromRow -@rowCount + 1 And @fromRow ) and
		  OrderLines is not null
end
GO

IF OBJECT_ID('procXmlInsertCompanies') IS not NULL
/****** Object:  StoredProcedure [dbo].[procXmlInsertCompanies]    Script Date: 7/27/2018 2:42:39 PM ******/
DROP PROCEDURE [dbo].[procXmlInsertCompanies]
GO
/****** Object:  StoredProcedure [dbo].[procXmlInsertCompanies]    Script Date: 11/6/2018 12:21:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procXmlInsertCompanies]  
(  
 @Companies xml ,  
 @CreatedBy nvarchar(100)  
)  
AS  
BEGIN  

	TRUNCATE TABLE Company

    INSERT INTO Company(Name,EndCustomerId,Created,CreatedBy)  
    Select c.value('./CompanyName[1]','nvarchar(100)'),c.value('./EndCustomerId[1]','nvarchar(100)'),GETDATE(),@CreatedBy        
    From   
	@Companies.nodes('Companies/Company') T(c)

END
GO

IF OBJECT_ID('procXmlRemoveEndUser') IS not NULL

/****** Object:  StoredProcedure [dbo].[procXmlRemoveEndUser]    Script Date: 7/27/2018 2:43:14 PM ******/
DROP PROCEDURE [dbo].[procXmlRemoveEndUser]
GO

/****** Object:  StoredProcedure [dbo].[procXmlRemoveEndUser]    Script Date: 7/27/2018 2:43:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[procXmlRemoveEndUser] 
 @customerIds xml
 as
 Begin

	Delete
	From	Enduser 
	Where	EnduserId in ( 
							Select c.value('.','numeric(18,0)')    
							From 
								 @customerIds.nodes('CustomerIds/CustomerId') T(c)
						  )
 End
GO


IF OBJECT_ID('procXmlUpsertProducts') IS not NULL

/****** Object:  StoredProcedure [dbo].[procXmlUpsertProducts]    Script Date: 7/27/2018 2:43:44 PM ******/
DROP PROCEDURE [dbo].[procXmlUpsertProducts]
GO

/****** Object:  StoredProcedure [dbo].[procXmlUpsertProducts]    Script Date: 7/27/2018 2:43:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[procXmlUpsertProducts]
(
	@Products xml	
)
as

begin
  

Insert Into Product(Sku,SkuName,ManufacturerPartNumber,Article,VendorMapId,ProductType,QtyMin,QtyMax,LastUpdated)
Select c.value('@Sku','nvarchar(100)'),c.value('@SkuName','nvarchar(200)'),c.value('@ManufacturerPartNumber','nvarchar(100)'),
       c.value('@Article','nvarchar(100)'), c.value('@VendorMapId','nvarchar(100)'),c.value('@ProductType','nvarchar(100)'),
	  c.value('@QtyMin','int'),c.value('@QtyMax','int'),c.value('@LastUpdated','datetime')
From 
       @Products.nodes('Products/Product') T(c) left join Product P On  c.value('@Sku','nvarchar(100)') = P.SKU
	  Where P.Sku is null


Update P
Set	  P.SkuName = c.value('@SkuName','nvarchar(200)'),P.ManufacturerPartNumber =c.value('@ManufacturerPartNumber','nvarchar(100)'),
       P.Article = c.value('@Article','nvarchar(100)'),P.VendorMapId = c.value('@VendorMapId','nvarchar(100)'),P.ProductType = c.value('@ProductType','nvarchar(100)'),
	  P.QtyMin = c.value('@QtyMin','int'),P.QtyMax = c.value('@QtyMax','int'), P.LastUpdated = c.value('@LastUpdated','datetime')
From 
       @Products.nodes('Products/Product') T(c) left join Product P On  c.value('@Sku','nvarchar(100)') = P.SKU
	   
      
 Select 1 IsValid


end
GO













	
	
	
		

	
	
