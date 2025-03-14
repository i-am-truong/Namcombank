USE [Namcombank]
GO
/****** Object:  Table [dbo].[Active]    Script Date: 3/13/2025 11:04:32 AM ******/
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
/****** Object:  Table [dbo].[Customer]    Script Date: 3/13/2025 11:04:32 AM ******/
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
	[balance] [float] NULL,
	[citizen_identification_card] [nvarchar](15) NULL,
	[address] [nvarchar](200) NOT NULL,
	[avatar] [nvarchar](255) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerAssets]    Script Date: 3/13/2025 11:04:32 AM ******/
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
/****** Object:  Table [dbo].[Department]    Script Date: 3/13/2025 11:04:32 AM ******/
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
/****** Object:  Table [dbo].[Features]    Script Date: 3/13/2025 11:04:32 AM ******/
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
/****** Object:  Table [dbo].[Feedback]    Script Date: 3/13/2025 11:04:32 AM ******/
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
/****** Object:  Table [dbo].[Gender]    Script Date: 3/13/2025 11:04:32 AM ******/
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
/****** Object:  Table [dbo].[LoanPackages]    Script Date: 3/13/2025 11:04:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoanPackages](
	[package_id] [int] IDENTITY(1,1) NOT NULL,
	[staff_id] [int] NOT NULL,
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
/****** Object:  Table [dbo].[LoanRequests]    Script Date: 3/13/2025 11:04:32 AM ******/
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
/****** Object:  Table [dbo].[Loans]    Script Date: 3/13/2025 11:04:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Loans](
	[loan_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[package_id] [int] NOT NULL,
	[amount] [nchar](10) NOT NULL,
	[start_date] [nchar](10) NOT NULL,
	[end_date] [nchar](10) NOT NULL,
	[status] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Loans] PRIMARY KEY CLUSTERED 
(
	[loan_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[News]    Script Date: 3/13/2025 11:04:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[News](
	[news_id] [int] IDENTITY(1,1) NOT NULL,
	[staff_id] [int] NOT NULL,
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
/****** Object:  Table [dbo].[Notification]    Script Date: 3/13/2025 11:04:32 AM ******/
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
/****** Object:  Table [dbo].[RepaymentSchedule]    Script Date: 3/13/2025 11:04:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepaymentSchedule](
	[schedule_id] [int] IDENTITY(1,1) NOT NULL,
	[loan_id] [int] NOT NULL,
	[status] [nvarchar](50) NOT NULL,
	[due_date] [date] NOT NULL,
	[amount_due] [float] NOT NULL,
	[request_id] [int] NOT NULL,
 CONSTRAINT [PK_RepaymentSchedule] PRIMARY KEY CLUSTERED 
(
	[schedule_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleFeatures]    Script Date: 3/13/2025 11:04:32 AM ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 3/13/2025 11:04:32 AM ******/
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
/****** Object:  Table [dbo].[Saving]    Script Date: 3/13/2025 11:04:32 AM ******/
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
/****** Object:  Table [dbo].[SavingFeedback]    Script Date: 3/13/2025 11:04:32 AM ******/
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
/****** Object:  Table [dbo].[SavingPackage]    Script Date: 3/13/2025 11:04:32 AM ******/
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
/****** Object:  Table [dbo].[SavingRequest]    Script Date: 3/13/2025 11:04:32 AM ******/
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
/****** Object:  Table [dbo].[Staff]    Script Date: 3/13/2025 11:04:32 AM ******/
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
/****** Object:  Table [dbo].[StaffRoles]    Script Date: 3/13/2025 11:04:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StaffRoles](
	[staff_id] [int] NULL,
	[role_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 3/13/2025 11:04:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[transaction_id] [int] IDENTITY(1,1) NOT NULL,
	[schedule_id] [int] NULL,
	[request_id] [int] NULL,
	[amount] [float] NOT NULL,
	[transaction_date] [date] NOT NULL,
	[type] [nvarchar](50) NULL,
	[savings_id] [int] NULL,
	[customer_id] [int] NOT NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[transaction_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Active] ([active], [activename]) VALUES (0, N'Closed')
INSERT [dbo].[Active] ([active], [activename]) VALUES (1, N'Opening')
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (1, N'Nguyen Van An', N'annv', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 1, N'annv@gmail.com', CAST(N'1990-01-01' AS Date), 1, N'0912345600', 1000000, N'052416398705', N'123 Street, Hanoi', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (2, N'Tran Thi Bao', N'baott', N'123', 1, N'baott@gmail.com', CAST(N'1995-05-15' AS Date), 0, N'0912345679', 2000000, N'025987654321', N'456 Street, HCM', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (3, N'Le Van Dat', N'datlv', N'123', 0, N'datlv@gmail.com', CAST(N'1985-07-20' AS Date), 1, N'0912345680', 1500000, N'071135792468', N'789 Street, Da Nang', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (13, N'Truong Quoc Truong', N'truongtq', N'sAV5PWv4CBikIZOd7DNQBp8Q+Lo=', 1, N'tqtolympia@gmail.com', CAST(N'2005-02-04' AS Date), 1, N'0923456781', 0, N'012345678901', N'Vietnam', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (20, N'Doan Vinh Hung', N'kakaka', N'123456', 1, N'kakaka@gmail.com', CAST(N'1970-01-01' AS Date), 1, N'0875469321', 0, N'012345678910', N'Ha Tinh, Vietnam', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (27, N'Nguyen Thai Duong', N'duongnt', N'2imtLxYBBNNKJcKcczkw6QqsbZs=', 1, N'duongnt@gmail.com', CAST(N'1970-01-01' AS Date), 1, N'0956784123', 0, N'012345678910', N'Hanoi, Vietnam', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (53, N'Nguyen Hai Nam', N'nguyenhainam', N'2imtLxYBBNNKJcKcczkw6QqsbZs=', 1, N'nguyenhainam@example.com', CAST(N'2025-02-23' AS Date), 1, N'0987654321', 0, N'012345678905', N'Vietnam', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (54, N'Pham Cong Tra', N'phamcongtra', N'2imtLxYBBNNKJcKcczkw6QqsbZs=', 1, N'phamcongtra@example.com', CAST(N'2025-02-23' AS Date), 1, N'0976543210', 0, N'012345678906', N'Hochiminh', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (55, N'Nguyen Thi Kieu Anh', N'nguyenthikieuanh', N'2imtLxYBBNNKJcKcczkw6QqsbZs=', 1, N'nguyenthikieuanh@example.com', CAST(N'2025-02-23' AS Date), 0, N'0965432109', 0, N'012345678907', N'Da Nang', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (59, N'Tran Duc Anh', N'anhtd', N'c00dVVAMcTGpAQWd91RHsyKlR3Q=', 0, N'swp391@gmail.com', CAST(N'2025-02-23' AS Date), 1, N'0923456788', 0, N'057486912475', N'Vietnam', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (68, N'Đinh Xuân Dương', N'duongdx', N'2imtLxYBBNNKJcKcczkw6QqsbZs=', 1, N'duongdx@gmail.com', CAST(N'2025-02-27' AS Date), 1, N'0485632159', 0, N'012548796352', N'Hà Nội, Việt Nam', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (69, N'Trương Quốc Trường', N'truongtqt', N'2imtLxYBBNNKJcKcczkw6QqsbZs=', 1, N'truongtqt@gmail.com', CAST(N'2025-02-27' AS Date), 1, N'0959647891', 0, N'098651435987', N'Hà Nội, Việt Nam', N'assets/img/profile/avata-admin.jpg')
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (70, N'Nguyen Hoang Son', N'nguyenhoangson', N'FlmIXAy56ykWRvWlYZJ0niyfyQc=', 1, N'nguyenhoangson@gmail.com', CAST(N'1970-01-01' AS Date), 1, N'0987654328', 0, N'012345678910', N'Hà Nội, Việt Nam', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (72, N'Nguyễn Hoàng Sơn', N'nguyenhoangson', N'2imtLxYBBNNKJcKcczkw6QqsbZs=', 1, N'nguyenhoangson@example.com', CAST(N'2025-02-27' AS Date), 1, N'0959784632', 0, N'078459612879', N'Hà Nội, Việt Nam', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (73, N'Trần Đức Anh', N'tranducanh', N'6ZTwz+921YZYOO/SCQDhgBfqCy8=', 1, N'tranducanh@gmail.com', CAST(N'1970-01-01' AS Date), 1, N'0987654327', 0, N'012345678910', N'Hà Nội, Việt Nam', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (74, N'Trương Quốc Trường', N'truongalpo', N'bljkPwHSgzxQ34KF1YvpX5vWP/o=', 1, N'truongalpo@gmail.com', CAST(N'1970-01-01' AS Date), 1, N'0987654326', 0, N'012345678910', N'Hà Nội, Việt Nam', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (77, N'Đỗ Hoàng Anh', N'dohoanganh', N'DUTdxfJalE5ni72ZCypuUaHevak=', 1, N'dohoanganh@gmail.com', CAST(N'1970-01-01' AS Date), 1, N'0987654310', 0, N'012345678910', N'Hà Nội, Việt Nam', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (78, N'Mai Ngọc linh', N'linh123', N'Rnf3eW7e3fs+MzCXqhdp0fMQXy8=', 1, N'linhfeloi0123456789@gmail.com', CAST(N'2004-09-09' AS Date), 1, N'0962399063', 300000000, N'01298390124', N'vietnam', NULL)
INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (82, N'Trương Quốc Trường', N'truongtqhe186765', N'LQEgXhYZwRhBsLmetONrKhO6yeA=', 0, N'truongtqhe186765@gmail.com', CAST(N'1970-01-01' AS Date), 1, N'0987456100', 0, N'012345678910', N'Hà Nội, Việt Nam', NULL)
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[CustomerAssets] ON 

INSERT [dbo].[CustomerAssets] ([asset_id], [customer_id], [staff_id], [asset_name], [asset_type], [asset_value], [created_date], [status], [description], [approved_by], [approved_date], [note]) VALUES (1, 1, 1, N'abc', N'REAL_ESTATE', 1000000000, CAST(N'2025-03-06T23:40:23.167' AS DateTime), N'APPROVED', N'asdasdsa', N'1         ', CAST(N'2025-03-06T23:40:34.063' AS DateTime), N'dep qua')
INSERT [dbo].[CustomerAssets] ([asset_id], [customer_id], [staff_id], [asset_name], [asset_type], [asset_value], [created_date], [status], [description], [approved_by], [approved_date], [note]) VALUES (3, 13, 1, N'Căn hộ chung cư', N'REAL_ESTATE', 123, CAST(N'2025-03-06T23:42:56.970' AS DateTime), N'REJECTED', N'sdsad', N'1         ', CAST(N'2025-03-06T23:43:08.280' AS DateTime), N'sdsad')
INSERT [dbo].[CustomerAssets] ([asset_id], [customer_id], [staff_id], [asset_name], [asset_type], [asset_value], [created_date], [status], [description], [approved_by], [approved_date], [note]) VALUES (4, 2, 1, N'Căn hộ chung cư', N'INCOME', 1000000, CAST(N'2025-03-07T00:02:51.980' AS DateTime), N'PENDING', N'abc', NULL, NULL, NULL)
INSERT [dbo].[CustomerAssets] ([asset_id], [customer_id], [staff_id], [asset_name], [asset_type], [asset_value], [created_date], [status], [description], [approved_by], [approved_date], [note]) VALUES (5, 13, 1, N'abcd', N'REAL_ESTATE', 12345566789, CAST(N'2025-03-07T00:04:16.577' AS DateTime), N'PENDING', N'fgfdgfd', NULL, NULL, NULL)
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
GO
INSERT [dbo].[Gender] ([gender], [gendername]) VALUES (0, N'Female')
INSERT [dbo].[Gender] ([gender], [gendername]) VALUES (1, N'Male')
GO
SET IDENTITY_INSERT [dbo].[LoanPackages] ON 

INSERT [dbo].[LoanPackages] ([package_id], [staff_id], [package_name], [loan_type], [description], [interest_rate], [max_amount], [min_amount], [loan_term], [created_date]) VALUES (1, 1, N'Quick Unsecured Loan Package', N'unsecured ', N'No collateral required, quick processing.', CAST(8.50 AS Decimal(5, 2)), CAST(50000000.00 AS Decimal(18, 2)), CAST(1000000.00 AS Decimal(18, 2)), 12, CAST(N'2025-01-01' AS Date))
INSERT [dbo].[LoanPackages] ([package_id], [staff_id], [package_name], [loan_type], [description], [interest_rate], [max_amount], [min_amount], [loan_term], [created_date]) VALUES (2, 1, N'Discounted Unsecured Loan Package', N'unsecured ', N'Special interest rates for individual customers.', CAST(7.50 AS Decimal(5, 2)), CAST(100000000.00 AS Decimal(18, 2)), CAST(5000000.00 AS Decimal(18, 2)), 24, CAST(N'2025-01-10' AS Date))
INSERT [dbo].[LoanPackages] ([package_id], [staff_id], [package_name], [loan_type], [description], [interest_rate], [max_amount], [min_amount], [loan_term], [created_date]) VALUES (3, 2, N'Unsecured Business Loan Package', N'unsecured ', N'Suitable for small businesses.', CAST(9.00 AS Decimal(5, 2)), CAST(200000000.00 AS Decimal(18, 2)), CAST(20000000.00 AS Decimal(18, 2)), 36, CAST(N'2025-01-20' AS Date))
INSERT [dbo].[LoanPackages] ([package_id], [staff_id], [package_name], [loan_type], [description], [interest_rate], [max_amount], [min_amount], [loan_term], [created_date]) VALUES (4, 2, N'Real Estate Secured Loan Package', N'secured   ', N'Loans secured by land use rights or real estate.', CAST(6.50 AS Decimal(5, 2)), CAST(1000000000.00 AS Decimal(18, 2)), CAST(50000000.00 AS Decimal(18, 2)), 60, CAST(N'2025-01-15' AS Date))
INSERT [dbo].[LoanPackages] ([package_id], [staff_id], [package_name], [loan_type], [description], [interest_rate], [max_amount], [min_amount], [loan_term], [created_date]) VALUES (5, 3, N'Car Secured Loan Package', N'secured   ', N'Loans secured by car documents.', CAST(7.00 AS Decimal(5, 2)), CAST(500000000.00 AS Decimal(18, 2)), CAST(30000000.00 AS Decimal(18, 2)), 48, CAST(N'2025-01-25' AS Date))
INSERT [dbo].[LoanPackages] ([package_id], [staff_id], [package_name], [loan_type], [description], [interest_rate], [max_amount], [min_amount], [loan_term], [created_date]) VALUES (6, 3, N'Other Assets Secured Loan Package', N'secured   ', N'For high-value assets.', CAST(6.80 AS Decimal(5, 2)), CAST(2000000000.00 AS Decimal(18, 2)), CAST(100000000.00 AS Decimal(18, 2)), 72, CAST(N'2025-02-01' AS Date))
SET IDENTITY_INSERT [dbo].[LoanPackages] OFF
GO
SET IDENTITY_INSERT [dbo].[LoanRequests] ON 

INSERT [dbo].[LoanRequests] ([request_id], [staff_id], [package_id], [customer_id], [request_date], [amount], [status], [start_date], [end_date], [approval_date], [approved_by], [approved_note], [asset_id]) VALUES (6, NULL, 1, 1, CAST(N'2025-03-12T00:00:00.000' AS DateTime), 2000000, N'Rejected', NULL, NULL, CAST(N'2025-03-12T22:13:25.940' AS DateTime), N'1', N'no
', NULL)
INSERT [dbo].[LoanRequests] ([request_id], [staff_id], [package_id], [customer_id], [request_date], [amount], [status], [start_date], [end_date], [approval_date], [approved_by], [approved_note], [asset_id]) VALUES (7, NULL, 5, 1, CAST(N'2025-03-12T00:00:00.000' AS DateTime), 190000000, N'Rejected', NULL, NULL, CAST(N'2025-03-12T22:15:30.550' AS DateTime), N'1', N'abc', NULL)
INSERT [dbo].[LoanRequests] ([request_id], [staff_id], [package_id], [customer_id], [request_date], [amount], [status], [start_date], [end_date], [approval_date], [approved_by], [approved_note], [asset_id]) VALUES (9, NULL, 4, 1, CAST(N'2025-03-12T00:00:00.000' AS DateTime), 70000000, N'Pending', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[LoanRequests] ([request_id], [staff_id], [package_id], [customer_id], [request_date], [amount], [status], [start_date], [end_date], [approval_date], [approved_by], [approved_note], [asset_id]) VALUES (10, NULL, 6, 1, CAST(N'2025-03-13T00:00:00.000' AS DateTime), 120000000, N'Pending', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[LoanRequests] ([request_id], [staff_id], [package_id], [customer_id], [request_date], [amount], [status], [start_date], [end_date], [approval_date], [approved_by], [approved_note], [asset_id]) VALUES (11, NULL, 1, 69, CAST(N'2025-03-13T00:00:00.000' AS DateTime), 50000000, N'Pending', NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[LoanRequests] OFF
GO
SET IDENTITY_INSERT [dbo].[News] ON 

INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (1, 1, N'Bí kíp phối đồ tập gym nam cực chất lại thoải mái ', N'<h3><strong>1. Chất liệu</strong></h3><p><strong>Yếu tố quan trọng và cơ bản nhất ảnh hưởng đến chất lượng của trang phục và hiệu quả của việc luyện tập là chất liệu. Khi bạn đầu tư một cách hợp lý vào quần áo tập gym, bạn sẽ tận hưởng sự thoải mái và dễ chịu trong quá trình luyện tập.</strong></p><p><strong>Khi mua </strong><a href="https://www.coolmate.me/post/7-dia-chi-mua-quan-ao-tap-gym-nam-chat-luong"><strong>quần áo tập gym cho nam</strong></a><strong> giới, hãy chú ý xem liệu chất liệu vải có khả năng thấm hút mồ hôi tốt và thoáng khí hay không. Khi tập luyện, cơ thể sẽ sản sinh mồ hôi và cần một luồng khí tươi để lưu thông tốt hơn.</strong></p><p><strong>Dù việc tập thể dục có ích cho sức khỏe, nhưng nếu mặc những bộ quần áo không cho phép mồ hôi thoát ra, cơ thể sẽ bị ướt và dễ bị cảm lạnh.</strong></p><p><strong>Hiện nay, có ba chất liệu phổ biến được sử dụng trong sản xuất quần áo tập gym: cotton, polyester và spandex. Hãy cùng xem những đặc điểm của từng loại vải này:</strong><br>&nbsp;</p><ul><li><strong>Cotton: Chất liệu này có khả năng thấm hút tuyệt vời và giới hạn mùi cơ thể. Tuy nhiên, trong những buổi tập với cường độ cao như tập gym, bạn có thể cảm thấy cơ thể ẩm như vừa tắm.</strong></li><li><strong>Polyester: Chất liệu này có độ bền cao, ít nhăn nhúm sau khi giặt, nhẹ và rất thoáng khí. Đặc biệt, vải polyester còn có khả năng chống tia cực tím (UV) ngay cả khi bị ướt.</strong></li><li><strong>Spandex: Chất liệu này có tính co giãn xuất sắc, có thể kéo giãn nhiều lần mà vẫn giữ được hình dạng ban đầu. Ngoài ra, vải spandex còn mềm mại, không gây tĩnh điện và không tạo xơ trên bề mặt.</strong></li></ul><p>&nbsp;</p><figure class="image"><img style="aspect-ratio:800/600;" src="http://localhost:8080/Namcombank/assets/img/ActivityDiagram.jpg" width="800" height="600"></figure><h3><strong>2. Độ co giãn</strong></h3><p><strong>Không chỉ về chất liệu, mà độ co giãn cũng đóng góp một phần quan trọng trong việc mang lại sự thoải mái và tự tin cho người mặc. Đối với một bộ đồ tập gym, độ co giãn cao là điều cần thiết để đảm bảo phạm vi hoạt động rộng khi thực hiện các động tác. Ngoài ra, lựa chọn đai quần có tính đàn hồi, ôm vừa eo cũng rất quan trọng. Tránh những chiếc quần quá chặt vì chúng có thể gây ra vết hằn và đau rát trên vùng bụng.</strong></p><h3><strong>3. Size phù hợp</strong></h3><p><strong>Một bộ quần áo thể thao lý tưởng nên có kích cỡ vừa vặn, không quá rộng hoặc quá chật. Khi quần áo quá rộng, nó có thể bị vướng vào các thiết bị tập luyện hoặc gây cản trở khi thực hiện các động tác. Nếu quần áo quá chật, nó có thể hạn chế sự lưu thông máu và ảnh hưởng đến chất lượng buổi tập.</strong></p><h3><strong>4. Thời tiết</strong></h3><p><strong>Dưới đây là một số gợi ý về </strong><a href="https://www.coolmate.me/post/trang-phuc-tap-gym-nam-gioi-thoai-mai-nhattrang%20ph%E1%BB%A5c%20t%E1%BA%ADp%20gym"><strong>trang phục tập gym</strong></a><strong> cho nam giới, tùy thuộc vào mùa:</strong></p><p><strong>Trang phục mùa hè:Khi mùa hè đến, chất liệu thoáng khí và thấm hút là ưu tiên hàng đầu. Vì khí hậu nóng có thể làm bạn ra mồ hôi nhiều hơn, việc chọn sai chất liệu sẽ khiến bạn cảm thấy nóng bức và không thoải mái khi tập luyện. Đồng thời, nếu mồ hôi không được thấm hút ngay, cơ thể có thể bị lạnh. Đây là một số item phù hợp cho mùa hè:</strong></p><ul><li><strong>Áo ba lỗ, </strong><a href="https://www.coolmate.me/collection/ao-ba-lo-tank-top-nam"><strong>áo tank top</strong></a><strong>: Những loại áo này thoáng mát và giúp bạn cảm thấy dễ chịu trong nắng nóng.</strong></li><li><strong>Áo phông:&nbsp;Một chiếc áo phông có chất liệu thấm hút tốt cũng là một lựa chọn tốt cho mùa hè.</strong></li><li><strong>Quần short: Để tạo sự thoải mái và linh hoạt khi tập luyện, quần short là một item phù hợp.</strong></li></ul><p><strong>Trang phục mùa đông:&nbsp;Mùa đông đòi hỏi trang phục thoải mái, thấm hút và giữ ấm cơ thể. Dưới đây là một số gợi ý cho mùa đông:</strong></p><ul><li><strong>Áo phông kết hợp áo ba lỗ:&nbsp;Lớp áo phông bên trong có thể giữ ấm cơ thể, trong khi áo ba lỗ bên ngoài có tính thoáng khí và linh hoạt hơn cho việc vận động.</strong></li><li><strong>Quần jogger: Một chiếc quần jogger thoải mái và ấm áp là lựa chọn phù hợp trong mùa đông.</strong></li><li><p><strong>Áo thun hoặc quần legging giữ nhiệt:&nbsp;Có sẵn những chiếc áo thun hoặc quần legging giữ nhiệt, được ưa chuộng bởi nhiều người tập gym. Đây là những item đáng xem xét để sở hữu trong những buổi tập luyện vào mùa đông.</strong></p><figure class="image"><img style="aspect-ratio:800/600;" src="http://localhost:8080/Namcombank/assets/img/ActivityDiagram.jpg" width="800" height="600"></figure><p>&nbsp;</p></li></ul>', 1, CAST(N'2024-07-10T00:00:00.000' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (3, 1, N'May áo sơ mi nam cần bao nhiêu mét vải?', N'<h2><strong>1. Cách tính vải may quần áo chi tiết</strong></h2><p><strong>Để biết cách tính vải may quần áo chính xác nhất đòi hỏi một quá trình tập luyện và thực hành dài. Tuy vậy, nếu không phải "dân chuyên", bạn vẫn có thể tìm hiểu cách tính cơ bản để dễ dàng trao đổi với thợ may khi cần may đồ.</strong></p><h3><strong>1.1. Tìm hiểu về khái niệm khổ vải</strong></h3><p><strong>Trước khi biết </strong><a href="https://www.coolmate.me/post/cach-tinh-vai-may-quan-ao-4144?jskey=acEozRp2TqnwGNxyjbkekaSoOmaqwXiTvVwyD6FiG2MB"><strong>cách tính vải may quần áo</strong></a><strong>, bạn cần nắm được khái niệm về khổ vải. Khổ vài chỉ chiều rộng của 1 cuộn vải tính từ 2 đầu. Ví dụ, nếu 1 cuộn vải có chiều rộng 1,15m thì được gọi là khổ vải 1m.</strong></p><figure class="image"><img style="aspect-ratio:800/600;" src="http://localhost:8080/Namcombank/assets/img/ActivityDiagram.jpg" width="800" height="600"></figure><p><strong>Đơn vị đo khổ vải thường là mét hoặc inch. Trên thị trường hiện nay sẽ có nhiều khổ vải khác nhau từ 0,9m; 1,20m; 1,50m,... để đáp ứng nhu cầu may mặc. Đặc biệt, may áo và quần đều cần khổ vải khác nhau. Ví dụ, nếu may quần áo nam, bạn sẽ cần các khổ vải theo chất liệu cụ thể như sau:</strong></p><figure class="image"><img style="aspect-ratio:871/552;" src="http://localhost:8080/Namcombank/assets/img/ActivityDiagram.jpg" width="871" height="552"></figure><p>&nbsp;</p><h3><strong>2. Cách tính vải may quần áo cho từng loại trang phục</strong></h3><p><strong>Cách tính vải may quần áo sẽ phụ thuộc vào việc bạn muốn may áo hay may quần và bạn chọn khổ vải nào. Cụ thể như sau:</strong></p><h4><strong>1.2.1. Cách tính vải may áo</strong></h4><p><strong>Khổ vải 90cm, 1m1: Mua gấp đôi vải sao cho độ dài áo và độ dài tay áo thêm 10cm.Khổ vải 1m2, 1m3: Độ dài áo bằng dài tay áo tăng thêm 10cm.Khổ vải 1m5, 1m6: Mua 1m vải nếu may áo ngắn tay, mua 1m2 vải nếu may áo dài tay.Khổ vải 1m8, 2m: Mua 80cm là đủ nếu là vải cotton.</strong></p><figure class="image"><img style="aspect-ratio:800/600;" src="http://localhost:8080/Namcombank/assets/img/ActivityDiagram.jpg" width="800" height="600"></figure><h4><strong>1.2.2. Cách tính vải may quần</strong></h4><p><strong>Khổ vải 1m2, 1m3: Mua 1m5 vải nếu muốn may quần vừa vặn.Khổ vải 1m5, 1m6: Mua 1m1 vải là phù hợp. Nếu muốn chiều dài quần ngắn hơn 85cm chỉ cần mua khoảng 1m vải.</strong></p><h4><strong>1.2.3. May áo sơ mi nam cần bao nhiêu mét vải?</strong></h4><p><strong>Hiện nay, để biết may áo sơ mi nam cần bao nhiêu vải, các nhà may, xưởng may thưởng sử dụng chủ yếu bảng thông số theo chiều cao dưới đây để biết cách tính vải may quần áo.&nbsp;</strong></p><p><strong>Ngoài cách tính vải dựa trên chiều cao, để biết may áo sơ mi nam cần bao nhiêu mét vải còn phụ thuộc vào nhiều yếu tố như kiểu dáng áo mong muốn, chất liệu may áo cũng như tay nghề và kinh nghiệm của thợ may.&nbsp;</strong></p>', 1, CAST(N'2024-07-10T00:00:00.000' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (10, 1, N'Hihi', N'<p>Haha</p>', 0, CAST(N'2025-03-09T11:17:30.107' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (11, 1, N'Thông tin lãi suất cho vay bình quân của Vietcombank', N'<figure class="image"><img style="aspect-ratio:3333/2500;" src="http://localhost:8080/Namcombank/assets/img/newsImage/Thong bao lai suat 2025 thang 2_V.webp" width="3333" height="2500"></figure>', 1, CAST(N'2025-03-09T14:59:46.187' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (21, 3, N'Lalala', N'<p>KKK</p>', 0, CAST(N'2025-03-09T16:44:49.513' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (22, 58, N'qwerty', N'<p>qwerty</p>', 0, CAST(N'2025-03-09T16:47:26.207' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (26, 61, N'Cảnh báo hình thức lừa đảo tài chính qua mạng xã hội', N'<p>Kính gửi Quý khách,</p><p>&nbsp;</p><p>Trong thời đại công nghệ số, mạng xã hội trở nên phổ biến tại Việt Nam và đem lại nhiều lợi ích trong công việc cũng như cuộc sống. Bên cạnh đó, lợi dụng sự thuận tiện trong hoạt động tương tác trên mạng xã hội, các đối tượng có xu hướng thực hiện ngày càng nhiều hành vi giả mạo với thủ đoạn đa dạng nhằm chiếm đoạt thông tin và tài sản của nạn nhân.</p><p>&nbsp;</p><p>Techcombank xin thông tin đến quý khách hình thức lừa đảo tài chính đang phổ biến trên mạng xã hội với các bước thực hiện hành vi như sau:&nbsp;</p><h2><strong>&nbsp;1. Mạo danh ngân hàng trên mạng xã hội:</strong></h2><p>&nbsp;</p><figure class="image"><img style="aspect-ratio:883/534;" src="http://localhost:8080/Namcombank/assets/img/newsImage/Screenshot 2025-03-09 153343.png" width="883" height="534"></figure><h2><strong>&nbsp;2. Lừa đảo từ cài đặt ứng dụng giả mạo:</strong></h2><p>Hành vi lừa đảo thông qua cài đặt ứng dụng giả mạo hiện vẫn tiếp diễn và gây ra nhiều thiệt hại cho nạn nhân, do đó, Techcombank xin khuyến cáo một lần nữa đến quý khách để nâng cao cảnh giác với thủ đoạn lừa đảo phổ biến như sau:</p><figure class="image"><img style="aspect-ratio:887/634;" src="http://localhost:8080/Namcombank/assets/img/newsImage/Screenshot 2025-03-09 153445.png" width="887" height="634"></figure><p>Để phòng tránh rủi ro chiếm đoạt thông tin và tài sản, Techcombank khuyến cáo quý khách:</p><figure class="image"><img style="aspect-ratio:880/761;" src="http://localhost:8080/Namcombank/assets/img/newsImage/Screenshot 2025-03-09 153522.png" width="880" height="761"></figure><figure class="image"><img style="aspect-ratio:877/591;" src="http://localhost:8080/Namcombank/assets/img/newsImage/Screenshot 2025-03-09 153644.png" width="877" height="591"></figure><p>&nbsp;</p><p><i><strong>Ghi nhớ:</strong></i><strong> </strong><i><strong>Ngân hàng không bao giờ yêu cầu khách hàng cung cấp thông tin tài khoản ngân hàng, thông tin thẻ (mã CVV, số thẻ), mã OTP, mật khẩu... qua điện thoại, tin nhắn hay website, mạng xã hội.</strong></i></p><p>&nbsp;</p><p>Kính mong quý khách nâng cao cảnh giác để bảo vệ thông tin, tài sản cá nhân.</p><p>Chân thành cảm ơn sự hợp tác và đồng hành của quý khách!</p><p>&nbsp;</p><p>Trân trọng,</p><p><strong>Techcombank</strong></p><p><strong>Ngân hàng Thương mại cổ phần Kỹ thương Việt Nam.</strong></p>', 1, CAST(N'2025-03-10T08:54:03.467' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (27, 1, N'Cảnh báo lừa đảo liên quan đến giải chạy Vietcombank Run & Share 2025', N'<p><strong>Theo ghi nhận của Ngân hàng TMCP Ngoại thương Việt Nam (Vietcombank), gần đây đã xuất hiện một số fanpage giả mạo giải chạy Vietcombank Run &amp; Share 2025 nhằm lừa đảo và chiếm đoạt tài sản của người có nhu cầu đăng ký tham gia.</strong></p><p><br>&nbsp;</p><p>Cụ thể, các fanpage này sử dụng trái phép logo, hình ảnh và thông tin của giải chạy để tạo lòng tin. Các đối tượng lừa đảo kêu gọi người dân chuyển tiền để đăng ký tham gia, thậm chí hướng dẫn tham gia các nhóm trên Zalo hoặc Telegram để thực hiện các “nhiệm vụ” nhằm hưởng ưu đãi như miễn phí chi phí tham gia hoặc quà tặng.</p><figure class="image"><img style="aspect-ratio:770/600;" src="https://www.vietcombank.com.vn/-/media/Project/VCB-Sites/VCB/Tin-tuc/2025/Don-vi-thanh-vien/Don-vi-thanh-vien_202503/Don-vi-thanh-vien_20250301/20250307NMHCanh-bao-giai-chay-VCBNews.png?ts=20250310075513" width="770" height="600"></figure><p>Những “nhiệm vụ” này thường yêu cầu người tham gia chuyển tiền vào tài khoản cá nhân hoặc tổ chức với lời hứa sẽ được hoàn lại ngay. Ban đầu, các đối tượng lừa đảo thường hoàn tiền đầy đủ kèm theo lợi nhuận để tạo sự tin tưởng. Tuy nhiên, sau khi nạn nhân chuyển số tiền lớn hơn, chúng sẽ chặn liên lạc và chiếm đoạt tài sản.</p><p>Vietcombank khẳng định giải chạy Vietcombank Run &amp; Share 2025 không thu phí đăng ký. Mọi thông tin chính thức về giải chạy chỉ được đăng tải trên website chính thức của ngân hàng tại địa chỉ <a href="https://www.vietcombank.com.vn/">https://www.vietcombank.com.vn</a>, fanpage chính thức tại <a href="https://facebook.com/ilovevcb">https://facebook.com/</a>ilovevcb và fanpage chính thức của Đoàn Thanh niên Vietcombank tại địa chỉ <a href="https://www.facebook.com/tuoitrevcb">https://www.facebook.com/tuoitrevcb</a> cũng như website chính thức của giải chạy: <a href="https://vcbrace.vrun.vn/">https://vcbrace.vrun.vn</a>. Tất cả các hình thức đăng ký khác đều là giả mạo.</p><p>Ngân hàng khuyến cáo khách hàng và người dân chỉ đăng ký tham gia qua kênh chính thức của Vietcombank, không chuyển tiền hoặc làm theo hướng dẫn của bất kỳ fanpage hay nhóm chat nào không rõ nguồn gốc. Trước khi tham gia, người dân cần tìm hiểu kỹ về tư cách pháp nhân của đơn vị tổ chức để đảm bảo tính minh bạch. Nếu phát hiện dấu hiệu lừa đảo, khách hàng cần báo ngay cho cơ quan chức năng để có biện pháp xử lý kịp thời.</p><p>Trước đây, tình trạng giảmạo tương tựđã xảy ra vào năm 2024 với một loạt các giải chạy do Vietcombank tổ chức hoặc tài trợ. Vietcombank khi đó đã phát đicảnh báo tại: <a href="https://www.vietcombank.com.vn/vi-VN/Trang-thong-tin-dien-tu/Articles/2024/07/22/20240722_VCB-canh-bao-gia-mao-giai-chay">https://www.vietcombank.com.vn/vi-VN/Trang-thong-tin-dien-tu/Articles/2024/07/22/20240722_VCB-canh-bao-gia-mao-giai-chay</a></p>', 1, CAST(N'2025-03-13T10:36:57.927' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (29, 62, N'Vietcombank ra mắt Online Lending (Giải Ngân Trực Tuyến): Số hóa giải ngân - nhận ngàn tiện ích', N'<p>Vietcombank tự hào giới thiệu <strong>Online Lending</strong> - giải pháp giải ngân trực tuyến ưu việt, được thiết kế nhằm đáp ứng nhu cầu vốn một cách nhanh chóng và hiệu quả cho doanh nghiệp. Với sự đầu tư mạnh mẽ vào công nghệ số hóa, Online Lending giúp đơn giản hóa quy trình giải ngân, tiết kiệm thời gian và nâng cao trải nghiệm khách hàng.</p><figure class="image"><img style="aspect-ratio:1200/922;" src="https://www.vietcombank.com.vn/-/media/Project/VCB-Sites/VCB/Tin-tuc/2025/Vietcombank/Vietcombank_202502/Vietcombank_20250221/20250228_VCB-ra-mat-online-lending-ver-viet.png?ts=20250228074113" width="1200" height="922"></figure><h3><strong>LỢI ÍCH NỔI BẬT CỦA ONLINE LENDING:</strong></h3><p><strong>1. Hồ sơ online, tiện lợi</strong></p><p>Khách hàng chủ động theo dõi trạng thái hồ sơ và tiến độ xử lý qua hệ thống trực tuyến.</p><p><strong>2. Ký số mọi lúc, mọi nơi</strong></p><p>Không còn phụ thuộc vào giấy tờ hay địa điểm, với tính năng ký số mọi lúc, mọi nơi, doanh nghiệp có thể xử lý hồ sơ giải ngân một cách nhanh gọn, giúp tiết kiệm thời gian và tối ưu hiệu suất làm việc.</p><p><strong>3. Thông tin minh bạch, tức thời</strong></p><p>Mọi thông tin về khoản giải ngân được công khai rõ ràng, đảm bảo doanh nghiệp luôn kiểm soát dòng tiền hiệu quả.</p><p><strong>QUY TRÌNH GIẢI NGÂN CHỈ VỚI 6 BƯỚC ĐƠN GIẢN:</strong></p><p>1. Đăng ký dịch vụ giải ngân trực tuyến (cung cấp chữ ký số và hợp đồng tín dụng).</p><p>2. Tạo đề nghị giải ngân.</p><p>3. Ký số hồ sơ.</p><p>4. Vietcombank thẩm định và phê duyệt hồ sơ.</p><p>5. Giải ngân thành công.</p><p>6. Quản lý và theo dõi hồ sơ sau vay trên hệ thống.</p><h3><strong>ƯU ĐÃI ĐẶC BIỆT:</strong></h3><p><strong>- Miễn phí chuyển tiền giải ngân</strong> đến hết tháng <strong>3/2025</strong></p><p>- Nhận <strong>ưu đãi chữ ký số</strong> từ các đối tác uy tín của Vietcombank</p><p><strong>ĐIỀU KIỆN ĐĂNG KÝ SỬ DỤNG DỊCH VỤ</strong></p><h3><strong>Điều kiện khách hàng</strong></h3><p><strong>1. Đăng ký dịch vụ</strong></p><p>- Đã đăng ký giao dịch qua kênh Ngân hàng số của VCB (VCB-iBanking/VCB CashUp).</p><p>- Chữ ký số hợp lệ tại thời điểm giải ngân, gồm chữ ký số tổ chức và cá nhân đại diện.</p><p><strong>2. Cá nhân tham gia giao dịch</strong></p><p>- Tổ chức phải có kế toán trưởng/người phụ trách kế toán đăng ký với VCB.</p><p>- Người phê duyệt cuối cùng là đại diện pháp luật hoặc người được ủy quyền, có đăng ký chữ ký số với VCB.</p><p><strong>3. Hợp đồng tín dụng</strong></p><p>- Hợp đồng vay ngắn hạn còn hiệu lực.</p><p>- Mục đích vay phù hợp với quy định của VCB trong từng thời kỳ.</p><p>Quý khách vui lòng liên hệ hotline 1900 54 54 13 hoặc Chi nhánh/Phòng Giao dịch Vietcombank gần nhất để được hõ trợ.</p>', 1, CAST(N'2025-03-13T10:49:21.160' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (30, 61, N'Techcombank tiếp tục là nhà đồng đầu tư Concert Anh Trai Vượt Ngàn Chông Gai đêm thứ 3, 4', N'<p>Với những sân khấu “đỉnh nóc” và “cơn sốt săn vé” trước đây, concert lần này hứa hẹn sẽ tạo nên hiệu ứng bùng nổ “kịch trần”. Đáp lại lòng mong đợi từ người hâm mộ và các khách hàng, Techcombank mang đến thêm cơ hội “săn vé” cực kì hấp dẫn.</p><p><br><img src="https://techcombank.com/thong-tin/thong-bao/techcombank-tiep-tuc-la-nha-dong-dau-tu-concert-anh-trai-vuot-ngan-chong-gai-dem-thu-3-4/_jcr_content/root/container/image_copy.coreimg.png/1737687226463/atvncg-1.png" width="1280" height="1605"></p><p>Kết lại một hành trình đáng nhớ với nhiều dấu ấn thành công và kỉ niệm đẹp, Concert Anh Trai Vượt Ngàn Chông Gai đêm diễn thứ 3 và thứ 4 vào ngày 22, 23/03/2025 sẽ tiếp tục khuấy động không gian âm nhạc Việt Nam tại khu phức hợp giải trí mới của TP. Hồ Chí Minh là The Global City, Đường Đỗ Xuân Hợp, Phường An Phú, Thành phố Thủ Đức, Thành phố Hồ Chí Minh.</p><p><img src="https://techcombank.com/thong-tin/thong-bao/techcombank-tiep-tuc-la-nha-dong-dau-tu-concert-anh-trai-vuot-ngan-chong-gai-dem-thu-3-4/_jcr_content/root/container/image.coreimg.jpeg/1737687249798/atvncg-2.jpeg" width="1280" height="784"></p><p><br>Và Techcombank lại cùng Yeah 1 mang đến những chương trình săn vé hấp dẫn. Xuyên suốt “cơn sốt” săn vé của cộng đồng người hâm mộ trước đây, ngân hàng đã liên tục lắng nghe các phản hồi và đưa ra nhiều cách thức hấp dẫn để khách hàng sở hữu vé, đồng thời trải nghiệm thêm các sản phẩm đột phá. Cụ thể với đêm concert thứ 2 tại Hà Nội, gần 500 ngàn khách hàng đã tham gia chương trình nhận vé ưu đãi từ Techcombank, tạo nên hơn 1 triệu lượt thảo luận trên mạng xã hội. Khẳng định tầm nhìn chiến lược của ngân hàng là “thay đổi ngành tài chính, nâng tầm giá trị sống”, Techcombank không chỉ góp phần mang lại trải nghiệm âm nhạc đỉnh cao, mà còn tiên phong đem đến các giải pháp quản lý tài chính cá nhân độc đáo.</p><p>&nbsp;</p><p>Ngoài việc nhận được vé tham dự concert, khách hàng còn được trải nghiệm giải pháp Sinh Lời Tự Động từ Techcombank - một sáng kiến mới trong ngành tài chính, hỗ trợ tối ưu sinh lời trên các dòng tiền ngắn ngày đang chờ chi tiêu. Hàng triệu khách hàng đang sử dụng tài khoản thanh toán để thực hiện chi tiêu tiện lợi và an toàn với công nghệ bảo mật tiên tiến.</p><p><img src="https://techcombank.com/thong-tin/thong-bao/techcombank-tiep-tuc-la-nha-dong-dau-tu-concert-anh-trai-vuot-ngan-chong-gai-dem-thu-3-4/_jcr_content/root/container/image_copy_965816491.coreimg.png/1737687887053/atvncg-3.png" width="900" height="600"></p><p><br>Sau khi kích hoạt Techcombank Sinh Lời Tự Động, toàn bộ dòng tiền này sẽ được hưởng lợi suất hấp dẫn gấp đến 50 lần mỗi ngày so với lãi suất không kỳ hạn khi chưa bật sản phẩm Sinh Lời Tự Động từ Techcombank, và điều này vẫn đảm bảo giao dịch chi tiêu liền mạch 24/7.</p><p>&nbsp;</p><p>Với cơ chế sinh lời độc đáo - “tiền càng nhiều, càng thêm lời”, khách hàng giờ đây không còn cần phải để tiền lâu hơn mới có lợi suất cao hơn. Toàn bộ dòng tiền sẽ được tối ưu trọn vẹn từng ngày và vẫn sẵn sàng chi tiêu khi cần. Thực tế chứng minh, đã có hơn 2 triệu khách hàng kích hoạt Techcombank Sinh Lời Tự Động, tận hưởng lợi ích sinh lời hấp dẫn trên khoản tiền chờ thanh toán và chi tiêu của khách hàng.</p><p>&nbsp;</p><p>Ngày 17/01/2025, Techcombank đã chính thức công bố cách thức “săn vé” đến concert, để người hâm mộ lại một lần đắm chìm trong âm nhạc và nghệ thuật đỉnh cao.</p><p>&nbsp;</p><p><strong>Cách thức sở hữu vé tham dự concert từ Techcombank</strong></p><p>&nbsp;</p><p>Khi tham gia chương trình “Săn Vé Anh Tài” được triển khai từ ngày 18/01/2025 với những cách thức tham gia dễ dàng, quen thuộc, khách hàng sẽ có cơ hội sở hữu vé concert "miễn phí".</p><p>&nbsp;</p><p>Đối với hình thức tích lũy vòng quay may mắn “săn vé anh tài”, chương trình sẽ chính thức triển khai từ 18/01/2025 và kéo dài đến ngày 02/03/2025. Dự kiến sẽ có khoảng gần 15,000 khách hàng nhận được ưu đãi tặng vé thông qua vòng quay “săn vé anh tài”, với tổng giá trị quà tặng mà Techcombank dành cho khách hàng lên tới hơn 16 tỉ đồng.</p><p>&nbsp;</p><p>Ngoài ra, khi giao dịch QR trên ứng dụng Techcombank Mobile với giá trị giao dịch từ 500 ngàn đồng trở lên trong ngày, hoặc phát sinh giao dịch thanh toán qua thẻ thanh toán Techcombank/ thẻ tín dụng Techcombank tối thiểu 100 ngàn đồng, khách hàng cũng có cơ hội nhận được vé quay thưởng mỗi ngày trong tối thiểu 05 (năm) ngày thuộc Đợt tích lũy vé quay.</p><figure class="image"><img style="aspect-ratio:1280/853;" src="https://techcombank.com/thong-tin/thong-bao/techcombank-tiep-tuc-la-nha-dong-dau-tu-concert-anh-trai-vuot-ngan-chong-gai-dem-thu-3-4/_jcr_content/root/container/image_copy_965816491_1934123632.coreimg.jpeg/1737687912513/atvncg-4.jpeg" width="1280" height="853"></figure><p>Khách hàng có thể tham gia cùng lúc 2 cách thức để gia tăng cơ hội tích lũy vé quay may mắn và tận hưởng các đặc quyền từ Techcombank; vừa tối ưu dòng tiền cùng Sinh Lời Tự Động, vừa tận hưởng hàng loạt ưu đãi khi thực hiện chi tiêu cùng Techcombank.</p><p>&nbsp;</p>', 1, CAST(N'2025-03-13T10:56:17.630' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (31, 63, N'Vietcombank là ngân hàng đầu tiên ra mắt tính năng “Thông báo số dư bằng giọng nói” (Voice OTT) trên app ngân hàng số', N'<p>Ngày 20/2/2025, Vietcombank chính thức giới thiệu tính năng <strong>Voice OTT - Thông báo biến động số dư bằng giọng nói</strong> trên ứng dụng VCB Digibank<strong>, </strong>giúp người dùng nhận biết được số tiền chuyển đến đến mà không cần mở ứng dụng.</p><figure class="image"><img style="aspect-ratio:900/555;" src="https://www.vietcombank.com.vn/-/media/Project/VCB-Sites/VCB/Tin-tuc/2025/Vietcombank/Vietcombank_202502/Vietcombank_20250221/20250224_VCB_Thong-tin-bao-chi-Voice-OTT_Anh-1.jpg?ts=20250224100600" width="900" height="555"></figure><p>Tính năng <strong>Voice OTT</strong> đặc biệt hữu ích với người bán hàng, hộ kinh doanh cá thể và những người thường xuyên nhận giao dịch chuyển khoản, giúp khách hàng thuận tiện hơn trong công việc kinh doanh thường ngày với các lợi ích nổi bật:</p><ul><li><strong>Miễn phí hoàn toàn</strong>: Khách hàng không phải trả thêm bất kỳ chi phí nào khi sử dụng tính năng này.</li><li><strong>Cài đặt nhanh chóng</strong>: Chỉ mất chưa đến một phút để kích hoạt trực tiếp trên ứng dụng VCB Digibank.</li><li><strong>Không cần liên kết ứng dụng thứ ba</strong>: Đơn giản hóa quá trình sử dụng.</li><li><strong>Thông báo qua loa điện thoại</strong>: Khi có giao dịch đến, hệ thống sẽ phát thông báo bằng giọng nói qua loa điện thoại, giúp khách hàng nhận biết ngay lập tức mà không cần mở ứng dụng hay màn hình điện thoại.</li><li><strong>Hỗ trợ kết nối loa Bluetooth</strong>: Đối với môi trường ồn ào hoặc khi cần âm lượng lớn hơn, khách hàng có thể kết nối điện thoại với loa/tai nghe Bluetooth để nhận thông báo rõ ràng hơn.</li></ul><p><i>Lưu ý: Để tính năng hoạt động hiệu quả, điện thoại của người dùng cần tắt chế độ im lặng và cho phép ứng dụng VCB Digibank gửi thông báo.</i></p><figure class="image"><img style="aspect-ratio:900/555;" src="https://www.vietcombank.com.vn/-/media/Project/VCB-Sites/VCB/Tin-tuc/2025/Vietcombank/Vietcombank_202502/Vietcombank_20250221/20250224_VCB_Thong-tin-bao-chi-Voice-OTT_Anh-1.jpg?ts=20250224100600" width="900" height="555"></figure><figure class="image"><img style="aspect-ratio:900/964;" src="https://www.vietcombank.com.vn/-/media/Project/VCB-Sites/VCB/Tin-tuc/2025/Vietcombank/Vietcombank_202502/Vietcombank_20250221/20250224_VCB_Thong-tin-bao-chi-Voice-OTT_Anh-3.jpg?ts=20250224100601" width="900" height="964"></figure><p>Khác với loa thông báo nhận tiền, tính năng Voice OTT không yêu cầu cài đặt ứng dụng bên thứ ba hay đầu tư thêm thiết bị. Ngoài ra, người dùng có thể dễ dàng kết hợp Voice OTT với các tính năng khác dành cho người bán hàng như: <i>QR bán hàng; chia sẻ biến động số dư; liên kết với phần mềm KiotViet…</i> để tối ưu vận hành kinh doanh.</p><p>Với việc ra mắt Voice OTT, Vietcombank tiếp tục khẳng định cam kết mang đến khách hàng những giải pháp ngân hàng số hiện đại, liên tục đổi mới sáng tạo để nâng cao trải nghiệm của khách hàng trong thời đại công nghệ số.</p><p><br>&nbsp;</p>', 1, CAST(N'2025-03-13T10:59:13.217' AS DateTime))
SET IDENTITY_INSERT [dbo].[News] OFF
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
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 5)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 7)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 8)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 15)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 16)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 17)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 21)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 36)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 38)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 1)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 2)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 3)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 4)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 5)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 15)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 16)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 17)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 21)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 36)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 37)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 38)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 1)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 2)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 3)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 4)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 5)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 15)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 16)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 17)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 21)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 38)
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
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (2, 2, N'Tran Thi Anh', N'anhtt', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 1, N'tqtolympia@gmail.com', CAST(N'1990-10-10' AS Date), 0, N'0987654322', N'556677889', N'123 Đường Mới, Hà Nội', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (3, 3, N'Nguyen Van Hoang', N'hoangnv', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 1, N'hungdoan1308@gmail.com', CAST(N'1982-07-20' AS Date), 1, N'0987654328', N'042204007391', N'789 Street, Hanoi', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (26, 4, N'Doan Vinh', N'hungdoan', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 0, N'hungdv@gmail.com', CAST(N'2024-07-11' AS Date), 1, N'0816610259', N'042204001159', N'Ha Noi', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (33, 2, N'Doan Vinh', N'Hungdoan1308', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 0, N'giang__@gmail.com', CAST(N'2024-11-08' AS Date), 1, N'0913352377', N'042204001190', N'Ha Noi', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (39, 4, N'hungdv123', N'ABCabc123', N'OwWItAcFpjf4LE4wsJhZ2OR55AE=', 0, N'hungd@gmail.com', CAST(N'2025-02-13' AS Date), 1, N'0816610258', N'042204001158', N'vietnam', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (46, 1, N'Doan Vinh', N'bvcBVC123', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 1, N'tqtolympia@gmail.com', CAST(N'2025-02-13' AS Date), 1, N'0816610238', N'042204001100', N'vietnam', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (48, 2, N'Hưng Đoàn', N'Abc123456', N'tedO67WLRTVYGEWMVpY5dsr6ybo=', 0, N'hungdvd@gmail.com', CAST(N'2025-02-12' AS Date), 1, N'0816610243', N'042204001156', N'vietnam', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (54, 2, N'Hưng Đoàn', N'chieu123', N'LM0n4tvr/ab0/AOKQXneOgvVz3Q=', 0, N'huyenmyn2004@gmail.com', CAST(N'2025-02-14' AS Date), 1, N'0816610275', N'042204001174', N'Ha Noi', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (58, 4, N'Trần Đức Anh', N'anhtd', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 0, N'truongtqhe186765@gmail.com', CAST(N'2025-03-08' AS Date), 1, N'0159753684', N'012345678910', N'Vietnam', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (60, 1, N'Đinh Xuân Dương', N'duongdx', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 1, N'truongtqhe186765@gmail.com', CAST(N'2025-03-08' AS Date), 1, N'0159753685', N'012345678911', N'Vietnam', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (61, 1, N'Role Nhân Viên', N'rolenhanvien', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 1, N'tqtolympia@gmail.com', CAST(N'2025-03-08' AS Date), 1, N'0123654789', N'011546464640', N'Vietnam', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (62, 5, N'Role Trưởng Phòng', N'roletruongphong', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 1, N'tqtolympia@gmail.com', CAST(N'2025-03-08' AS Date), 1, N'0987654330', N'012345678912', N'Vietnam', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (63, 3, N'Role Kế Toán', N'roleketoan', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 1, N'tqtolympia@gmail.com', CAST(N'2025-03-07' AS Date), 1, N'0987654329', N'012345678900', N'Vietnam', NULL)
SET IDENTITY_INSERT [dbo].[Staff] OFF
GO
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (1, 1)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (2, 2)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (26, 2)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (3, 3)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (NULL, 2)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (NULL, 3)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (NULL, 4)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (46, 3)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (46, 2)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (48, 2)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (48, 3)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (54, 1)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (33, 3)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (39, 1)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (1, 4)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (58, 4)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (60, 2)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (61, 2)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (62, 3)
INSERT [dbo].[StaffRoles] ([staff_id], [role_id]) VALUES (63, 4)
GO
ALTER TABLE [dbo].[Customer] ADD  DEFAULT ((0)) FOR [active]
GO
ALTER TABLE [dbo].[Customer] ADD  DEFAULT ((0)) FOR [balance]
GO
ALTER TABLE [dbo].[Staff] ADD  DEFAULT ((0)) FOR [active]
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
ALTER TABLE [dbo].[LoanPackages]  WITH CHECK ADD  CONSTRAINT [FK_LoanPackages_Staff] FOREIGN KEY([staff_id])
REFERENCES [dbo].[Staff] ([staff_id])
GO
ALTER TABLE [dbo].[LoanPackages] CHECK CONSTRAINT [FK_LoanPackages_Staff]
GO
ALTER TABLE [dbo].[LoanRequests]  WITH CHECK ADD  CONSTRAINT [FK_LoanRequests_Customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customer] ([customer_id])
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
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_LoanRequests] FOREIGN KEY([request_id])
REFERENCES [dbo].[LoanRequests] ([request_id])
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
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [CHK_Feedback_Rating] CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [CHK_Feedback_Rating]
GO
ALTER TABLE [dbo].[SavingPackage]  WITH CHECK ADD CHECK  (([saving_package_status]='inactive' OR [saving_package_status]='active'))
GO
ALTER TABLE [dbo].[SavingPackage]  WITH CHECK ADD CHECK  (([saving_package_approval_status]='approved' OR [saving_package_approval_status]='pending'))
GO
ALTER TABLE [dbo].[SavingRequest]  WITH CHECK ADD CHECK  (([money_approval_status]='received' OR [money_approval_status]='pending'))
GO
ALTER TABLE [dbo].[SavingRequest]  WITH CHECK ADD CHECK  (([saving_approval_status]='rejected' OR [saving_approval_status]='approved' OR [saving_approval_status]='pending'))
GO
