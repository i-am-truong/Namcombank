USE [NamcombankOriginal]
GO
/****** Object:  Table [dbo].[Active]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Active](
	[active] [bit] NOT NULL,
	[activename] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[active] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CreditCards]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CreditCards](
	[card_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[card_number] [nvarchar](20) NOT NULL,
	[cvv] [nvarchar](4) NOT NULL,
	[expiry_date] [date] NOT NULL,
	[credit_limit] [decimal](18, 2) NOT NULL,
	[available_balance] [decimal](18, 2) NOT NULL,
	[status] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[card_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[fullname] [nvarchar](100) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[password] [nvarchar](255) NOT NULL,
	[active] [bit] NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[dob] [date] NOT NULL,
	[gender] [bit] NOT NULL,
	[phonenumber] [nvarchar](15) NOT NULL,
	[balance] [money] NULL,
	[citizen_identification_card] [nvarchar](15) NULL,
	[address] [nvarchar](200) NOT NULL,
	[avatar] [nvarchar](255) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerAssets]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerAssets](
	[asset_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[staff_id] [int] NOT NULL,
	[asset_name] [nvarchar](50) NOT NULL,
	[asset_type] [varchar](50) NOT NULL,
	[asset_value] [float] NOT NULL,
	[created_date] [datetime] NOT NULL,
	[status] [nvarchar](50) NULL,
	[description] [nvarchar](max) NOT NULL,
	[approved_by] [nchar](10) NULL,
	[approved_date] [datetime] NULL,
	[note] [text] NULL,
 CONSTRAINT [PK_CustomerAssets] PRIMARY KEY CLUSTERED 
(
	[asset_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[department_id] [int] IDENTITY(1,1) NOT NULL,
	[department_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[department_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Features]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Features](
	[feature_id] [int] NOT NULL,
	[feature_name] [varchar](50) NOT NULL,
	[url] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Features] PRIMARY KEY CLUSTERED 
(
	[feature_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[feedback_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[content] [nvarchar](max) NULL,
	[submitted_at] [date] NOT NULL,
	[rating] [int] NOT NULL,
 CONSTRAINT [PK_Feedback] PRIMARY KEY CLUSTERED 
(
	[feedback_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gender]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gender](
	[gender] [bit] NOT NULL,
	[gendername] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[gender] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoanPackages]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoanPackages](
	[package_id] [int] IDENTITY(1,1) NOT NULL,
	[staff_id] [int] NULL,
	[package_name] [nvarchar](100) NOT NULL,
	[loan_type] [nchar](10) NOT NULL,
	[description] [nvarchar](max) NOT NULL,
	[interest_rate] [decimal](5, 2) NOT NULL,
	[max_amount] [decimal](18, 2) NOT NULL,
	[min_amount] [decimal](18, 2) NOT NULL,
	[loan_term] [int] NOT NULL,
	[created_date] [date] NOT NULL,
 CONSTRAINT [PK__LoanPack__63846AE837C7752C] PRIMARY KEY CLUSTERED 
(
	[package_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoanRequests]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoanRequests](
	[request_id] [int] IDENTITY(1,1) NOT NULL,
	[staff_id] [int] NULL,
	[package_id] [int] NOT NULL,
	[customer_id] [int] NOT NULL,
	[request_date] [datetime] NULL,
	[amount] [float] NULL,
	[status] [nvarchar](100) NULL,
	[start_date] [datetime] NULL,
	[end_date] [datetime] NULL,
	[approval_date] [datetime] NULL,
	[approved_by] [nvarchar](50) NULL,
	[approved_note] [nvarchar](50) NULL,
	[asset_id] [int] NULL,
 CONSTRAINT [PK_LoanRequests] PRIMARY KEY CLUSTERED 
(
	[request_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Loans]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Loans](
	[customer_id] [int] NOT NULL,
	[package_id] [int] NOT NULL,
	[amount] [nchar](10) NOT NULL,
	[start_date] [nchar](10) NOT NULL,
	[end_date] [nchar](10) NOT NULL,
	[status] [nchar](10) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[sender_id] [int] NOT NULL,
	[receiver_id] [int] NOT NULL,
	[sender_type] [nvarchar](10) NULL,
	[content] [nvarchar](max) NOT NULL,
	[status] [nvarchar](10) NULL,
	[timestamp] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[News]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[News](
	[news_id] [int] IDENTITY(1,1) NOT NULL,
	[staff_id] [int] NULL,
	[title] [nvarchar](255) NOT NULL,
	[description] [nvarchar](max) NOT NULL,
	[status] [bit] NOT NULL,
	[updateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_News] PRIMARY KEY CLUSTERED 
(
	[news_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification](
	[notification_id] [int] NOT NULL,
	[message] [nvarchar](max) NOT NULL,
	[created_at] [date] NOT NULL,
	[customer_id] [int] NOT NULL,
 CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED 
(
	[notification_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepaymentSchedule]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepaymentSchedule](
	[schedule_id] [int] IDENTITY(1,1) NOT NULL,
	[status] [nvarchar](50) NOT NULL,
	[due_date] [date] NOT NULL,
	[amount_due] [float] NOT NULL,
	[request_id] [int] NULL,
 CONSTRAINT [PK_RepaymentSchedule] PRIMARY KEY CLUSTERED 
(
	[schedule_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleFeatures]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleFeatures](
	[role_id] [int] NOT NULL,
	[feature_id] [int] NOT NULL,
 CONSTRAINT [PK_RoleFeatures] PRIMARY KEY CLUSTERED 
(
	[role_id] ASC,
	[feature_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[role_id] [int] NOT NULL,
	[role_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Saving]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Saving](
	[savings_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[amount] [float] NULL,
	[interest_rate] [float] NOT NULL,
	[term_months] [int] NOT NULL,
	[opened_date] [date] NOT NULL,
	[status] [nvarchar](50) NOT NULL,
	[saving_request_id] [int] NOT NULL,
	[staff_id] [int] NULL,
	[money_get_date] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[savings_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SavingFeedback]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SavingFeedback](
	[content] [nvarchar](max) NOT NULL,
	[submitted_at] [date] NOT NULL,
	[answer] [nvarchar](max) NULL,
	[answer_at] [date] NULL,
	[savings_id] [int] NOT NULL,
	[feedback_type] [varchar](10) NOT NULL,
	[attachment] [nvarchar](max) NULL,
	[feedback_id] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[feedback_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SavingPackage]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SavingPackage](
	[saving_package_id] [int] IDENTITY(1,1) NOT NULL,
	[staff_id] [int] NOT NULL,
	[saving_package_name] [nvarchar](255) NOT NULL,
	[saving_package_description] [nvarchar](max) NOT NULL,
	[saving_package_interest_rate] [decimal](5, 2) NOT NULL,
	[saving_package_term_months] [int] NULL,
	[saving_package_min_deposit] [decimal](18, 2) NOT NULL,
	[saving_package_max_deposit] [decimal](18, 2) NULL,
	[saving_package_status] [nvarchar](10) NOT NULL,
	[saving_package_created_at] [datetime] NOT NULL,
	[saving_package_updated_at] [datetime] NULL,
	[saving_package_withdrawable] [bit] NOT NULL,
	[saving_package_approval_status] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[saving_package_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SavingRequest]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SavingRequest](
	[saving_request_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[saving_package_id] [int] NOT NULL,
	[staff_id] [int] NULL,
	[money] [decimal](18, 2) NOT NULL,
	[saving_approval_status] [nvarchar](10) NOT NULL,
	[saving_approval_date] [date] NULL,
	[money_approval_status] [nvarchar](10) NOT NULL,
	[amount] [float] NULL,
	[created_at] [date] NOT NULL,
	[saving_package_name] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[saving_request_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[staff_id] [int] IDENTITY(1,1) NOT NULL,
	[department_id] [int] NOT NULL,
	[fullname] [nvarchar](100) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[password] [nvarchar](255) NOT NULL,
	[active] [bit] NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[dob] [date] NOT NULL,
	[gender] [bit] NOT NULL,
	[phonenumber] [nvarchar](15) NOT NULL,
	[citizen_identification_card] [nvarchar](15) NULL,
	[address] [nvarchar](200) NOT NULL,
	[avatar] [nvarchar](255) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[staff_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StaffRoles]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StaffRoles](
	[staff_id] [int] NULL,
	[role_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 3/30/2025 10:25:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[transaction_id] [int] IDENTITY(1,1) NOT NULL,
	[schedule_id] [int] NULL,
	[request_id] [int] NULL,
	[amount] [money] NOT NULL,
	[transaction_date] [date] NOT NULL,
	[type] [nvarchar](max) NULL,
	[savings_id] [int] NULL,
	[customer_id] [int] NOT NULL,
	[staff_id] [int] NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[transaction_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Active] ([active], [activename]) VALUES (0, N'Closed')
INSERT [dbo].[Active] ([active], [activename]) VALUES (1, N'Opening')
GO
SET IDENTITY_INSERT [dbo].[CreditCards] ON 

INSERT [dbo].[CreditCards] ([card_id], [customer_id], [card_number], [cvv], [expiry_date], [credit_limit], [available_balance], [status]) VALUES (2, 69, N'5743425920574501', N'176', CAST(N'2028-03-20' AS Date), CAST(100000000.00 AS Decimal(18, 2)), CAST(100000000.00 AS Decimal(18, 2)), N'Active')
SET IDENTITY_INSERT [dbo].[CreditCards] OFF
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (13, N'Truong Quoc Truong', N'truongtq', N'sAV5PWv4CBikIZOd7DNQBp8Q+Lo=', 1, N'tqtolympia@gmail.com', CAST(N'2005-02-04' AS Date), 1, N'0923456781', 0.0000, N'012345678901', N'Vietnam', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (20, N'Doan Vinh Hung', N'kakaka', N'123456', 1, N'kakaka@gmail.com', CAST(N'1970-01-01' AS Date), 1, N'0875469321', 0.0000, N'012345678910', N'Ha Tinh, Vietnam', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (27, N'Nguyen Thai Duong', N'duongnt', N'2imtLxYBBNNKJcKcczkw6QqsbZs=', 1, N'duongnt@gmail.com', CAST(N'1970-01-01' AS Date), 1, N'0956784123', 0.0000, N'012345678910', N'Hanoi, Vietnam', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (53, N'Nguyen Hai Nam', N'nguyenhainam', N'2imtLxYBBNNKJcKcczkw6QqsbZs=', 1, N'nguyenhainam@example.com', CAST(N'2025-02-23' AS Date), 1, N'0987654321', 0.0000, N'012345678905', N'Vietnam', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (54, N'Pham Cong Tra', N'phamcongtra', N'2imtLxYBBNNKJcKcczkw6QqsbZs=', 1, N'phamcongtra@example.com', CAST(N'2025-02-23' AS Date), 1, N'0976543210', 0.0000, N'012345678906', N'Hochiminh', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (55, N'Nguyen Thi Kieu Anh', N'nguyenthikieuanh', N'2imtLxYBBNNKJcKcczkw6QqsbZs=', 1, N'nguyenthikieuanh@example.com', CAST(N'2025-02-23' AS Date), 0, N'0965432109', 0.0000, N'012345678907', N'Da Nang', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (59, N'Tran Duc Anh', N'anhtd', N'c00dVVAMcTGpAQWd91RHsyKlR3Q=', 0, N'swp391@gmail.com', CAST(N'2025-02-23' AS Date), 1, N'0923456788', 0.0000, N'057486912475', N'Vietnam', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (68, N'Đinh Xuân Dương', N'duongdx', N'2imtLxYBBNNKJcKcczkw6QqsbZs=', 1, N'duongdx@gmail.com', CAST(N'2025-02-27' AS Date), 1, N'0485632159', 0.0000, N'012548796352', N'Hà Nội, Việt Nam', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (69, N'Trương Quốc Trường', N'truongtqt', N'2imtLxYBBNNKJcKcczkw6QqsbZs=', 1, N'truongtqt@gmail.com', CAST(N'2004-02-27' AS Date), 1, N'0959647891', 689000000.0000, N'098651435987', N'Hà Nội, Việt Nam', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (70, N'Nguyen Hoang Son', N'nguyenhoangson', N'FlmIXAy56ykWRvWlYZJ0niyfyQc=', 1, N'nguyenhoangson@gmail.com', CAST(N'1970-01-01' AS Date), 1, N'0987654328', 0.0000, N'012345678910', N'Hà Nội, Việt Nam', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (72, N'Nguyễn Hoàng Sơn', N'nguyenhoangson', N'2imtLxYBBNNKJcKcczkw6QqsbZs=', 1, N'nguyenhoangson@example.com', CAST(N'2025-02-27' AS Date), 1, N'0959784632', 0.0000, N'078459612879', N'Hà Nội, Việt Nam', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (73, N'Trần Đức Anh', N'tranducanh', N'6ZTwz+921YZYOO/SCQDhgBfqCy8=', 1, N'tranducanh@gmail.com', CAST(N'1970-01-01' AS Date), 1, N'0987654327', 0.0000, N'012345678910', N'Hà Nội, Việt Nam', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (74, N'Chu Bo Doi', N'customer1', N'/VjVmcsJRe4fizrmpcw7CjL8k5c=', 1, N'traudajca@gmail.com', CAST(N'2005-06-16' AS Date), 1, N'0981439283', 0.0000, N'312312312312', N'Thach Hoa', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (75, N'Messi', N'messi', N'wsl97IRbQ6h8c76fdeDSUGZPDlw=', 1, N'messi@gmail.com', CAST(N'2003-06-13' AS Date), 1, N'0981232123', 0.0000, N'1234567890', N'Thach Hoa', NULL)
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[CustomerAssets] ON 

INSERT [dbo].[CustomerAssets] ([asset_id], [customer_id], [staff_id], [asset_name], [asset_type], [asset_value], [created_date], [status], [description], [approved_by], [approved_date], [note]) VALUES (3, 13, 1, N'Căn hộ chung cư', N'REAL_ESTATE', 123, CAST(N'2025-03-06T23:42:56.970' AS DateTime), N'REJECTED', N'sdsad', N'1         ', CAST(N'2025-03-06T23:43:08.280' AS DateTime), N'sdsad')
INSERT [dbo].[CustomerAssets] ([asset_id], [customer_id], [staff_id], [asset_name], [asset_type], [asset_value], [created_date], [status], [description], [approved_by], [approved_date], [note]) VALUES (5, 13, 1, N'abcd', N'REAL_ESTATE', 12345566789, CAST(N'2025-03-07T00:04:16.577' AS DateTime), N'PENDING', N'fgfdgfd', NULL, NULL, NULL)
INSERT [dbo].[CustomerAssets] ([asset_id], [customer_id], [staff_id], [asset_name], [asset_type], [asset_value], [created_date], [status], [description], [approved_by], [approved_date], [note]) VALUES (6, 75, 1, N'Salary', N'INCOME', 50000000, CAST(N'2025-03-29T21:19:48.647' AS DateTime), N'APPROVED', N'', N'1         ', CAST(N'2025-03-29T21:19:59.393' AS DateTime), N'')
INSERT [dbo].[CustomerAssets] ([asset_id], [customer_id], [staff_id], [asset_name], [asset_type], [asset_value], [created_date], [status], [description], [approved_by], [approved_date], [note]) VALUES (7, 20, 61, N'Chít', N'REAL_ESTATE', 1000000000, CAST(N'2025-03-29T22:28:10.103' AS DateTime), N'PENDING', N'', NULL, NULL, NULL)
INSERT [dbo].[CustomerAssets] ([asset_id], [customer_id], [staff_id], [asset_name], [asset_type], [asset_value], [created_date], [status], [description], [approved_by], [approved_date], [note]) VALUES (8, 20, 63, N'Salary', N'INCOME', 50000000, CAST(N'2025-03-29T22:40:53.167' AS DateTime), N'PENDING', N'', NULL, NULL, NULL)
INSERT [dbo].[CustomerAssets] ([asset_id], [customer_id], [staff_id], [asset_name], [asset_type], [asset_value], [created_date], [status], [description], [approved_by], [approved_date], [note]) VALUES (9, 27, 61, N'Salary', N'INCOME', 10000000, CAST(N'2025-03-29T22:43:46.043' AS DateTime), N'PENDING', N'', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[CustomerAssets] OFF
GO
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([department_id], [department_name]) VALUES (1, N'Finance')
INSERT [dbo].[Department] ([department_id], [department_name]) VALUES (2, N'Human Resources')
INSERT [dbo].[Department] ([department_id], [department_name]) VALUES (3, N'Sales')
INSERT [dbo].[Department] ([department_id], [department_name]) VALUES (4, N'Customer Support')
INSERT [dbo].[Department] ([department_id], [department_name]) VALUES (5, N'IT')
SET IDENTITY_INSERT [dbo].[Department] OFF
GO
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (1, N'Staff Filter', N'/staffFilter')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (2, N'Staff Added', N'/addStaff')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (3, N'Staff Update', N'/updateStaff')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (4, N'Manager User', N'/managerUser')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (5, N'List Loan Package', N'/loanpackage/listloanpackage')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (6, N'Manager Customer', N'/manageCustomer')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (7, N'View Feedback', N'/viewCustomerFeedback')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (8, N'Manager Customer', N'/manageCustomer')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (9, N'View Feedback', N'/viewCustomerFeedback')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (10, N'List Cate', N'/listCate')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (11, N'Lock And Unlock Customer', N'/lockCustomer')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (12, N'View Detail Customer', N'/viewCustomer')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (13, N'Edit Customer', N'/editCustomer')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (14, N'Delete Customer', N'/deleteCustomer')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (15, N'AssetAddController', N'/assets-add')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (16, N'AssetListController', N'/assets-filter')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (17, N'AssetDetailController', N'/asset-detail')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (18, N'Add Customer', N'/addCustomer')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (19, N'Manage Customer Ver 2', N'/manageCustomerVer2')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (20, N'Advanced Search', N'/manageCustomerVer2/Search')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (21, N'News Management', N'/newsListStaff')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (22, N'savingMoney', N'/savingMoney')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (30, N'createSavingPackage', N'/createSavingPackage')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (31, N'listSaving', N'/listSaving')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (32, N'managerSaving', N'/managerSaving')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (33, N'updateSaving', N'/updateSaving')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (34, N'Customer Reviced money', N'/SavingPay')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (35, N'answer ffeedback saving', N'/SavingFeedbackAnswer')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (36, N'Loan Request Detail', N'/loan-request-detail')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (37, N'List Loan Request', N'/loan-requests-auth')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (38, N'Staff Profile', N'/staffProfile')
INSERT [dbo].[Features] ([feature_id], [feature_name], [url]) VALUES (39, N'Transaction Filter', N'/transaction-filter')
GO
INSERT [dbo].[Gender] ([gender], [gendername]) VALUES (0, N'Female')
INSERT [dbo].[Gender] ([gender], [gendername]) VALUES (1, N'Male')
GO
SET IDENTITY_INSERT [dbo].[LoanPackages] ON 

INSERT [dbo].[LoanPackages] ([package_id], [staff_id], [package_name], [loan_type], [description], [interest_rate], [max_amount], [min_amount], [loan_term], [created_date]) VALUES (1, 1, N'Quick Unsecured Loan Package', N'unsecured ', N'No collateral required, quick processing.', CAST(8.50 AS Decimal(5, 2)), CAST(50000000.00 AS Decimal(18, 2)), CAST(1000000.00 AS Decimal(18, 2)), 12, CAST(N'2025-01-01' AS Date))
INSERT [dbo].[LoanPackages] ([package_id], [staff_id], [package_name], [loan_type], [description], [interest_rate], [max_amount], [min_amount], [loan_term], [created_date]) VALUES (2, 1, N'Discounted Unsecured Loan Package', N'unsecured ', N'Special interest rates for individual customers.', CAST(7.50 AS Decimal(5, 2)), CAST(100000000.00 AS Decimal(18, 2)), CAST(5000000.00 AS Decimal(18, 2)), 24, CAST(N'2025-01-10' AS Date))
INSERT [dbo].[LoanPackages] ([package_id], [staff_id], [package_name], [loan_type], [description], [interest_rate], [max_amount], [min_amount], [loan_term], [created_date]) VALUES (3, NULL, N'Unsecured Business Loan Package', N'unsecured ', N'Suitable for small businesses.', CAST(9.00 AS Decimal(5, 2)), CAST(200000000.00 AS Decimal(18, 2)), CAST(20000000.00 AS Decimal(18, 2)), 36, CAST(N'2025-01-20' AS Date))
INSERT [dbo].[LoanPackages] ([package_id], [staff_id], [package_name], [loan_type], [description], [interest_rate], [max_amount], [min_amount], [loan_term], [created_date]) VALUES (4, NULL, N'Real Estate Secured Loan Package', N'secured   ', N'Loans secured by land use rights or real estate.', CAST(6.50 AS Decimal(5, 2)), CAST(1000000000.00 AS Decimal(18, 2)), CAST(50000000.00 AS Decimal(18, 2)), 60, CAST(N'2025-01-15' AS Date))
INSERT [dbo].[LoanPackages] ([package_id], [staff_id], [package_name], [loan_type], [description], [interest_rate], [max_amount], [min_amount], [loan_term], [created_date]) VALUES (5, NULL, N'Car Secured Loan Package', N'secured   ', N'Loans secured by car documents.', CAST(7.00 AS Decimal(5, 2)), CAST(500000000.00 AS Decimal(18, 2)), CAST(30000000.00 AS Decimal(18, 2)), 48, CAST(N'2025-01-25' AS Date))
INSERT [dbo].[LoanPackages] ([package_id], [staff_id], [package_name], [loan_type], [description], [interest_rate], [max_amount], [min_amount], [loan_term], [created_date]) VALUES (6, NULL, N'Other Assets Secured Loan Package', N'secured   ', N'For high-value assets.', CAST(6.80 AS Decimal(5, 2)), CAST(2000000000.00 AS Decimal(18, 2)), CAST(100000000.00 AS Decimal(18, 2)), 72, CAST(N'2025-02-01' AS Date))
SET IDENTITY_INSERT [dbo].[LoanPackages] OFF
GO
SET IDENTITY_INSERT [dbo].[LoanRequests] ON 

INSERT [dbo].[LoanRequests] ([request_id], [staff_id], [package_id], [customer_id], [request_date], [amount], [status], [start_date], [end_date], [approval_date], [approved_by], [approved_note], [asset_id]) VALUES (24, NULL, 4, 69, CAST(N'2025-03-20T00:00:00.000' AS DateTime), 51000000, N'Approved', CAST(N'2025-03-20T10:00:45.007' AS DateTime), CAST(N'2030-03-20T10:00:45.007' AS DateTime), CAST(N'2025-03-20T10:00:45.007' AS DateTime), N'1', N'ok', NULL)
INSERT [dbo].[LoanRequests] ([request_id], [staff_id], [package_id], [customer_id], [request_date], [amount], [status], [start_date], [end_date], [approval_date], [approved_by], [approved_note], [asset_id]) VALUES (25, NULL, 5, 69, CAST(N'2025-03-20T00:00:00.000' AS DateTime), 31000000, N'Approved', CAST(N'2025-03-20T10:01:21.343' AS DateTime), CAST(N'2029-03-20T10:01:21.343' AS DateTime), CAST(N'2025-03-20T10:01:21.343' AS DateTime), N'1', N'Approved by giangnv', NULL)
INSERT [dbo].[LoanRequests] ([request_id], [staff_id], [package_id], [customer_id], [request_date], [amount], [status], [start_date], [end_date], [approval_date], [approved_by], [approved_note], [asset_id]) VALUES (26, NULL, 2, 69, CAST(N'2025-03-20T00:00:00.000' AS DateTime), 6000000, N'Approved', CAST(N'2025-03-20T10:01:25.147' AS DateTime), CAST(N'2027-03-20T10:01:25.147' AS DateTime), CAST(N'2025-03-20T10:01:25.147' AS DateTime), N'1', N'Approved by giangnv', NULL)
INSERT [dbo].[LoanRequests] ([request_id], [staff_id], [package_id], [customer_id], [request_date], [amount], [status], [start_date], [end_date], [approval_date], [approved_by], [approved_note], [asset_id]) VALUES (27, NULL, 6, 69, CAST(N'2025-03-20T00:00:00.000' AS DateTime), 500000000, N'Approved', CAST(N'2025-03-20T10:02:45.190' AS DateTime), CAST(N'2031-03-20T10:02:45.190' AS DateTime), CAST(N'2025-03-20T10:02:45.190' AS DateTime), N'1', N'Approved by giangnv', NULL)
INSERT [dbo].[LoanRequests] ([request_id], [staff_id], [package_id], [customer_id], [request_date], [amount], [status], [start_date], [end_date], [approval_date], [approved_by], [approved_note], [asset_id]) VALUES (28, NULL, 1, 69, CAST(N'2025-03-24T00:00:00.000' AS DateTime), 20000000, N'Pending', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[LoanRequests] ([request_id], [staff_id], [package_id], [customer_id], [request_date], [amount], [status], [start_date], [end_date], [approval_date], [approved_by], [approved_note], [asset_id]) VALUES (29, NULL, 4, 69, CAST(N'2025-03-24T00:00:00.000' AS DateTime), 51000000, N'Approved', CAST(N'2025-03-24T11:47:55.723' AS DateTime), CAST(N'2030-03-24T11:47:55.723' AS DateTime), CAST(N'2025-03-24T11:47:55.723' AS DateTime), N'1', N'Approved by giangnv', NULL)
INSERT [dbo].[LoanRequests] ([request_id], [staff_id], [package_id], [customer_id], [request_date], [amount], [status], [start_date], [end_date], [approval_date], [approved_by], [approved_note], [asset_id]) VALUES (30, NULL, 6, 75, CAST(N'2025-03-29T00:00:00.000' AS DateTime), 100000000, N'Pending', NULL, NULL, NULL, NULL, NULL, 6)
INSERT [dbo].[LoanRequests] ([request_id], [staff_id], [package_id], [customer_id], [request_date], [amount], [status], [start_date], [end_date], [approval_date], [approved_by], [approved_note], [asset_id]) VALUES (31, NULL, 6, 75, CAST(N'2025-03-29T00:00:00.000' AS DateTime), 300000000, N'Pending', NULL, NULL, NULL, NULL, NULL, 6)
SET IDENTITY_INSERT [dbo].[LoanRequests] OFF
GO
SET IDENTITY_INSERT [dbo].[News] ON 

INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (27, 1, N'Cảnh báo lừa đảo liên quan đến giải chạy Vietcombank Run & Share 2025', N'<p><strong>Theo ghi nhận của Ngân hàng TMCP Ngoại thương Việt Nam (Vietcombank), gần đây đã xuất hiện một số fanpage giả mạo giải chạy Vietcombank Run &amp; Share 2025 nhằm lừa đảo và chiếm đoạt tài sản của người có nhu cầu đăng ký tham gia.</strong></p><p><br>&nbsp;</p><p>Cụ thể, các fanpage này sử dụng trái phép logo, hình ảnh và thông tin của giải chạy để tạo lòng tin. Các đối tượng lừa đảo kêu gọi người dân chuyển tiền để đăng ký tham gia, thậm chí hướng dẫn tham gia các nhóm trên Zalo hoặc Telegram để thực hiện các “nhiệm vụ” nhằm hưởng ưu đãi như miễn phí chi phí tham gia hoặc quà tặng.</p><figure class="image"><img style="aspect-ratio:770/600;" src="https://www.vietcombank.com.vn/-/media/Project/VCB-Sites/VCB/Tin-tuc/2025/Don-vi-thanh-vien/Don-vi-thanh-vien_202503/Don-vi-thanh-vien_20250301/20250307NMHCanh-bao-giai-chay-VCBNews.png?ts=20250310075513" width="770" height="600"></figure><p>Những “nhiệm vụ” này thường yêu cầu người tham gia chuyển tiền vào tài khoản cá nhân hoặc tổ chức với lời hứa sẽ được hoàn lại ngay. Ban đầu, các đối tượng lừa đảo thường hoàn tiền đầy đủ kèm theo lợi nhuận để tạo sự tin tưởng. Tuy nhiên, sau khi nạn nhân chuyển số tiền lớn hơn, chúng sẽ chặn liên lạc và chiếm đoạt tài sản.</p><p>Vietcombank khẳng định giải chạy Vietcombank Run &amp; Share 2025 không thu phí đăng ký. Mọi thông tin chính thức về giải chạy chỉ được đăng tải trên website chính thức của ngân hàng tại địa chỉ <a href="https://www.vietcombank.com.vn/">https://www.vietcombank.com.vn</a>, fanpage chính thức tại <a href="https://facebook.com/ilovevcb">https://facebook.com/</a>ilovevcb và fanpage chính thức của Đoàn Thanh niên Vietcombank tại địa chỉ <a href="https://www.facebook.com/tuoitrevcb">https://www.facebook.com/tuoitrevcb</a> cũng như website chính thức của giải chạy: <a href="https://vcbrace.vrun.vn/">https://vcbrace.vrun.vn</a>. Tất cả các hình thức đăng ký khác đều là giả mạo.</p><p>Ngân hàng khuyến cáo khách hàng và người dân chỉ đăng ký tham gia qua kênh chính thức của Vietcombank, không chuyển tiền hoặc làm theo hướng dẫn của bất kỳ fanpage hay nhóm chat nào không rõ nguồn gốc. Trước khi tham gia, người dân cần tìm hiểu kỹ về tư cách pháp nhân của đơn vị tổ chức để đảm bảo tính minh bạch. Nếu phát hiện dấu hiệu lừa đảo, khách hàng cần báo ngay cho cơ quan chức năng để có biện pháp xử lý kịp thời.</p><p>Trước đây, tình trạng giảmạo tương tựđã xảy ra vào năm 2024 với một loạt các giải chạy do Vietcombank tổ chức hoặc tài trợ. Vietcombank khi đó đã phát đicảnh báo tại: <a href="https://www.vietcombank.com.vn/vi-VN/Trang-thong-tin-dien-tu/Articles/2024/07/22/20240722_VCB-canh-bao-gia-mao-giai-chay">https://www.vietcombank.com.vn/vi-VN/Trang-thong-tin-dien-tu/Articles/2024/07/22/20240722_VCB-canh-bao-gia-mao-giai-chay</a></p>', 1, CAST(N'2025-03-13T10:36:57.927' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (29, 62, N'Vietcombank ra mắt Online Lending (Giải Ngân Trực Tuyến): Số hóa giải ngân - nhận ngàn tiện ích', N'<p>Vietcombank tự hào giới thiệu <strong>Online Lending</strong> - giải pháp giải ngân trực tuyến ưu việt, được thiết kế nhằm đáp ứng nhu cầu vốn một cách nhanh chóng và hiệu quả cho doanh nghiệp. Với sự đầu tư mạnh mẽ vào công nghệ số hóa, Online Lending giúp đơn giản hóa quy trình giải ngân, tiết kiệm thời gian và nâng cao trải nghiệm khách hàng.</p><figure class="image"><img style="aspect-ratio:1200/922;" src="https://www.vietcombank.com.vn/-/media/Project/VCB-Sites/VCB/Tin-tuc/2025/Vietcombank/Vietcombank_202502/Vietcombank_20250221/20250228_VCB-ra-mat-online-lending-ver-viet.png?ts=20250228074113" width="1200" height="922"></figure><h3><strong>LỢI ÍCH NỔI BẬT CỦA ONLINE LENDING:</strong></h3><p><strong>1. Hồ sơ online, tiện lợi</strong></p><p>Khách hàng chủ động theo dõi trạng thái hồ sơ và tiến độ xử lý qua hệ thống trực tuyến.</p><p><strong>2. Ký số mọi lúc, mọi nơi</strong></p><p>Không còn phụ thuộc vào giấy tờ hay địa điểm, với tính năng ký số mọi lúc, mọi nơi, doanh nghiệp có thể xử lý hồ sơ giải ngân một cách nhanh gọn, giúp tiết kiệm thời gian và tối ưu hiệu suất làm việc.</p><p><strong>3. Thông tin minh bạch, tức thời</strong></p><p>Mọi thông tin về khoản giải ngân được công khai rõ ràng, đảm bảo doanh nghiệp luôn kiểm soát dòng tiền hiệu quả.</p><p><strong>QUY TRÌNH GIẢI NGÂN CHỈ VỚI 6 BƯỚC ĐƠN GIẢN:</strong></p><p>1. Đăng ký dịch vụ giải ngân trực tuyến (cung cấp chữ ký số và hợp đồng tín dụng).</p><p>2. Tạo đề nghị giải ngân.</p><p>3. Ký số hồ sơ.</p><p>4. Vietcombank thẩm định và phê duyệt hồ sơ.</p><p>5. Giải ngân thành công.</p><p>6. Quản lý và theo dõi hồ sơ sau vay trên hệ thống.</p><h3><strong>ƯU ĐÃI ĐẶC BIỆT:</strong></h3><p><strong>- Miễn phí chuyển tiền giải ngân</strong> đến hết tháng <strong>3/2025</strong></p><p>- Nhận <strong>ưu đãi chữ ký số</strong> từ các đối tác uy tín của Vietcombank</p><p><strong>ĐIỀU KIỆN ĐĂNG KÝ SỬ DỤNG DỊCH VỤ</strong></p><h3><strong>Điều kiện khách hàng</strong></h3><p><strong>1. Đăng ký dịch vụ</strong></p><p>- Đã đăng ký giao dịch qua kênh Ngân hàng số của VCB (VCB-iBanking/VCB CashUp).</p><p>- Chữ ký số hợp lệ tại thời điểm giải ngân, gồm chữ ký số tổ chức và cá nhân đại diện.</p><p><strong>2. Cá nhân tham gia giao dịch</strong></p><p>- Tổ chức phải có kế toán trưởng/người phụ trách kế toán đăng ký với VCB.</p><p>- Người phê duyệt cuối cùng là đại diện pháp luật hoặc người được ủy quyền, có đăng ký chữ ký số với VCB.</p><p><strong>3. Hợp đồng tín dụng</strong></p><p>- Hợp đồng vay ngắn hạn còn hiệu lực.</p><p>- Mục đích vay phù hợp với quy định của VCB trong từng thời kỳ.</p><p>Quý khách vui lòng liên hệ hotline 1900 54 54 13 hoặc Chi nhánh/Phòng Giao dịch Vietcombank gần nhất để được hõ trợ.</p>', 1, CAST(N'2025-03-13T10:49:21.160' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (30, 61, N'Techcombank tiếp tục là nhà đồng đầu tư Concert Anh Trai Vượt Ngàn Chông Gai đêm thứ 3, 4', N'<p>Với những sân khấu “đỉnh nóc” và “cơn sốt săn vé” trước đây, concert lần này hứa hẹn sẽ tạo nên hiệu ứng bùng nổ “kịch trần”. Đáp lại lòng mong đợi từ người hâm mộ và các khách hàng, Techcombank mang đến thêm cơ hội “săn vé” cực kì hấp dẫn.</p><p><br><img src="https://techcombank.com/thong-tin/thong-bao/techcombank-tiep-tuc-la-nha-dong-dau-tu-concert-anh-trai-vuot-ngan-chong-gai-dem-thu-3-4/_jcr_content/root/container/image_copy.coreimg.png/1737687226463/atvncg-1.png" width="1280" height="1605"></p><p>Kết lại một hành trình đáng nhớ với nhiều dấu ấn thành công và kỉ niệm đẹp, Concert Anh Trai Vượt Ngàn Chông Gai đêm diễn thứ 3 và thứ 4 vào ngày 22, 23/03/2025 sẽ tiếp tục khuấy động không gian âm nhạc Việt Nam tại khu phức hợp giải trí mới của TP. Hồ Chí Minh là The Global City, Đường Đỗ Xuân Hợp, Phường An Phú, Thành phố Thủ Đức, Thành phố Hồ Chí Minh.</p><p><img src="https://techcombank.com/thong-tin/thong-bao/techcombank-tiep-tuc-la-nha-dong-dau-tu-concert-anh-trai-vuot-ngan-chong-gai-dem-thu-3-4/_jcr_content/root/container/image.coreimg.jpeg/1737687249798/atvncg-2.jpeg" width="1280" height="784"></p><p><br>Và Techcombank lại cùng Yeah 1 mang đến những chương trình săn vé hấp dẫn. Xuyên suốt “cơn sốt” săn vé của cộng đồng người hâm mộ trước đây, ngân hàng đã liên tục lắng nghe các phản hồi và đưa ra nhiều cách thức hấp dẫn để khách hàng sở hữu vé, đồng thời trải nghiệm thêm các sản phẩm đột phá. Cụ thể với đêm concert thứ 2 tại Hà Nội, gần 500 ngàn khách hàng đã tham gia chương trình nhận vé ưu đãi từ Techcombank, tạo nên hơn 1 triệu lượt thảo luận trên mạng xã hội. Khẳng định tầm nhìn chiến lược của ngân hàng là “thay đổi ngành tài chính, nâng tầm giá trị sống”, Techcombank không chỉ góp phần mang lại trải nghiệm âm nhạc đỉnh cao, mà còn tiên phong đem đến các giải pháp quản lý tài chính cá nhân độc đáo.</p><p>&nbsp;</p><p>Ngoài việc nhận được vé tham dự concert, khách hàng còn được trải nghiệm giải pháp Sinh Lời Tự Động từ Techcombank - một sáng kiến mới trong ngành tài chính, hỗ trợ tối ưu sinh lời trên các dòng tiền ngắn ngày đang chờ chi tiêu. Hàng triệu khách hàng đang sử dụng tài khoản thanh toán để thực hiện chi tiêu tiện lợi và an toàn với công nghệ bảo mật tiên tiến.</p><p><img src="https://techcombank.com/thong-tin/thong-bao/techcombank-tiep-tuc-la-nha-dong-dau-tu-concert-anh-trai-vuot-ngan-chong-gai-dem-thu-3-4/_jcr_content/root/container/image_copy_965816491.coreimg.png/1737687887053/atvncg-3.png" width="900" height="600"></p><p><br>Sau khi kích hoạt Techcombank Sinh Lời Tự Động, toàn bộ dòng tiền này sẽ được hưởng lợi suất hấp dẫn gấp đến 50 lần mỗi ngày so với lãi suất không kỳ hạn khi chưa bật sản phẩm Sinh Lời Tự Động từ Techcombank, và điều này vẫn đảm bảo giao dịch chi tiêu liền mạch 24/7.</p><p>&nbsp;</p><p>Với cơ chế sinh lời độc đáo - “tiền càng nhiều, càng thêm lời”, khách hàng giờ đây không còn cần phải để tiền lâu hơn mới có lợi suất cao hơn. Toàn bộ dòng tiền sẽ được tối ưu trọn vẹn từng ngày và vẫn sẵn sàng chi tiêu khi cần. Thực tế chứng minh, đã có hơn 2 triệu khách hàng kích hoạt Techcombank Sinh Lời Tự Động, tận hưởng lợi ích sinh lời hấp dẫn trên khoản tiền chờ thanh toán và chi tiêu của khách hàng.</p><p>&nbsp;</p><p>Ngày 17/01/2025, Techcombank đã chính thức công bố cách thức “săn vé” đến concert, để người hâm mộ lại một lần đắm chìm trong âm nhạc và nghệ thuật đỉnh cao.</p><p>&nbsp;</p><p><strong>Cách thức sở hữu vé tham dự concert từ Techcombank</strong></p><p>&nbsp;</p><p>Khi tham gia chương trình “Săn Vé Anh Tài” được triển khai từ ngày 18/01/2025 với những cách thức tham gia dễ dàng, quen thuộc, khách hàng sẽ có cơ hội sở hữu vé concert "miễn phí".</p><p>&nbsp;</p><p>Đối với hình thức tích lũy vòng quay may mắn “săn vé anh tài”, chương trình sẽ chính thức triển khai từ 18/01/2025 và kéo dài đến ngày 02/03/2025. Dự kiến sẽ có khoảng gần 15,000 khách hàng nhận được ưu đãi tặng vé thông qua vòng quay “săn vé anh tài”, với tổng giá trị quà tặng mà Techcombank dành cho khách hàng lên tới hơn 16 tỉ đồng.</p><p>&nbsp;</p><p>Ngoài ra, khi giao dịch QR trên ứng dụng Techcombank Mobile với giá trị giao dịch từ 500 ngàn đồng trở lên trong ngày, hoặc phát sinh giao dịch thanh toán qua thẻ thanh toán Techcombank/ thẻ tín dụng Techcombank tối thiểu 100 ngàn đồng, khách hàng cũng có cơ hội nhận được vé quay thưởng mỗi ngày trong tối thiểu 05 (năm) ngày thuộc Đợt tích lũy vé quay.</p><figure class="image"><img style="aspect-ratio:1280/853;" src="https://techcombank.com/thong-tin/thong-bao/techcombank-tiep-tuc-la-nha-dong-dau-tu-concert-anh-trai-vuot-ngan-chong-gai-dem-thu-3-4/_jcr_content/root/container/image_copy_965816491_1934123632.coreimg.jpeg/1737687912513/atvncg-4.jpeg" width="1280" height="853"></figure><p>Khách hàng có thể tham gia cùng lúc 2 cách thức để gia tăng cơ hội tích lũy vé quay may mắn và tận hưởng các đặc quyền từ Techcombank; vừa tối ưu dòng tiền cùng Sinh Lời Tự Động, vừa tận hưởng hàng loạt ưu đãi khi thực hiện chi tiêu cùng Techcombank.</p><p>&nbsp;</p>', 1, CAST(N'2025-03-13T10:56:17.630' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (31, 63, N'Vietcombank là ngân hàng đầu tiên ra mắt tính năng “Thông báo số dư bằng giọng nói” (Voice OTT) trên app ngân hàng số', N'<p>Ngày 20/2/2025, Vietcombank chính thức giới thiệu tính năng <strong>Voice OTT - Thông báo biến động số dư bằng giọng nói</strong> trên ứng dụng VCB Digibank<strong>, </strong>giúp người dùng nhận biết được số tiền chuyển đến đến mà không cần mở ứng dụng.</p><figure class="image"><img style="aspect-ratio:900/555;" src="https://www.vietcombank.com.vn/-/media/Project/VCB-Sites/VCB/Tin-tuc/2025/Vietcombank/Vietcombank_202502/Vietcombank_20250221/20250224_VCB_Thong-tin-bao-chi-Voice-OTT_Anh-1.jpg?ts=20250224100600" width="900" height="555"></figure><p>Tính năng <strong>Voice OTT</strong> đặc biệt hữu ích với người bán hàng, hộ kinh doanh cá thể và những người thường xuyên nhận giao dịch chuyển khoản, giúp khách hàng thuận tiện hơn trong công việc kinh doanh thường ngày với các lợi ích nổi bật:</p><p><strong>Miễn phí hoàn toàn</strong>: Khách hàng không phải trả thêm bất kỳ chi phí nào khi sử dụng tính năng này.</p><p><strong>Cài đặt nhanh chóng</strong>: Chỉ mất chưa đến một phút để kích hoạt trực tiếp trên ứng dụng VCB Digibank.</p><p><strong>Không cần liên kết ứng dụng thứ ba</strong>: Đơn giản hóa quá trình sử dụng.</p><p><strong>Thông báo qua loa điện thoại</strong>: Khi có giao dịch đến, hệ thống sẽ phát thông báo bằng giọng nói qua loa điện thoại, giúp khách hàng nhận biết ngay lập tức mà không cần mở ứng dụng hay màn hình điện thoại.</p><p><strong>Hỗ trợ kết nối loa Bluetooth</strong>: Đối với môi trường ồn ào hoặc khi cần âm lượng lớn hơn, khách hàng có thể kết nối điện thoại với loa/tai nghe Bluetooth để nhận thông báo rõ ràng hơn.</p><p><i>Lưu ý: Để tính năng hoạt động hiệu quả, điện thoại của người dùng cần tắt chế độ im lặng và cho phép ứng dụng VCB Digibank gửi thông báo.</i></p><figure class="image"><img style="aspect-ratio:900/555;" src="https://www.vietcombank.com.vn/-/media/Project/VCB-Sites/VCB/Tin-tuc/2025/Vietcombank/Vietcombank_202502/Vietcombank_20250221/20250224_VCB_Thong-tin-bao-chi-Voice-OTT_Anh-1.jpg?ts=20250224100600" width="900" height="555"></figure><figure class="image"><img style="aspect-ratio:900/964;" src="https://www.vietcombank.com.vn/-/media/Project/VCB-Sites/VCB/Tin-tuc/2025/Vietcombank/Vietcombank_202502/Vietcombank_20250221/20250224_VCB_Thong-tin-bao-chi-Voice-OTT_Anh-3.jpg?ts=20250224100601" width="900" height="964"></figure><p>Khác với loa thông báo nhận tiền, tính năng Voice OTT không yêu cầu cài đặt ứng dụng bên thứ ba hay đầu tư thêm thiết bị. Ngoài ra, người dùng có thể dễ dàng kết hợp Voice OTT với các tính năng khác dành cho người bán hàng như: <i>QR bán hàng; chia sẻ biến động số dư; liên kết với phần mềm KiotViet…</i> để tối ưu vận hành kinh doanh.</p><p>Với việc ra mắt Voice OTT, Vietcombank tiếp tục khẳng định cam kết mang đến khách hàng những giải pháp ngân hàng số hiện đại, liên tục đổi mới sáng tạo để nâng cao trải nghiệm của khách hàng trong thời đại công nghệ số.</p><p><br>&nbsp;</p>', 1, CAST(N'2025-03-14T15:31:06.897' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (40, 1, N'Nữ giao dịch viên Vietcombank Nam Đà Nẵng giúp khách hàng tránh bị lừa đảo 230 triệu đồng', N'<p><strong>Thời gian gần đây, tội phạm công nghệ cao liên tục gia tăng. Bằng nhiều thủ đoạn, các đối tượng đã tiếp cận người dân qua mạng xã hội, mạng viễn thông, thao túng tâm lý và dẫn dụ người dân để đánh cắp thông tin, từng bước chiếm đoạt tài sản. Trước thực trạng đó, Vietcombank Nam Đà Nẵng đã tích cực tuyên truyền, cảnh báo các phương thức của tội phạm lừa đảo. Cán bộ nhân viên Vietcombank Nam Đà Nẵng chủ động cập nhật thông tin, nâng cao kiến thức nghiệp vụ, đề cao cảnh giác, nhanh chóng nhận diện dấu hiệu lạ của khách hàng và kịp thời ngăn chặn các hành vi lừa đảo.</strong></p><figure class="image"><img style="aspect-ratio:900/599;" src="https://www.vietcombank.com.vn/-/media/Project/VCB-Sites/VCB/Tin-tuc/2024/Don-vi-thanh-vien/Don-vi-thanh-vien_202412/Don-vi-thanh-vien_20241201/20241210_NamDaNang_Nu-giao-dich-vien-giup-KH-tranh-bi-lua-dao-230-trieu-dong_Anh-1.jpg?ts=20241211024009" width="900" height="599"></figure><p>Điển hình như vừa qua, chiều ngày 05/12/2024, bà Mai Thị Huyền đến đăng ký dịch vụ VCB Digibank. Tuy nhiên, nhân viên giao dịch nhận thấy khách hàng có các biểu hiện lạ như thái độ sợ sệt, trong lúc giao dịch liên tục ra ngoài nghe điện thoại. Cụ thể, người gọi đe dọa tự xưng là cán bộ PC02 Công an TP.Đà Nẵng, yêu cầu bà Huyền chuyển 230 triệu đồng, nếu không sẽ bị bắt giam.</p><p>Với kinh nghiệm và kiến thức được trang bị, chị Nguyễn Thị Tâm Đăng (giao dịch viên) suy đoán có thể khách hàng đang bị các đối tượng xấu lợi dụng để lừa đảo. Cùng với việc phân tích tình huống cho khách hàng, giao dịch viên đã nhanh chóng đề nghị và được Công an phường Mỹ An điều cán bộ, chiến sĩ đến phòng giao dịch để hỗ trợ.</p><figure class="image"><img style="aspect-ratio:900/600;" src="https://www.vietcombank.com.vn/-/media/Project/VCB-Sites/VCB/Tin-tuc/2024/Don-vi-thanh-vien/Don-vi-thanh-vien_202412/Don-vi-thanh-vien_20241201/20241210_NamDaNang_Nu-giao-dich-vien-giup-KH-tranh-bi-lua-dao-230-trieu-dong_Anh-2.jpg?ts=20241211024009" width="900" height="600"></figure><p>Sau khi biết mình suýt bị chiếm đoạt tài sản và may mắn được hỗ trợ kịp thời, bà Mai Thị Huyền (52 tuổi, ngụ tổ 13 P.Hòa Hải, Q.Ngũ Hành Sơn, TP.Đà Nẵng) đã có thư cảm ơn sâu sắc tới phòng giao dịch Ngũ Hành Sơn - Vietcombank Nam Đà Nẵng và công an phường sở tại.</p>', 1, CAST(N'2025-03-17T07:41:30.233' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (41, 61, N'Lưu ý về dấu hiệu nhận biết ứng dụng chính thức của Chính phủ trên chợ ứng dụng Google Play/CH Play để không bị lừa đảo cài đặt app giả mạo', N'<p><i><strong>1.Thời gian vừa qua, thủ đoạn lừa đảo khách hàng cài đặt app giả mạo ứng dụng của các cơ quan công quyền (ví dụ: App giả mạo Dịch vụ công, Cơ quan thuế, VNeID ....), từ đó chiếm quyền điều khiển điện thoại và chiếm đoạt tiền trong tài khoản ngân hàng có diễn biến phức tạp.</strong></i></p><p>Nhằm tăng cường bảo vệ người dân, Cục An toàn thông tin đã phối hợp cùng Google ra mắt tính năng <strong>“Ứng dụng chính thức của Chính phủ”,</strong> giúp người dân dễ dàng phân biệt và xác minh các ứng dụng chính thống.</p><p>Cụ thể, khi truy cập chợ ứng dụng Google (Google Play/CH Play), các ứng dụng chính thức của Chính phủ sẽ hiển thị biểu tượng “Chính phủ” trên phần thông tin ứng dụng, giúp người dùng yên tâm về tính xác thực và độ tin cậy của ứng dụng.</p><figure class="image"><img style="aspect-ratio:1600/1267;" src="https://www.vietcombank.com.vn/-/media/Project/VCB-Sites/VCB/KHCN/KHCN_Quick-Access/TIN-TUC-NOI-BAT/2024/Thang-12/Canh-bao-ve-app/hinh-anh-minh-hoa.jpg?ts=00010101000000" width="1600" height="1267"></figure><p>Hiện tại, rất nhiều ứng dụng tại Việt Nam đã được cấp nhận diện ứng dụng chính thức của Chính phủ như: <strong>VNeID, VssID, i-SPEED byVNNIC, Hóa Đơn Điện Tử TCT, Dịch Vụ Công Bộ Y Tế.... </strong>(danh sách được công bố tại Hệ thống Tín nhiệm mạng - tinnhiemmang.vn).<br><br>Quý khách hàng sử dụng hệ điều hành android hãy lưu ý chỉ tải ứng dụng từ kho ứng dụng chính thức của Google (Google Play/CH Play) và kiểm tra thông tin khi tải các ứng dụng chính thức của Chính phủ theo dấu hiệu nhận biết nêu trên.</p><p><a href="https://vietcombank.com.vn/-/media/Project/VCB-Sites/VCB/KHCN/KHCN_Quick-Access/TIN-TUC-NOI-BAT/2024/Thang-12/Thong-tu-50/Cam-nang-HDGDAT-new-one.pdf?ts=20241231074800"><strong>HƯỚNG DẪN GIAO DỊCH AN TOÀN</strong></a></p><p>Ngoài ra, Quý khách đừng quên thực hiện theo các thông tin hướng dẫn giao dịch an toàn trên website của Vietcombank.</p>', 1, CAST(N'2025-03-29T22:28:36.183' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (43, 62, N'Cảnh báo thủ đoạn lừa đảo phát hành thẻ, đánh cắp thông tin thẻ để liên kết ví và chiếm đoạt tiền', N'<p>&nbsp;Thời gian vừa qua, đã xuất hiện hình thức lừa đảo khách hàng phát hành thẻ, đánh cắp thông tin thẻ để liên kết Ví điện tử và chiếm đoạt tiền với thủ đoạn như sau:</p><p><strong>Kẻ gian gọi điện, gửi tin nhắn điện thoại (SMS), Zalo… nhằm thuyết phục Khách hàng chủ động mở thẻ ghi nợ phi vật lý hoặc làm hồ sơ phát hành thẻ tín dụng tại ngân hàng.</strong></p><p><strong>Kẻ gian yêu cầu khách hàng cung cấp thông tin thẻ (hình ảnh thẻ cứng; dãy số in trên thẻ; tên trên thẻ; màn hình hiển thị số thẻ đầy đủ trong dịch vụ ngân hàng số Vietcombank Digibank…) và mã OTP được gửi tới số điện thoại của Khách hàng để liên kết thẻ với Ví điện tử hoặc nhập thông tin trên các website mua bán hàng hóa, dịch vụ trực tuyến.</strong></p><p><strong>Kẻ gian nạp tiền vào Ví điện tử của chúng từ thẻ đã liên kết của khách hàng hoặc sử dụng thẻ của khách hàng để chi tiêu trực tuyến trên các website mua bán hàng hóa/dịch vụ, từ đó chiếm đoạt tiền của khách hàng.</strong></p><p>Để đảm bảo an toàn khi giao dịch thẻ, Vietcombank xin khuyến cáo tới Quý khách hàng:</p><p>Kẻ gian nạp tiền vào Ví điện tử của chúng từ thẻ đã liên kết của khách hàng hoặc sử dụng thẻ của khách hàng để chi tiêu trực tuyến trên các website mua bán hàng hóa/dịch vụ, từ đó chiếm đoạt tiền của khách hàng.</p><p>Không cung cấp thông tin thẻ, không chia sẻ mã OTP cho bất kỳ ai. Vietcombank không gọi điện hay gửi tin nhắn qua các kênh mạng xã hội yêu cầu Khách hàng cung cấp thông tin bảo mật dịch vụ dưới mọi hình thức.</p><p>Chỉ liên lạc trực tiếp và nhận thông tin qua các kênh thông tin chính thức sau của Vietcombank:</p><p>1. Website chính thức của Vietcombank: <a href="https://www.vietcombank.com.vn/">tại đây </a>- được đánh dấu website an toàn bằng hình ổ khóa bên cạnh.<br><br>2. Tài khoản mạng xã hội: Facebook: Vietcombank (có dấu tích xanh do Facebook xác nhận)</p><figure class="image"><img style="aspect-ratio:1316/345;" src="https://www.vietcombank.com.vn/-/media/Project/VCB-Sites/VCB/KHCN/KHCN_Quick-Access/TIN-TUC-NOI-BAT/2024/T7/canh-bao-rui-ro-lua-dao/anh-nd-canh-bao-TL-LKV-T.png?ts=20240729072446" width="1316" height="345"></figure><p>3. Email đến từ Vietcombank luôn có đuôi @info.vietcombank.com.vn</p><p>4. Hotline 1900545413 và các số điện thoại gọi ra (danh sách tại đây).</p><p>5. Hotline 18001565 dành riêng cho Quý khách hàng Priority/Chủ thể hạng Platinum trở lên</p><p>6. Chuyên viên Chăm sóc khách hàng Priority với thông tin liên hệ được hiển thị tại VCB Digibank – Mục Cài đặt/Liên hệ với Vietcombank/Chuyên viên chăm sóc chuyên trách</p><p>Ngoài ra, Quý khách vui lòng đọc kỹ và tuân theo các thông tin hướng dẫn giao dịch an toàn của Vietcombank<a href="https://www.vietcombank.com.vn/vi-VN/KHCN/Danh-sach-nguyen-tac-GDAT#safetytransactioncategories=C%E1%BA%A3nh%20b%C3%A1o%20r%E1%BB%A7i%20ro"> tại đây</a><br>Vietcombank kính mong Quý khách luôn cẩn trọng và thực hiện giao dịch an toàn trên các nền tảng số và mạng xã hội.</p>', 1, CAST(N'2025-03-17T07:54:17.907' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (44, 63, N'Vietcombank cảnh báo hình thức giả mạo dưới hình thức tuyển dụng', N'<p><strong>1Trong thời gian qua, Vietcombank tiếp tục ghi nhận được những thông tin phản ánh về việc một số đối tượng mạo danh Vietcombank thực hiện các hành vi có dấu hiệu lừa đảo, chiếm đoạt tài sản, thông tin.</strong></p><p>Cụ thể như sau:</p><figure class="image"><img style="aspect-ratio:621/803;" src="https://www.vietcombank.com.vn/-/media/Project/VCB-Sites/VCB/Tin-tuc/2024/Vietcombank/Vietcombank_202407/Vietcombank_20240721/Canh-bao-gia-mao_thu-moi-tuyen-dung.jpg?ts=20240725090356" width="621" height="803"></figure><p><strong>Phương thức lừa đảo:</strong></p><p>Mạo danh Vietcombank gửi email thông báo tuyển dụng và mời phỏng vấn và yêu cầu ứng viên chuyển khoản một khoản tiền phí hoặc yêu cầu ứng viên tham gia vòng sơ tuyển online bằng cách tải ứng dụng/nhấn vào đường link,…</p><p>Lập nick giả mạo chuyên viên tuyển dụng Vietcombank và đề nghị ứng viên vào group zalo, telegram, sau đó dẫn dắt, hướng dẫn tải app/nhấn vào đường link/bình chọn ảnh/trải nghiệm và đánh giá sản phẩm/tham gia dự án/thực hiện nhiệm vụ/…</p><p>Tạo các trang fanpage/website giả mạo Tuyển dụng Vietcombank, kêu gọi ứng tuyển Vietcombank bằng cách nhấn vào đường link có mã độc virus nhằm đánh cắp thông tin cá nhân, chiếm quyền kiểm soát điện thoại,….</p><figure class="image"><img style="aspect-ratio:900/636;" src="https://www.vietcombank.com.vn/-/media/Project/VCB-Sites/VCB/Tin-tuc/2024/Vietcombank/Vietcombank_202407/Vietcombank_20240721/Canh-bao-gia-mao_thu-moi-tuyen-dung_tong-hop.jpg?ts=20240725090356" width="900" height="636"></figure><p><strong>VIETCOMBANK KHẲNG ĐỊNH</strong>:</p><p>KHÔNG THU BẤT KỲ KHOẢN PHÍ NÀO trong suốt quá trình tuyển dụng của ứng viên dưới mọi hình thức;</p><p>KHÔNG YÊU CẦU CUNG CẤP THÔNG TIN TÀI KHOẢN, GIAO DỊCH hay MÃ SỐ OTP;</p><p>KHÔNG LIÊN HỆ với ứng viên hay TỔ CHỨC vòng sơ loại online thông qua đường dẫn link/app trò chuyện;</p><p>CHỈ THÔNG BÁO, LIÊN HỆ với ứng viên ứng tuyển vào Vietcombank thông qua email với tên miền duy nhất:&nbsp;<strong>vietcombank.com.vn.&nbsp;</strong>Tất cả các tên miền khác đều là giả mạo;</p><p>TẤT CẢ CÁC BƯỚC TRONG QUÁ TRÌNH TUYỂN DỤNG ĐỀU THỰC HIỆN TẠI CÁC VĂN PHÒNG TRỤ SỞ CỦA VIETCOMBANK (Vietcombank chỉ tổ chức thi tuyển/phỏng vấn tại Trụ sở chính Vietcombank hoặc Trụ sở Chi nhánh, không thi tuyển/phỏng vấn tại các Phòng Giao dịch).</p><p>Các thông tin tuyển dụng của Vietcombank được công khai minh bạch trên fanpage và website chính thức của Vietcombank, cụ thể:</p><p>Fanpage Vietcombank:&nbsp;<a href="https://www.facebook.com/ilovevcb">https://www.facebook.com/ilovevcb</a></p><p>Website tuyển dụng Vietcombank:&nbsp;<a href="https://tuyendung.vietcombank.com.vn/">https://tuyendung.vietcombank.com.vn</a></p><p>👉<strong>&nbsp;Các ứng viên hãy tỉnh táo và cảnh giác cao độ để bảo vệ thông tin và tài sản:</strong></p><p>❌ &nbsp;KHÔNG thực hiện các giao dịch thanh toán.</p><p>❌&nbsp;KHÔNG chia sẻ thông tin bảo mật cá nhân.</p><p>❌&nbsp;KHÔNG nhấn vào đường link lạ, không rõ nguồn gốc.</p><p>❌&nbsp;KHÔNG thực hiện theo các hướng dẫn từ các nick giả mạo theo các chiêu thức lừa đảo để thực hiện nhiệm vụ/ủng hộ dự án/xổ số/…</p><p>Khi cần thêm thông tin về công tác tuyển dụng của Vietcombank, ứng viên vui lòng liên hệ đến số hotline tuyển dụng chính thức của Vietcombank: 0835588000 – 0835899000, hoặc gặp mặt trực tiếp bộ phận nhân sự tại Trụ sở các Chi nhánh trong hệ thống Vietcombank.</p><p>Hiện nay Vietcombank đang phối hợp với các cơ quan chức năng để làm rõ các hành vi của các đối tượng xấu đã mạo danh và sử dụng trái phép hình ảnh, thương hiệu Vietcombank để thực hiện lừa đảo.</p><p>Việc mạo danh, sử dụng trái phép hình ảnh, thương hiệu Vietcombank là vi phạm pháp luật và sẽ bị xử lý theo quy định của pháp luật.</p>', 1, CAST(N'2025-03-29T22:46:49.817' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (45, 1, N'Vietcombank và MobiFone ra mắt “Loa thần tài” với dịch vụ thông báo biến động tài khoản bằng giọng nói', N'<p><strong>Vietcombank và MobiFone vừa hợp tác ra mắt “Loa thần tài” với dịch vụ thông báo biến động tài khoản bằng giọng nói. Với dịch vụ này, khách hàng sẽ được thông báo bằng giọng nói qua thiết bị loa vật lý (Loa thần tài) của MobiFone mỗi khi có tiền chuyển đến tài khoản Vietcombank. Dịch vụ đặc biệt phù hợp với khách hàng kinh doanh, chủ shop, cửa hàng bán lẻ.</strong></p><figure class="image"><img style="aspect-ratio:1200/1200;" src="https://www.vietcombank.com.vn/-/media/Project/VCB-Sites/VCB/Tin-tuc/2025/Vietcombank/Vietcombank_202503/Vietcombank_20250321/web-avt.jpg?ts=20250326013911" alt="web-avt.jpg (1200×1200)" width="1200" height="1200"></figure><p><strong>LOA THẦN TÀI - “SIÊU TIỆN LỢI” CHO NGƯỜI BÁN HÀNG</strong></p><p>Loa thần tài là giải pháp ứng dụng công nghệ trí tuệ nhân tạo giúp thông báo chính xác kết quả trong từng giao dịch thanh toán thành công qua mã QR. Sản phẩm bao gồm hai phần: <i>Thiết bị loa thông báo (bao gồm loa vật lý, mã QR) và ứng dụng quản lý giao dịch (ứng dụng Loa thần tài).</i></p><p>Dịch vụ hợp tác giữa Vietcombank và MobiFone cho phép khách hàng nhận thông báo phát ra bằng giọng gói qua thiết bị Loa thần tài khi có biến động tăng số dư tài khoản thanh toán tại Vietcombank <i>(áp dụng với các giao dịch chuyển tiền đến mã QR gắn với tài khoản thanh toán do khách hàng chỉ định khi đăng ký dịch vụ).</i></p><p><strong>LỢI ÍCH NỔI BẬT</strong></p><p><strong>- Thông báo tức thì:</strong> Loa sẽ thông báo ngay bằng giọng nói khi có giao dịch tiền chuyển đến tài khoản.</p><p><strong>- Nhỏ gọn, dễ dàng sử dụng:</strong> Loa có thời lượng pin lâu và sạc nhanh qua dây sạc type C đi kèm. Đặc biệt, Loa có thể kết nối internet bằng cả Wifi và 4G/5G do MobiFone cung cấp.</p><p><strong>- Rảnh tay bán hàng, tiết kiệm thời gian:</strong> Giao dịch được phát qua thiết bị loa, không cần kiểm tra tài khoản nhận hay màn hình chuyển khoản, tiết kiệm thời gian.</p><p><strong>- Giảm thiểu rủi ro:</strong> Giúp giảm nguy cơ bỏ sót giao dịch và rủi ro gian lận (đặc biệt là với người bán hàng online).</p><p><strong>- Tích hợp báo cáo doanh số, giao dịch:</strong> Song song với nghe thông báo được phát bằng âm thanh từ loa, khách hàng cũng được cung cấp báo cáo chi tiết về giao dịch và doanh số chuyển tiền qua mã QR trên VCB Digibank.</p><p><strong>ĐẶT LOA THẦN TÀI Ở ĐÂU?</strong></p><p>Để sử dụng dịch vụ, trước tiên, khách hàng cần liên hệ với Chi nhánh Vietcombank để đặt mua loa. Sau đó, khách hàng đăng nhập vào ứng dụng Loa thần tài và kết nối tài khoản Vietcombank muốn nhận thông báo và xác thực qua VCB Digibank.</p><p>Trước đó, từ tháng 02/2025, Vietcombank đã ra mắt tính năng Voice OTT - Thông báo số dư bằng giọng nói trên VCB Digibank. Khác với Loa thần tài, tính năng Voice OTT hoạt động ngay trên App VCB Digibank và phát thông báo qua thiết bị loa điện thoại. Ngoài ra, tính năng Voice OTT cũng được cung cấp miễn phí.</p><p>Với việc ra mắt dịch vụ Loa thần tài hợp tác cùng MobiFone và tính năng Voice OTT đã cung cấp trước đó, khách hàng của Vietcombank có thêm lựa chọn về dịch vụ thông báo qua giọng nói, phù hợp với nhiều quy mô cửa hàng bán lẻ (diện tích, số quầy thu ngân …) và các nhu cầu kinh doanh đa dạng.</p>', 1, CAST(N'2025-03-28T22:01:51.150' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (46, 1, N'Vietcombank triển khai chương trình "Vững tâm đổi mới”: Giải pháp tài chính đặc biệt dành cho khách hàng từ 55 đến 62 tuổi', N'<p><strong>Kể từ ngày 19/03/2025, Vietcombank chính thức triển khai chương trình "Vững tâm đổi mới” - Giải pháp tài chính tin cậy, tối ưu dành cho khách hàng từ 55 đến 62 tuổi với đa dạng các chính sách ưu đãi về sản phẩm tiết kiệm, sản phẩm đầu tư, đặc quyền dành riêng cho Khách hàng Ưu tiên.</strong></p><p>Chương trình kỳ vọng mang đến cho khách hàng nhiều lựa chọn tối ưu, linh hoạt, giúp chủ động dòng tiền, gia tăng giá trị tài sản. Qua chương trình, Vietcombank đồng thời mong muốn đồng hành cùng các cán bộ, công chức, viên chức, người lao động và lực lượng vũ trang trong thực hiện sắp xếp tổ chức bộ máy của hệ thống chính trị theo Nghị định 178/2024/NĐ-CP ngày 31/12/2024 của Chính phủ, giúp khách hàng vững tâm đổi mới, phát triển và tận hưởng cuộc sống.</p><figure class="image"><img style="aspect-ratio:1242/1755;" src="https://www.vietcombank.com.vn/-/media/Project/VCB-Sites/VCB/Tin-tuc/2025/Vietcombank/Vietcombank_202503/Vietcombank_20250311/Thit-k-i-din.jpg?ts=20250319022003&amp;h=1755&amp;w=1242&amp;hash=F353EB0B689AB3A30894BA6DE996D3E9" alt="Thit-k-i-din.jpg (1242×1755)" width="1242" height="1755"></figure><p><strong>Tiền gửi rút gốc linh hoạt, lãi suất hấp dẫn</strong></p><p>Khách hàng được chủ động rút một phần gốc tiền gửi trong trường hợp cần thiết mà phần tiền gửi còn lại vẫn được hưởng lãi suất đang áp dụng ban đầu (cộng thêm 0,2%/năm so với lãi suất tiền gửi rút gốc linh hoạt thông thường).</p><p>- Loại tiền: VND</p><p>- Kỳ hạn gửi: Từ 1 - 24 tháng</p><p>- Số tiền gửi tối thiểu: 3 triệu đồng</p><p>- Kênh gửi: Điểm giao dịch Vietcombank trên toàn quốc</p><p>- Trả lãi: Cuối kỳ</p><p><strong>Đầu tư chứng chỉ quỹ VCBF với hệ số an toàn và sinh lời vượt trội</strong></p><p>Khách hàng có thể lựa chọn đầu tư chứng chỉ quỹ VCBF-FIF theo chương trình Hưu trí An vui được quản lý bởi đội ngũ chuyên gia tài chính hàng đầu của Công ty TNHH Quản lý Quỹ đầu tư chứng khoán Vietcombank (VCBF) nhằm tối ưu hóa dòng tiền và đảm bảo lợi nhuận ổn định, dài hạn:</p><p>- Đầu tư một lần - Sinh lời dài hạn</p><p>- Được định kỳ nhận tiền hàng tháng</p><p>- Tăng trưởng tài sản ổn định, giảm thiểu rủi ro</p><p>- Quản lý bởi chuyên gia tài chính hàng đầu của VCBF</p><p><strong>Trải nghiệm đặc quyền Khách hàng Ưu tiên</strong></p><p>Không chỉ mang đến các giải pháp tài chính vượt trội, chương trình “Vững tâm đổi” còn dành tặng đặc quyền theo chính sách Khách hàng Ưu tiên của Vietcombank dành cho cán bộ, công chức, viên chức, người lao động và lực lượng vũ trang trong thực hiện sắp xếp tổ chức bộ máy của hệ thống chính trị theo Nghị định 178/2024/NĐ-CP ngày 31/12/2024 của Chính phủ khi khách hàng đáp ứng tiêu chí của chương trình trong 6 tháng liên tục <i>(thay vì 12 tháng như thông thường).</i></p><p>Trở thành <strong>Khách hàng Ưu tiên</strong> của Vietcombank, khách hàng sẽ được tận hưởng những&nbsp;dịch vụ đẳng cấp:</p><p>- Ưu tiên phục vụ tại tất cả điểm giao dịch, giảm thiểu thời gian chờ đợi.</p><p>- Tổng đài hỗ trợ 24/7 riêng biệt.</p><p>- Trải nghiệm phòng chờ sân bay Vietcombank Priority hoàn toàn miễn phí, nâng tầm tiện ích trong mỗi chuyến đi.</p><p>- Ưu đãi đặc biệt về lãi suất, phí giao dịch và các dịch vụ tài chính khác.</p><p>Bên cạnh đó, chương trình còn dành tặng mỗi khách hàng 01 thẻ ghi nợ quốc tế phi vật lý do Vietcombank phát hành cùng nhiều ưu đãi hấp dẫn khác theo từng thời kỳ khi trở thành hội viên VCB Loyalty.</p><p>Chương trình áp dụng đến hết ngày 31/12/2025.</p><p>Để biết thêm thông tin chi tiết, khách hàng có thể liên hệ hotline Vietcombank 1900 545413 hoặc 1800 1565 (đối với khách hàng Ưu tiên) hoặc đến bất kỳ điểm giao dịch Vietcombank trên toàn quốc để được tư vấn cụ thể và phục vụ chu đáo.</p><p>Vietcombank hân hạnh được phục vụ Quý Khách hàng vì mục tiêu vững tâm đổi mới, đồng hành phát triển và ổn định cuộc sống trước một giai đoạn mới với nhiều thay đổi lớn.</p>', 1, CAST(N'2025-03-28T22:02:50.123' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (47, 62, N'Vietcombank thông báo ra mắt VCB CashUp Mobile dành cho khách hàng doanh nghiệp', N'<p><strong>Với mong muốn gia tăng trải nghiệm của khách hàng khi sử dụng VCB CashUp, Vietcombank chính thức ra mắt ứng dụng VCB CashUp Mobile dành cho khách hàng doanh nghiệp.</strong></p><figure class="image"><img style="aspect-ratio:900/900;" src="https://www.vietcombank.com.vn/-/media/Project/VCB-Sites/VCB/Tin-tuc/2025/Vietcombank/Vietcombank_202501/Vietcombank_20250101/1080x1080px-Social-Post-re.jpg?ts=20250107104257" width="900" height="900"></figure><p>Với VCB CashUp, mọi giao dịch tài chính của doanh nghiệp đều được thực hiện nhanh chóng, thuận tiện và an toàn tuyệt đối. Ứng dụng tích hợp nhiều tính năng ưu việt, giúp khách hàng quản lý tài chính một cách chuyên nghiệp:</p><p><strong>- Bảo mật:</strong></p><p><strong>+ Xác thực hai yếu tố:</strong>&nbsp;Đảm bảo phê duyệt giao dịch với hai lớp bảo mật khi đăng nhập và duyệt lệnh. Phương thức duyệt lệnh bằng Hard Token hoặc Smart OTP tích hợp ngay trên app.</p><p><strong>+ Đăng nhập bằng sinh trắc học:</strong>&nbsp;Tiết kiệm thời gian và tăng cường bảo mật với tính năng đăng nhập bằng vân tay hoặc khuôn mặt.</p><p><strong>- Trải nghiệm liền mạch:</strong></p><p><strong>+ Đồng bộ trên mọi thiết bị:</strong>&nbsp;Dễ dàng truy cập và quản lý tài khoản trên cả điện thoại di động và máy tính với cùng một tài khoản.</p><p><strong>+ Giao diện trực quan:</strong>&nbsp;Thiết kế đơn giản, dễ sử dụng, giúp bạn nhanh chóng làm quen và thực hiện các giao dịch.</p><p><strong>- Quản lý tài chính hiệu quả:</strong></p><p><strong>+ Duyệt lệnh nhanh chóng:</strong>&nbsp;Quản lý và phê duyệt các lệnh thanh toán một cách dễ dàng chỉ với vài thao tác đơn giản.</p><p><strong>+ Theo dõi số dư và lịch sử giao dịch:</strong>&nbsp;Luôn nắm rõ tình hình tài chính của doanh nghiệp mọi lúc mọi nơi.</p><p><strong>Vì sao VCB CashUp là lựa chọn hàng đầu cho các doanh nghiệp lớn?</strong></p><p><strong>- Tiết kiệm thời gian:</strong>&nbsp;Tăng tự động hóa, giảm thiểu thời gian thực hiện các giao dịch.</p><p><strong>- Tăng cường bảo mật:</strong>&nbsp;Bảo vệ doanh nghiệp khỏi các rủi ro an ninh mạng.</p><p><strong>- Nâng cao hiệu quả:</strong>&nbsp;Quản lý tài chính một cách chuyên nghiệp, giúp doanh nghiệp tối ưu hóa hoạt động.</p><p>VCB CashUp không chỉ là công cụ quản lý tài chính mà còn là đối tác chiến lược, giúp doanh nghiệp lớn vươn xa trong thời đại số.</p><p>Quý khách vui lòng liên hệ hotline 1900 54 54 13 hoặc Chi nhánh/Phòng Giao dịch Vietcombank gần nhất để được hỗ trợ.</p>', 0, CAST(N'2025-03-30T10:20:47.997' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (48, 61, N'Cập nhật quy định của Ngân hàng Nhà nước về giao dịch thẻ bằng phương thức điện tử từ ngày 01/01/2025', N'<figure class="image"><img style="aspect-ratio:5886/3311;" src="https://www.vietcombank.com.vn/-/media/Project/VCB-Sites/VCB/Tin-tuc/2024/Vietcombank/Vietcombank_202412/Vietcombank_20241211/20241211_anh-bai-viet.jpg?ts=20241211023444&amp;h=3311&amp;w=5886&amp;hash=EB0F7B2E44C151EC2D4710C44B8C13E7" alt="20241211_anh-bai-viet.jpg (5886×3311)" width="5886" height="3311"></figure><p>Theo công văn mới nhất số 9913/NHNN/TT ngày 03/12/2024, Ngân hàng Nhà nước đã hướng dẫn nội dung về giao dịch thẻ bằng phương thức điện tử như sau:&nbsp;<i>“Giao dịch thanh toán trực tuyến, rút tiền mặt tại máy giao dịch tự động được coi là giao dịch thẻ bằng phương tiện điện tử&nbsp;(không bao gồm việc sử dụng thẻ vật lý để rút tiền tại máy giao dịch tự động)&nbsp;và giao dịch tại thiết bị chấp nhận thẻ tại điểm bán không được coi là giao dịch bằng phương tiện điện tử.”</i></p><p><strong>Như vậy, từ ngày 01/01/2025, nếu chưa cập nhật thông tin sinh trắc học, khách hàng vẫn có thể sử dụng thẻ vật lý để rút tiền tại máy ATM và giao dịch tại máy POS. Ngoài ra, các giao dịch thẻ khác của khách hàng sẽ bị TẠM DỪNG bao gồm:</strong></p><ul><li><strong>Giao dịch thanh toán trực tuyến bằng thẻ.</strong></li><li><strong>Giao dịch rút tiền bằng mã QR tại máy ATM.</strong></li><li><strong>Các giao dịch thẻ bằng phương thức điện tử khác.</strong></li></ul><p>Vietcombank khuyến nghị Quý khách hàng hãy thực hiện cập nhật thông tin sinh trắc học sớm nhất để đảm bảo an toàn, bảo mật khi giao dịch ngân hàng.</p>', 0, CAST(N'2025-03-30T10:23:46.547' AS DateTime))
SET IDENTITY_INSERT [dbo].[News] OFF
GO
SET IDENTITY_INSERT [dbo].[RepaymentSchedule] ON 

INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (531, N'PENDING', CAST(N'2025-04-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (532, N'PENDING', CAST(N'2025-05-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (533, N'PENDING', CAST(N'2025-06-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (534, N'PENDING', CAST(N'2025-07-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (535, N'PENDING', CAST(N'2025-08-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (536, N'PENDING', CAST(N'2025-09-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (537, N'PENDING', CAST(N'2025-10-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (538, N'PENDING', CAST(N'2025-11-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (539, N'PENDING', CAST(N'2025-12-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (540, N'PENDING', CAST(N'2026-01-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (541, N'PENDING', CAST(N'2026-02-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (542, N'PENDING', CAST(N'2026-03-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (543, N'PENDING', CAST(N'2026-04-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (544, N'PENDING', CAST(N'2026-05-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (545, N'PENDING', CAST(N'2026-06-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (546, N'PENDING', CAST(N'2026-07-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (547, N'PENDING', CAST(N'2026-08-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (548, N'PENDING', CAST(N'2026-09-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (549, N'PENDING', CAST(N'2026-10-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (550, N'PENDING', CAST(N'2026-11-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (551, N'PENDING', CAST(N'2026-12-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (552, N'PENDING', CAST(N'2027-01-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (553, N'PENDING', CAST(N'2027-02-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (554, N'PENDING', CAST(N'2027-03-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (555, N'PENDING', CAST(N'2027-04-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (556, N'PENDING', CAST(N'2027-05-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (557, N'PENDING', CAST(N'2027-06-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (558, N'PENDING', CAST(N'2027-07-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (559, N'PENDING', CAST(N'2027-08-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (560, N'PENDING', CAST(N'2027-09-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (561, N'PENDING', CAST(N'2027-10-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (562, N'PENDING', CAST(N'2027-11-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (563, N'PENDING', CAST(N'2027-12-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (564, N'PENDING', CAST(N'2028-01-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (565, N'PENDING', CAST(N'2028-02-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (566, N'PENDING', CAST(N'2028-03-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (567, N'PENDING', CAST(N'2028-04-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (568, N'PENDING', CAST(N'2028-05-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (569, N'PENDING', CAST(N'2028-06-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (570, N'PENDING', CAST(N'2028-07-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (571, N'PENDING', CAST(N'2028-08-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (572, N'PENDING', CAST(N'2028-09-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (573, N'PENDING', CAST(N'2028-10-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (574, N'PENDING', CAST(N'2028-11-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (575, N'PENDING', CAST(N'2028-12-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (576, N'PENDING', CAST(N'2029-01-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (577, N'PENDING', CAST(N'2029-02-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (578, N'PENDING', CAST(N'2029-03-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (579, N'PENDING', CAST(N'2029-04-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (580, N'PENDING', CAST(N'2029-05-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (581, N'PENDING', CAST(N'2029-06-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (582, N'PENDING', CAST(N'2029-07-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (583, N'PENDING', CAST(N'2029-08-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (584, N'PENDING', CAST(N'2029-09-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (585, N'PENDING', CAST(N'2029-10-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (586, N'PENDING', CAST(N'2029-11-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (587, N'PENDING', CAST(N'2029-12-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (588, N'PENDING', CAST(N'2030-01-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (589, N'PENDING', CAST(N'2030-02-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (590, N'PENDING', CAST(N'2030-03-20' AS Date), 997873.56, 24)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (591, N'PENDING', CAST(N'2025-04-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (592, N'PENDING', CAST(N'2025-05-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (593, N'PENDING', CAST(N'2025-06-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (594, N'PENDING', CAST(N'2025-07-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (595, N'PENDING', CAST(N'2025-08-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (596, N'PENDING', CAST(N'2025-09-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (597, N'PENDING', CAST(N'2025-10-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (598, N'PENDING', CAST(N'2025-11-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (599, N'PENDING', CAST(N'2025-12-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (600, N'PENDING', CAST(N'2026-01-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (601, N'PENDING', CAST(N'2026-02-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (602, N'PENDING', CAST(N'2026-03-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (603, N'PENDING', CAST(N'2026-04-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (604, N'PENDING', CAST(N'2026-05-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (605, N'PENDING', CAST(N'2026-06-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (606, N'PENDING', CAST(N'2026-07-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (607, N'PENDING', CAST(N'2026-08-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (608, N'PENDING', CAST(N'2026-09-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (609, N'PENDING', CAST(N'2026-10-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (610, N'PENDING', CAST(N'2026-11-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (611, N'PENDING', CAST(N'2026-12-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (612, N'PENDING', CAST(N'2027-01-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (613, N'PENDING', CAST(N'2027-02-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (614, N'PENDING', CAST(N'2027-03-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (615, N'PENDING', CAST(N'2027-04-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (616, N'PENDING', CAST(N'2027-05-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (617, N'PENDING', CAST(N'2027-06-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (618, N'PENDING', CAST(N'2027-07-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (619, N'PENDING', CAST(N'2027-08-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (620, N'PENDING', CAST(N'2027-09-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (621, N'PENDING', CAST(N'2027-10-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (622, N'PENDING', CAST(N'2027-11-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (623, N'PENDING', CAST(N'2027-12-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (624, N'PENDING', CAST(N'2028-01-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (625, N'PENDING', CAST(N'2028-02-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (626, N'PENDING', CAST(N'2028-03-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (627, N'PENDING', CAST(N'2028-04-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (628, N'PENDING', CAST(N'2028-05-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (629, N'PENDING', CAST(N'2028-06-20' AS Date), 742333.58, 25)
GO
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (630, N'PENDING', CAST(N'2028-07-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (631, N'PENDING', CAST(N'2028-08-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (632, N'PENDING', CAST(N'2028-09-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (633, N'PENDING', CAST(N'2028-10-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (634, N'PENDING', CAST(N'2028-11-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (635, N'PENDING', CAST(N'2028-12-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (636, N'PENDING', CAST(N'2029-01-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (637, N'PENDING', CAST(N'2029-02-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (638, N'PENDING', CAST(N'2029-03-20' AS Date), 742333.58, 25)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (639, N'PENDING', CAST(N'2025-04-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (640, N'PENDING', CAST(N'2025-05-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (641, N'PENDING', CAST(N'2025-06-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (642, N'PENDING', CAST(N'2025-07-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (643, N'PENDING', CAST(N'2025-08-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (644, N'PENDING', CAST(N'2025-09-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (645, N'PENDING', CAST(N'2025-10-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (646, N'PENDING', CAST(N'2025-11-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (647, N'PENDING', CAST(N'2025-12-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (648, N'PENDING', CAST(N'2026-01-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (649, N'PENDING', CAST(N'2026-02-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (650, N'PENDING', CAST(N'2026-03-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (651, N'PENDING', CAST(N'2026-04-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (652, N'PENDING', CAST(N'2026-05-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (653, N'PENDING', CAST(N'2026-06-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (654, N'PENDING', CAST(N'2026-07-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (655, N'PENDING', CAST(N'2026-08-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (656, N'PENDING', CAST(N'2026-09-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (657, N'PENDING', CAST(N'2026-10-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (658, N'PENDING', CAST(N'2026-11-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (659, N'PENDING', CAST(N'2026-12-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (660, N'PENDING', CAST(N'2027-01-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (661, N'PENDING', CAST(N'2027-02-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (662, N'PENDING', CAST(N'2027-03-20' AS Date), 269997.56, 26)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (663, N'PENDING', CAST(N'2025-04-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (664, N'PENDING', CAST(N'2025-05-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (665, N'PENDING', CAST(N'2025-06-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (666, N'PENDING', CAST(N'2025-07-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (667, N'PENDING', CAST(N'2025-08-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (668, N'PENDING', CAST(N'2025-09-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (669, N'PENDING', CAST(N'2025-10-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (670, N'PENDING', CAST(N'2025-11-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (671, N'PENDING', CAST(N'2025-12-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (672, N'PENDING', CAST(N'2026-01-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (673, N'PENDING', CAST(N'2026-02-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (674, N'PENDING', CAST(N'2026-03-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (675, N'PENDING', CAST(N'2026-04-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (676, N'PENDING', CAST(N'2026-05-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (677, N'PENDING', CAST(N'2026-06-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (678, N'PENDING', CAST(N'2026-07-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (679, N'PENDING', CAST(N'2026-08-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (680, N'PENDING', CAST(N'2026-09-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (681, N'PENDING', CAST(N'2026-10-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (682, N'PENDING', CAST(N'2026-11-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (683, N'PENDING', CAST(N'2026-12-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (684, N'PENDING', CAST(N'2027-01-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (685, N'PENDING', CAST(N'2027-02-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (686, N'PENDING', CAST(N'2027-03-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (687, N'PENDING', CAST(N'2027-04-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (688, N'PENDING', CAST(N'2027-05-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (689, N'PENDING', CAST(N'2027-06-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (690, N'PENDING', CAST(N'2027-07-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (691, N'PENDING', CAST(N'2027-08-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (692, N'PENDING', CAST(N'2027-09-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (693, N'PENDING', CAST(N'2027-10-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (694, N'PENDING', CAST(N'2027-11-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (695, N'PENDING', CAST(N'2027-12-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (696, N'PENDING', CAST(N'2028-01-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (697, N'PENDING', CAST(N'2028-02-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (698, N'PENDING', CAST(N'2028-03-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (699, N'PENDING', CAST(N'2028-04-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (700, N'PENDING', CAST(N'2028-05-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (701, N'PENDING', CAST(N'2028-06-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (702, N'PENDING', CAST(N'2028-07-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (703, N'PENDING', CAST(N'2028-08-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (704, N'PENDING', CAST(N'2028-09-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (705, N'PENDING', CAST(N'2028-10-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (706, N'PENDING', CAST(N'2028-11-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (707, N'PENDING', CAST(N'2028-12-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (708, N'PENDING', CAST(N'2029-01-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (709, N'PENDING', CAST(N'2029-02-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (710, N'PENDING', CAST(N'2029-03-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (711, N'PENDING', CAST(N'2029-04-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (712, N'PENDING', CAST(N'2029-05-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (713, N'PENDING', CAST(N'2029-06-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (714, N'PENDING', CAST(N'2029-07-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (715, N'PENDING', CAST(N'2029-08-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (716, N'PENDING', CAST(N'2029-09-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (717, N'PENDING', CAST(N'2029-10-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (718, N'PENDING', CAST(N'2029-11-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (719, N'PENDING', CAST(N'2029-12-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (720, N'PENDING', CAST(N'2030-01-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (721, N'PENDING', CAST(N'2030-02-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (722, N'PENDING', CAST(N'2030-03-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (723, N'PENDING', CAST(N'2030-04-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (724, N'PENDING', CAST(N'2030-05-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (725, N'PENDING', CAST(N'2030-06-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (726, N'PENDING', CAST(N'2030-07-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (727, N'PENDING', CAST(N'2030-08-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (728, N'PENDING', CAST(N'2030-09-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (729, N'PENDING', CAST(N'2030-10-20' AS Date), 8476565.96, 27)
GO
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (730, N'PENDING', CAST(N'2030-11-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (731, N'PENDING', CAST(N'2030-12-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (732, N'PENDING', CAST(N'2031-01-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (733, N'PENDING', CAST(N'2031-02-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (734, N'PENDING', CAST(N'2031-03-20' AS Date), 8476565.96, 27)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (735, N'PENDING', CAST(N'2025-04-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (736, N'PENDING', CAST(N'2025-05-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (737, N'PENDING', CAST(N'2025-06-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (738, N'PENDING', CAST(N'2025-07-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (739, N'PENDING', CAST(N'2025-08-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (740, N'PENDING', CAST(N'2025-09-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (741, N'PENDING', CAST(N'2025-10-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (742, N'PENDING', CAST(N'2025-11-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (743, N'PENDING', CAST(N'2025-12-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (744, N'PENDING', CAST(N'2026-01-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (745, N'PENDING', CAST(N'2026-02-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (746, N'PENDING', CAST(N'2026-03-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (747, N'PENDING', CAST(N'2026-04-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (748, N'PENDING', CAST(N'2026-05-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (749, N'PENDING', CAST(N'2026-06-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (750, N'PENDING', CAST(N'2026-07-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (751, N'PENDING', CAST(N'2026-08-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (752, N'PENDING', CAST(N'2026-09-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (753, N'PENDING', CAST(N'2026-10-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (754, N'PENDING', CAST(N'2026-11-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (755, N'PENDING', CAST(N'2026-12-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (756, N'PENDING', CAST(N'2027-01-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (757, N'PENDING', CAST(N'2027-02-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (758, N'PENDING', CAST(N'2027-03-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (759, N'PENDING', CAST(N'2027-04-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (760, N'PENDING', CAST(N'2027-05-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (761, N'PENDING', CAST(N'2027-06-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (762, N'PENDING', CAST(N'2027-07-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (763, N'PENDING', CAST(N'2027-08-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (764, N'PENDING', CAST(N'2027-09-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (765, N'PENDING', CAST(N'2027-10-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (766, N'PENDING', CAST(N'2027-11-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (767, N'PENDING', CAST(N'2027-12-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (768, N'PENDING', CAST(N'2028-01-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (769, N'PENDING', CAST(N'2028-02-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (770, N'PENDING', CAST(N'2028-03-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (771, N'PENDING', CAST(N'2028-04-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (772, N'PENDING', CAST(N'2028-05-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (773, N'PENDING', CAST(N'2028-06-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (774, N'PENDING', CAST(N'2028-07-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (775, N'PENDING', CAST(N'2028-08-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (776, N'PENDING', CAST(N'2028-09-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (777, N'PENDING', CAST(N'2028-10-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (778, N'PENDING', CAST(N'2028-11-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (779, N'PENDING', CAST(N'2028-12-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (780, N'PENDING', CAST(N'2029-01-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (781, N'PENDING', CAST(N'2029-02-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (782, N'PENDING', CAST(N'2029-03-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (783, N'PENDING', CAST(N'2029-04-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (784, N'PENDING', CAST(N'2029-05-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (785, N'PENDING', CAST(N'2029-06-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (786, N'PENDING', CAST(N'2029-07-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (787, N'PENDING', CAST(N'2029-08-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (788, N'PENDING', CAST(N'2029-09-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (789, N'PENDING', CAST(N'2029-10-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (790, N'PENDING', CAST(N'2029-11-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (791, N'PENDING', CAST(N'2029-12-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (792, N'PENDING', CAST(N'2030-01-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (793, N'PENDING', CAST(N'2030-02-24' AS Date), 997873.56, 29)
INSERT [dbo].[RepaymentSchedule] ([schedule_id], [status], [due_date], [amount_due], [request_id]) VALUES (794, N'PENDING', CAST(N'2030-03-24' AS Date), 997873.56, 29)
SET IDENTITY_INSERT [dbo].[RepaymentSchedule] OFF
GO
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 1)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 2)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 3)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 4)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 5)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 6)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 7)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 8)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 9)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 10)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 11)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 12)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 13)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 14)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 15)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 16)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 17)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 18)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 19)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 20)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 21)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 30)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 31)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 32)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 33)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 34)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 35)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 36)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 37)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 38)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (1, 39)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 5)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 7)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 15)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 16)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 17)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 21)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 36)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 38)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 39)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 1)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 2)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 3)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 5)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 15)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 16)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 17)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 21)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 36)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 37)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 38)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 39)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 5)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 15)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 16)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 17)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 21)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 36)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 37)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 38)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 39)
GO
INSERT [dbo].[Roles] ([role_id], [role_name]) VALUES (1, N'Administrator')
INSERT [dbo].[Roles] ([role_id], [role_name]) VALUES (2, N'Staff')
INSERT [dbo].[Roles] ([role_id], [role_name]) VALUES (3, N'Head Of Staff')
INSERT [dbo].[Roles] ([role_id], [role_name]) VALUES (4, N'Accountant')
GO
SET IDENTITY_INSERT [dbo].[SavingPackage] ON 

INSERT [dbo].[SavingPackage] ([saving_package_id], [staff_id], [saving_package_name], [saving_package_description], [saving_package_interest_rate], [saving_package_term_months], [saving_package_min_deposit], [saving_package_max_deposit], [saving_package_status], [saving_package_created_at], [saving_package_updated_at], [saving_package_withdrawable], [saving_package_approval_status]) VALUES (4, 1, N'Gói tiết kiệm 3 tháng ưu đãi', N'Gói tiết kiệm với lãi suất hấp dẫn', CAST(5.00 AS Decimal(5, 2)), 3, CAST(30000000.00 AS Decimal(18, 2)), CAST(1000000000.00 AS Decimal(18, 2)), N'active', CAST(N'2025-10-03T00:00:00.000' AS DateTime), CAST(N'2025-03-10T00:46:59.523' AS DateTime), 1, N'approved')
INSERT [dbo].[SavingPackage] ([saving_package_id], [staff_id], [saving_package_name], [saving_package_description], [saving_package_interest_rate], [saving_package_term_months], [saving_package_min_deposit], [saving_package_max_deposit], [saving_package_status], [saving_package_created_at], [saving_package_updated_at], [saving_package_withdrawable], [saving_package_approval_status]) VALUES (5, 1, N'Gói tiết kiệm 6 tháng ưu đãi', N'Gói tiết kiệm với lãi suất hấp dẫn', CAST(5.30 AS Decimal(5, 2)), 6, CAST(50000000.00 AS Decimal(18, 2)), CAST(3000000000.00 AS Decimal(18, 2)), N'active', CAST(N'2025-03-10T00:47:57.417' AS DateTime), CAST(N'2025-03-10T00:47:57.417' AS DateTime), 1, N'approved')
INSERT [dbo].[SavingPackage] ([saving_package_id], [staff_id], [saving_package_name], [saving_package_description], [saving_package_interest_rate], [saving_package_term_months], [saving_package_min_deposit], [saving_package_max_deposit], [saving_package_status], [saving_package_created_at], [saving_package_updated_at], [saving_package_withdrawable], [saving_package_approval_status]) VALUES (6, 1, N'Gói tiết kiệm 9 tháng ưu đãi', N'Gói tiết kiệm với lãi suất hấp dẫn', CAST(5.80 AS Decimal(5, 2)), 9, CAST(50000000.00 AS Decimal(18, 2)), CAST(3000000000.00 AS Decimal(18, 2)), N'active', CAST(N'2025-03-10T00:48:25.220' AS DateTime), CAST(N'2025-03-10T00:48:25.220' AS DateTime), 1, N'approved')
INSERT [dbo].[SavingPackage] ([saving_package_id], [staff_id], [saving_package_name], [saving_package_description], [saving_package_interest_rate], [saving_package_term_months], [saving_package_min_deposit], [saving_package_max_deposit], [saving_package_status], [saving_package_created_at], [saving_package_updated_at], [saving_package_withdrawable], [saving_package_approval_status]) VALUES (7, 1, N'Gói tiết kiệm 12 tháng ưu đãi', N'Gói tiết kiệm với lãi suất hấp dẫn', CAST(6.10 AS Decimal(5, 2)), 12, CAST(50000000.00 AS Decimal(18, 2)), NULL, N'active', CAST(N'2025-03-10T00:48:42.780' AS DateTime), CAST(N'2025-03-10T00:48:42.780' AS DateTime), 1, N'approved')
INSERT [dbo].[SavingPackage] ([saving_package_id], [staff_id], [saving_package_name], [saving_package_description], [saving_package_interest_rate], [saving_package_term_months], [saving_package_min_deposit], [saving_package_max_deposit], [saving_package_status], [saving_package_created_at], [saving_package_updated_at], [saving_package_withdrawable], [saving_package_approval_status]) VALUES (8, 1, N'Gói tiết kiệm 24 tháng ưu đãi', N'Gói tiết kiệm với lãi suất hấp dẫn', CAST(6.25 AS Decimal(5, 2)), 24, CAST(50000000.00 AS Decimal(18, 2)), NULL, N'active', CAST(N'2025-03-10T00:48:57.267' AS DateTime), CAST(N'2025-03-10T00:48:57.267' AS DateTime), 1, N'approved')
INSERT [dbo].[SavingPackage] ([saving_package_id], [staff_id], [saving_package_name], [saving_package_description], [saving_package_interest_rate], [saving_package_term_months], [saving_package_min_deposit], [saving_package_max_deposit], [saving_package_status], [saving_package_created_at], [saving_package_updated_at], [saving_package_withdrawable], [saving_package_approval_status]) VALUES (10, 1, N'Gói tiết kiệm không giới hạn', N'Gói tiết kiệm với tính linh hoạt cao, có thể rút giữa chừng', CAST(0.20 AS Decimal(5, 2)), NULL, CAST(50000000.00 AS Decimal(18, 2)), NULL, N'active', CAST(N'2025-03-10T01:02:45.140' AS DateTime), CAST(N'2025-03-10T01:02:45.140' AS DateTime), 0, N'approved')
SET IDENTITY_INSERT [dbo].[SavingPackage] OFF
GO
SET IDENTITY_INSERT [dbo].[Staff] ON 

INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (1, 2, N'Nguyen Van Giang', N'giangnv', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 1, N'tqtolympia@gmail.com', CAST(N'2025-02-24' AS Date), 1, N'0123456789', N'042204001158', N'123 Updated Street', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (61, 1, N'Role Nhân Viên', N'rolenhanvien', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 1, N'tqtolympia@gmail.com', CAST(N'2025-03-08' AS Date), 1, N'0123654789', N'011546464640', N'Vietnam', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (62, 5, N'Role Trưởng Phòng', N'roletruongphong', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 1, N'tqtolympia@gmail.com', CAST(N'2025-03-08' AS Date), 1, N'0987654330', N'012345678912', N'Vietnam', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (63, 3, N'Role Kế Toán', N'roleketoan', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 1, N'tqtolympia@gmail.com', CAST(N'2025-03-07' AS Date), 1, N'0987654329', N'012345678900', N'Vietnam', NULL)
SET IDENTITY_INSERT [dbo].[Staff] OFF
GO
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (1, 1)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (NULL, 2)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (NULL, 3)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (NULL, 4)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (NULL, 1)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (61, 2)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (62, 3)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (63, 4)
GO
SET IDENTITY_INSERT [dbo].[Transaction] ON 

INSERT [dbo].[Transaction] ([transaction_id], [schedule_id], [request_id], [amount], [transaction_date], [type], [savings_id], [customer_id], [staff_id]) VALUES (33, NULL, 24, 51000000.0000, CAST(N'2025-03-20' AS Date), N'Disbursement', NULL, 69, 1)
INSERT [dbo].[Transaction] ([transaction_id], [schedule_id], [request_id], [amount], [transaction_date], [type], [savings_id], [customer_id], [staff_id]) VALUES (34, NULL, 25, 31000000.0000, CAST(N'2025-03-20' AS Date), N'Disbursement', NULL, 69, 1)
INSERT [dbo].[Transaction] ([transaction_id], [schedule_id], [request_id], [amount], [transaction_date], [type], [savings_id], [customer_id], [staff_id]) VALUES (35, NULL, 26, 6000000.0000, CAST(N'2025-03-20' AS Date), N'Disbursement', NULL, 69, 1)
INSERT [dbo].[Transaction] ([transaction_id], [schedule_id], [request_id], [amount], [transaction_date], [type], [savings_id], [customer_id], [staff_id]) VALUES (36, NULL, 27, 500000000.0000, CAST(N'2025-03-20' AS Date), N'Disbursement', NULL, 69, 1)
INSERT [dbo].[Transaction] ([transaction_id], [schedule_id], [request_id], [amount], [transaction_date], [type], [savings_id], [customer_id], [staff_id]) VALUES (37, NULL, 29, 51000000.0000, CAST(N'2025-03-24' AS Date), N'Disbursement', NULL, 69, 1)
SET IDENTITY_INSERT [dbo].[Transaction] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__CreditCa__1E6E0AF445DE42EC]    Script Date: 3/30/2025 10:25:01 AM ******/
ALTER TABLE [dbo].[CreditCards] ADD UNIQUE NONCLUSTERED 
(
	[card_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CreditCards] ADD  DEFAULT ('Active') FOR [status]
GO
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DF__Customer__active__5EBF139D]  DEFAULT ((0)) FOR [active]
GO
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DF__Customer__balanc__5FB337D6]  DEFAULT ((0)) FOR [balance]
GO
ALTER TABLE [dbo].[Messages] ADD  DEFAULT ('sent') FOR [status]
GO
ALTER TABLE [dbo].[Messages] ADD  DEFAULT (getdate()) FOR [timestamp]
GO
ALTER TABLE [dbo].[Staff] ADD  DEFAULT ((0)) FOR [active]
GO
ALTER TABLE [dbo].[CreditCards]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customer] ([customer_id])
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Active] FOREIGN KEY([active])
REFERENCES [dbo].[Active] ([active])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Active]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Gender] FOREIGN KEY([gender])
REFERENCES [dbo].[Gender] ([gender])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Gender]
GO
ALTER TABLE [dbo].[CustomerAssets]  WITH CHECK ADD  CONSTRAINT [FK_CustomerAssets_Customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customer] ([customer_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerAssets] CHECK CONSTRAINT [FK_CustomerAssets_Customer]
GO
ALTER TABLE [dbo].[CustomerAssets]  WITH CHECK ADD  CONSTRAINT [FK_CustomerAssets_Staff] FOREIGN KEY([staff_id])
REFERENCES [dbo].[Staff] ([staff_id])
GO
ALTER TABLE [dbo].[CustomerAssets] CHECK CONSTRAINT [FK_CustomerAssets_Staff]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [FK_Feedback_Customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customer] ([customer_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FK_Feedback_Customer]
GO
ALTER TABLE [dbo].[LoanPackages]  WITH CHECK ADD  CONSTRAINT [FK_LoanPackages_Staff1] FOREIGN KEY([staff_id])
REFERENCES [dbo].[Staff] ([staff_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[LoanPackages] CHECK CONSTRAINT [FK_LoanPackages_Staff1]
GO
ALTER TABLE [dbo].[LoanRequests]  WITH CHECK ADD  CONSTRAINT [FK_LoanRequests_Customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customer] ([customer_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LoanRequests] CHECK CONSTRAINT [FK_LoanRequests_Customer]
GO
ALTER TABLE [dbo].[LoanRequests]  WITH CHECK ADD  CONSTRAINT [FK_LoanRequests_CustomerAssets] FOREIGN KEY([asset_id])
REFERENCES [dbo].[CustomerAssets] ([asset_id])
GO
ALTER TABLE [dbo].[LoanRequests] CHECK CONSTRAINT [FK_LoanRequests_CustomerAssets]
GO
ALTER TABLE [dbo].[LoanRequests]  WITH CHECK ADD  CONSTRAINT [FK_LoanRequests_LoanPackages] FOREIGN KEY([package_id])
REFERENCES [dbo].[LoanPackages] ([package_id])
GO
ALTER TABLE [dbo].[LoanRequests] CHECK CONSTRAINT [FK_LoanRequests_LoanPackages]
GO
ALTER TABLE [dbo].[LoanRequests]  WITH CHECK ADD  CONSTRAINT [FK_LoanRequests_Staff] FOREIGN KEY([staff_id])
REFERENCES [dbo].[Staff] ([staff_id])
GO
ALTER TABLE [dbo].[LoanRequests] CHECK CONSTRAINT [FK_LoanRequests_Staff]
GO
ALTER TABLE [dbo].[News]  WITH CHECK ADD  CONSTRAINT [FK_News_Staff] FOREIGN KEY([staff_id])
REFERENCES [dbo].[Staff] ([staff_id])
GO
ALTER TABLE [dbo].[News] CHECK CONSTRAINT [FK_News_Staff]
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customer] ([customer_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_Customer]
GO
ALTER TABLE [dbo].[RepaymentSchedule]  WITH CHECK ADD  CONSTRAINT [FK_RepaymentSchedule_LoanRequests] FOREIGN KEY([request_id])
REFERENCES [dbo].[LoanRequests] ([request_id])
GO
ALTER TABLE [dbo].[RepaymentSchedule] CHECK CONSTRAINT [FK_RepaymentSchedule_LoanRequests]
GO
ALTER TABLE [dbo].[RoleFeatures]  WITH CHECK ADD  CONSTRAINT [FK_RoleFeatures_Features1] FOREIGN KEY([feature_id])
REFERENCES [dbo].[Features] ([feature_id])
GO
ALTER TABLE [dbo].[RoleFeatures] CHECK CONSTRAINT [FK_RoleFeatures_Features1]
GO
ALTER TABLE [dbo].[RoleFeatures]  WITH CHECK ADD  CONSTRAINT [FK_RoleFeatures_Roles1] FOREIGN KEY([role_id])
REFERENCES [dbo].[Roles] ([role_id])
GO
ALTER TABLE [dbo].[RoleFeatures] CHECK CONSTRAINT [FK_RoleFeatures_Roles1]
GO
ALTER TABLE [dbo].[Saving]  WITH CHECK ADD  CONSTRAINT [FK_Saving_Customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customer] ([customer_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Saving] CHECK CONSTRAINT [FK_Saving_Customer]
GO
ALTER TABLE [dbo].[Saving]  WITH CHECK ADD  CONSTRAINT [FK_Saving_SavingRequest] FOREIGN KEY([saving_request_id])
REFERENCES [dbo].[SavingRequest] ([saving_request_id])
GO
ALTER TABLE [dbo].[Saving] CHECK CONSTRAINT [FK_Saving_SavingRequest]
GO
ALTER TABLE [dbo].[SavingFeedback]  WITH CHECK ADD FOREIGN KEY([savings_id])
REFERENCES [dbo].[Saving] ([savings_id])
GO
ALTER TABLE [dbo].[SavingPackage]  WITH CHECK ADD  CONSTRAINT [FK_SavingPackage_Staff] FOREIGN KEY([staff_id])
REFERENCES [dbo].[Staff] ([staff_id])
GO
ALTER TABLE [dbo].[SavingPackage] CHECK CONSTRAINT [FK_SavingPackage_Staff]
GO
ALTER TABLE [dbo].[SavingRequest]  WITH CHECK ADD  CONSTRAINT [FK_SavingRequest_Customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customer] ([customer_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SavingRequest] CHECK CONSTRAINT [FK_SavingRequest_Customer]
GO
ALTER TABLE [dbo].[SavingRequest]  WITH CHECK ADD  CONSTRAINT [FK_SavingRequest_SavingPackage] FOREIGN KEY([saving_package_id])
REFERENCES [dbo].[SavingPackage] ([saving_package_id])
GO
ALTER TABLE [dbo].[SavingRequest] CHECK CONSTRAINT [FK_SavingRequest_SavingPackage]
GO
ALTER TABLE [dbo].[SavingRequest]  WITH CHECK ADD  CONSTRAINT [FK_SavingRequest_Staff] FOREIGN KEY([staff_id])
REFERENCES [dbo].[Staff] ([staff_id])
GO
ALTER TABLE [dbo].[SavingRequest] CHECK CONSTRAINT [FK_SavingRequest_Staff]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_Staff_Department] FOREIGN KEY([department_id])
REFERENCES [dbo].[Department] ([department_id])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_Staff_Department]
GO
ALTER TABLE [dbo].[StaffRoles]  WITH CHECK ADD  CONSTRAINT [FK_StaffRoles_Roles] FOREIGN KEY([role_id])
REFERENCES [dbo].[Roles] ([role_id])
GO
ALTER TABLE [dbo].[StaffRoles] CHECK CONSTRAINT [FK_StaffRoles_Roles]
GO
ALTER TABLE [dbo].[StaffRoles]  WITH CHECK ADD  CONSTRAINT [FK_StaffRoles_Staff1] FOREIGN KEY([staff_id])
REFERENCES [dbo].[Staff] ([staff_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[StaffRoles] CHECK CONSTRAINT [FK_StaffRoles_Staff1]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_Customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customer] ([customer_id])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_Customer]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_LoanRequests] FOREIGN KEY([request_id])
REFERENCES [dbo].[LoanRequests] ([request_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_LoanRequests]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_RepaymentSchedule] FOREIGN KEY([schedule_id])
REFERENCES [dbo].[RepaymentSchedule] ([schedule_id])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_RepaymentSchedule]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_Saving] FOREIGN KEY([savings_id])
REFERENCES [dbo].[Saving] ([savings_id])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_Saving]
GO
ALTER TABLE [dbo].[CreditCards]  WITH CHECK ADD CHECK  (([status]='Expired' OR [status]='Blocked' OR [status]='Active'))
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [CHK_Feedback_Rating] CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [CHK_Feedback_Rating]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD CHECK  (([sender_type]='staff' OR [sender_type]='customer'))
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD CHECK  (([status]='read' OR [status]='delivered' OR [status]='sent'))
GO
ALTER TABLE [dbo].[SavingPackage]  WITH CHECK ADD CHECK  (([saving_package_status]='inactive' OR [saving_package_status]='active'))
GO
ALTER TABLE [dbo].[SavingPackage]  WITH CHECK ADD CHECK  (([saving_package_approval_status]='approved' OR [saving_package_approval_status]='pending'))
GO
ALTER TABLE [dbo].[SavingRequest]  WITH CHECK ADD CHECK  (([money_approval_status]='received' OR [money_approval_status]='pending'))
GO
ALTER TABLE [dbo].[SavingRequest]  WITH CHECK ADD CHECK  (([saving_approval_status]='rejected' OR [saving_approval_status]='approved' OR [saving_approval_status]='pending'))
GO
