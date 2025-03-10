USE [Namcombank]
GO
/****** Object:  Table [dbo].[Active]    Script Date: 3/10/2025 11:51:20 AM ******/
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
/****** Object:  Table [dbo].[Customer]    Script Date: 3/10/2025 11:51:21 AM ******/
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
/****** Object:  Table [dbo].[CustomerAssets]    Script Date: 3/10/2025 11:51:21 AM ******/
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
/****** Object:  Table [dbo].[Department]    Script Date: 3/10/2025 11:51:21 AM ******/
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
/****** Object:  Table [dbo].[Features]    Script Date: 3/10/2025 11:51:21 AM ******/
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
/****** Object:  Table [dbo].[Feedback]    Script Date: 3/10/2025 11:51:21 AM ******/
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
/****** Object:  Table [dbo].[Gender]    Script Date: 3/10/2025 11:51:21 AM ******/
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
/****** Object:  Table [dbo].[LoanPackages]    Script Date: 3/10/2025 11:51:21 AM ******/
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
/****** Object:  Table [dbo].[LoanRequests]    Script Date: 3/10/2025 11:51:21 AM ******/
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
	[start_date] [datetime] NOT NULL,
	[end_date] [datetime] NULL,
	[approval_date] [datetime] NOT NULL,
	[approved_by] [nvarchar](50) NOT NULL,
	[approved_note] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_LoanRequests] PRIMARY KEY CLUSTERED 
(
	[request_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Loans]    Script Date: 3/10/2025 11:51:21 AM ******/
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
/****** Object:  Table [dbo].[News]    Script Date: 3/10/2025 11:51:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[News](
	[news_id] [int] IDENTITY(1,1) NOT NULL,
	[staff_id] [int] NOT NULL,
	[title] [nvarchar](100) NOT NULL,
	[description] [nvarchar](max) NOT NULL,
	[status] [bit] NOT NULL,
	[updateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_News] PRIMARY KEY CLUSTERED 
(
	[news_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 3/10/2025 11:51:21 AM ******/
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
/****** Object:  Table [dbo].[RepaymentSchedule]    Script Date: 3/10/2025 11:51:21 AM ******/
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
/****** Object:  Table [dbo].[RoleFeatures]    Script Date: 3/10/2025 11:51:21 AM ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 3/10/2025 11:51:21 AM ******/
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
/****** Object:  Table [dbo].[Saving]    Script Date: 3/10/2025 11:51:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Saving](
	[savings_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[amount] [float] NOT NULL,
	[interest_rate] [float] NOT NULL,
	[term_months] [int] NOT NULL,
	[opened_date] [date] NOT NULL,
	[status] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Saving] PRIMARY KEY CLUSTERED 
(
	[savings_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 3/10/2025 11:51:21 AM ******/
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
/****** Object:  Table [dbo].[StaffRoles]    Script Date: 3/10/2025 11:51:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StaffRoles](
	[staff_id] [int] NULL,
	[role_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 3/10/2025 11:51:21 AM ******/
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

INSERT [dbo].[Customer] ([customer_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [balance], [citizen_identification_card], [address], [avatar]) VALUES (1, N'Nguyen Van An', N'annv', N'123', 1, N'annv@gmail.com', CAST(N'1990-01-01' AS Date), 1, N'0912345600', 1000000, N'052416398705', N'123 Street, Hanoi', NULL)
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
SET IDENTITY_INSERT [dbo].[News] ON 

INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (1, 1, N'Bí kíp phối đồ tập gym nam cực chất lại thoải mái ', N'<h3><strong>1. Chất liệu</strong></h3><p><strong>Yếu tố quan trọng và cơ bản nhất ảnh hưởng đến chất lượng của trang phục và hiệu quả của việc luyện tập là chất liệu. Khi bạn đầu tư một cách hợp lý vào quần áo tập gym, bạn sẽ tận hưởng sự thoải mái và dễ chịu trong quá trình luyện tập.</strong></p><p><strong>Khi mua </strong><a href="https://www.coolmate.me/post/7-dia-chi-mua-quan-ao-tap-gym-nam-chat-luong"><strong>quần áo tập gym cho nam</strong></a><strong> giới, hãy chú ý xem liệu chất liệu vải có khả năng thấm hút mồ hôi tốt và thoáng khí hay không. Khi tập luyện, cơ thể sẽ sản sinh mồ hôi và cần một luồng khí tươi để lưu thông tốt hơn.</strong></p><p><strong>Dù việc tập thể dục có ích cho sức khỏe, nhưng nếu mặc những bộ quần áo không cho phép mồ hôi thoát ra, cơ thể sẽ bị ướt và dễ bị cảm lạnh.</strong></p><p><strong>Hiện nay, có ba chất liệu phổ biến được sử dụng trong sản xuất quần áo tập gym: cotton, polyester và spandex. Hãy cùng xem những đặc điểm của từng loại vải này:</strong><br>&nbsp;</p><ul><li><strong>Cotton: Chất liệu này có khả năng thấm hút tuyệt vời và giới hạn mùi cơ thể. Tuy nhiên, trong những buổi tập với cường độ cao như tập gym, bạn có thể cảm thấy cơ thể ẩm như vừa tắm.</strong></li><li><strong>Polyester: Chất liệu này có độ bền cao, ít nhăn nhúm sau khi giặt, nhẹ và rất thoáng khí. Đặc biệt, vải polyester còn có khả năng chống tia cực tím (UV) ngay cả khi bị ướt.</strong></li><li><strong>Spandex: Chất liệu này có tính co giãn xuất sắc, có thể kéo giãn nhiều lần mà vẫn giữ được hình dạng ban đầu. Ngoài ra, vải spandex còn mềm mại, không gây tĩnh điện và không tạo xơ trên bề mặt.</strong></li></ul><p>&nbsp;</p><figure class="image"><img style="aspect-ratio:800/600;" src="http://localhost:8080/Namcombank/assets/img/ActivityDiagram.jpg" width="800" height="600"></figure><h3><strong>2. Độ co giãn</strong></h3><p><strong>Không chỉ về chất liệu, mà độ co giãn cũng đóng góp một phần quan trọng trong việc mang lại sự thoải mái và tự tin cho người mặc. Đối với một bộ đồ tập gym, độ co giãn cao là điều cần thiết để đảm bảo phạm vi hoạt động rộng khi thực hiện các động tác. Ngoài ra, lựa chọn đai quần có tính đàn hồi, ôm vừa eo cũng rất quan trọng. Tránh những chiếc quần quá chặt vì chúng có thể gây ra vết hằn và đau rát trên vùng bụng.</strong></p><h3><strong>3. Size phù hợp</strong></h3><p><strong>Một bộ quần áo thể thao lý tưởng nên có kích cỡ vừa vặn, không quá rộng hoặc quá chật. Khi quần áo quá rộng, nó có thể bị vướng vào các thiết bị tập luyện hoặc gây cản trở khi thực hiện các động tác. Nếu quần áo quá chật, nó có thể hạn chế sự lưu thông máu và ảnh hưởng đến chất lượng buổi tập.</strong></p><h3><strong>4. Thời tiết</strong></h3><p><strong>Dưới đây là một số gợi ý về </strong><a href="https://www.coolmate.me/post/trang-phuc-tap-gym-nam-gioi-thoai-mai-nhattrang%20ph%E1%BB%A5c%20t%E1%BA%ADp%20gym"><strong>trang phục tập gym</strong></a><strong> cho nam giới, tùy thuộc vào mùa:</strong></p><p><strong>Trang phục mùa hè:Khi mùa hè đến, chất liệu thoáng khí và thấm hút là ưu tiên hàng đầu. Vì khí hậu nóng có thể làm bạn ra mồ hôi nhiều hơn, việc chọn sai chất liệu sẽ khiến bạn cảm thấy nóng bức và không thoải mái khi tập luyện. Đồng thời, nếu mồ hôi không được thấm hút ngay, cơ thể có thể bị lạnh. Đây là một số item phù hợp cho mùa hè:</strong></p><ul><li><strong>Áo ba lỗ, </strong><a href="https://www.coolmate.me/collection/ao-ba-lo-tank-top-nam"><strong>áo tank top</strong></a><strong>: Những loại áo này thoáng mát và giúp bạn cảm thấy dễ chịu trong nắng nóng.</strong></li><li><strong>Áo phông:&nbsp;Một chiếc áo phông có chất liệu thấm hút tốt cũng là một lựa chọn tốt cho mùa hè.</strong></li><li><strong>Quần short: Để tạo sự thoải mái và linh hoạt khi tập luyện, quần short là một item phù hợp.</strong></li></ul><p><strong>Trang phục mùa đông:&nbsp;Mùa đông đòi hỏi trang phục thoải mái, thấm hút và giữ ấm cơ thể. Dưới đây là một số gợi ý cho mùa đông:</strong></p><ul><li><strong>Áo phông kết hợp áo ba lỗ:&nbsp;Lớp áo phông bên trong có thể giữ ấm cơ thể, trong khi áo ba lỗ bên ngoài có tính thoáng khí và linh hoạt hơn cho việc vận động.</strong></li><li><strong>Quần jogger: Một chiếc quần jogger thoải mái và ấm áp là lựa chọn phù hợp trong mùa đông.</strong></li><li><p><strong>Áo thun hoặc quần legging giữ nhiệt:&nbsp;Có sẵn những chiếc áo thun hoặc quần legging giữ nhiệt, được ưa chuộng bởi nhiều người tập gym. Đây là những item đáng xem xét để sở hữu trong những buổi tập luyện vào mùa đông.</strong></p><figure class="image"><img style="aspect-ratio:800/600;" src="http://localhost:8080/Namcombank/assets/img/ActivityDiagram.jpg" width="800" height="600"></figure><p>&nbsp;</p></li></ul>', 1, CAST(N'2024-07-10T00:00:00.000' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (3, 1, N'May áo sơ mi nam cần bao nhiêu mét vải?', N'<h2><strong>1. Cách tính vải may quần áo chi tiết</strong></h2><p><strong>Để biết cách tính vải may quần áo chính xác nhất đòi hỏi một quá trình tập luyện và thực hành dài. Tuy vậy, nếu không phải "dân chuyên", bạn vẫn có thể tìm hiểu cách tính cơ bản để dễ dàng trao đổi với thợ may khi cần may đồ.</strong></p><h3><strong>1.1. Tìm hiểu về khái niệm khổ vải</strong></h3><p><strong>Trước khi biết </strong><a href="https://www.coolmate.me/post/cach-tinh-vai-may-quan-ao-4144?jskey=acEozRp2TqnwGNxyjbkekaSoOmaqwXiTvVwyD6FiG2MB"><strong>cách tính vải may quần áo</strong></a><strong>, bạn cần nắm được khái niệm về khổ vải. Khổ vài chỉ chiều rộng của 1 cuộn vải tính từ 2 đầu. Ví dụ, nếu 1 cuộn vải có chiều rộng 1,15m thì được gọi là khổ vải 1m.</strong></p><figure class="image"><img style="aspect-ratio:800/600;" src="http://localhost:8080/Namcombank/assets/img/ActivityDiagram.jpg" width="800" height="600"></figure><p><strong>Đơn vị đo khổ vải thường là mét hoặc inch. Trên thị trường hiện nay sẽ có nhiều khổ vải khác nhau từ 0,9m; 1,20m; 1,50m,... để đáp ứng nhu cầu may mặc. Đặc biệt, may áo và quần đều cần khổ vải khác nhau. Ví dụ, nếu may quần áo nam, bạn sẽ cần các khổ vải theo chất liệu cụ thể như sau:</strong></p><figure class="image"><img style="aspect-ratio:871/552;" src="http://localhost:8080/Namcombank/assets/img/ActivityDiagram.jpg" width="871" height="552"></figure><p>&nbsp;</p><h3><strong>2. Cách tính vải may quần áo cho từng loại trang phục</strong></h3><p><strong>Cách tính vải may quần áo sẽ phụ thuộc vào việc bạn muốn may áo hay may quần và bạn chọn khổ vải nào. Cụ thể như sau:</strong></p><h4><strong>1.2.1. Cách tính vải may áo</strong></h4><p><strong>Khổ vải 90cm, 1m1: Mua gấp đôi vải sao cho độ dài áo và độ dài tay áo thêm 10cm.Khổ vải 1m2, 1m3: Độ dài áo bằng dài tay áo tăng thêm 10cm.Khổ vải 1m5, 1m6: Mua 1m vải nếu may áo ngắn tay, mua 1m2 vải nếu may áo dài tay.Khổ vải 1m8, 2m: Mua 80cm là đủ nếu là vải cotton.</strong></p><figure class="image"><img style="aspect-ratio:800/600;" src="http://localhost:8080/Namcombank/assets/img/ActivityDiagram.jpg" width="800" height="600"></figure><h4><strong>1.2.2. Cách tính vải may quần</strong></h4><p><strong>Khổ vải 1m2, 1m3: Mua 1m5 vải nếu muốn may quần vừa vặn.Khổ vải 1m5, 1m6: Mua 1m1 vải là phù hợp. Nếu muốn chiều dài quần ngắn hơn 85cm chỉ cần mua khoảng 1m vải.</strong></p><h4><strong>1.2.3. May áo sơ mi nam cần bao nhiêu mét vải?</strong></h4><p><strong>Hiện nay, để biết may áo sơ mi nam cần bao nhiêu vải, các nhà may, xưởng may thưởng sử dụng chủ yếu bảng thông số theo chiều cao dưới đây để biết cách tính vải may quần áo.&nbsp;</strong></p><p><strong>Ngoài cách tính vải dựa trên chiều cao, để biết may áo sơ mi nam cần bao nhiêu mét vải còn phụ thuộc vào nhiều yếu tố như kiểu dáng áo mong muốn, chất liệu may áo cũng như tay nghề và kinh nghiệm của thợ may.&nbsp;</strong></p>', 1, CAST(N'2024-07-10T00:00:00.000' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (10, 1, N'Hihi', N'<p>Haha</p>', 0, CAST(N'2025-03-09T11:17:30.107' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (11, 1, N'Thông tin lãi suất cho vay bình quân của Vietcombank', N'<figure class="image"><img style="aspect-ratio:3333/2500;" src="http://localhost:8080/Namcombank/assets/img/newsImage/Thong bao lai suat 2025 thang 2_V.webp" width="3333" height="2500"></figure>', 1, CAST(N'2025-03-09T14:59:46.187' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (21, 3, N'Lalala', N'<p>KKK</p>', 0, CAST(N'2025-03-09T16:44:49.513' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (22, 58, N'qwerty', N'<p>qwerty</p>', 0, CAST(N'2025-03-09T16:47:26.207' AS DateTime))
INSERT [dbo].[News] ([news_id], [staff_id], [title], [description], [status], [updateDate]) VALUES (26, 61, N'Cảnh báo hình thức lừa đảo tài chính qua mạng xã hội', N'<p>Kính gửi Quý khách,</p><p>&nbsp;</p><p>Trong thời đại công nghệ số, mạng xã hội trở nên phổ biến tại Việt Nam và đem lại nhiều lợi ích trong công việc cũng như cuộc sống. Bên cạnh đó, lợi dụng sự thuận tiện trong hoạt động tương tác trên mạng xã hội, các đối tượng có xu hướng thực hiện ngày càng nhiều hành vi giả mạo với thủ đoạn đa dạng nhằm chiếm đoạt thông tin và tài sản của nạn nhân.</p><p>&nbsp;</p><p>Techcombank xin thông tin đến quý khách hình thức lừa đảo tài chính đang phổ biến trên mạng xã hội với các bước thực hiện hành vi như sau:&nbsp;</p><h2><strong>&nbsp;1. Mạo danh ngân hàng trên mạng xã hội:</strong></h2><p>&nbsp;</p><figure class="image"><img style="aspect-ratio:883/534;" src="http://localhost:8080/Namcombank/assets/img/newsImage/Screenshot 2025-03-09 153343.png" width="883" height="534"></figure><h2><strong>&nbsp;2. Lừa đảo từ cài đặt ứng dụng giả mạo:</strong></h2><p>Hành vi lừa đảo thông qua cài đặt ứng dụng giả mạo hiện vẫn tiếp diễn và gây ra nhiều thiệt hại cho nạn nhân, do đó, Techcombank xin khuyến cáo một lần nữa đến quý khách để nâng cao cảnh giác với thủ đoạn lừa đảo phổ biến như sau:</p><figure class="image"><img style="aspect-ratio:887/634;" src="http://localhost:8080/Namcombank/assets/img/newsImage/Screenshot 2025-03-09 153445.png" width="887" height="634"></figure><p>Để phòng tránh rủi ro chiếm đoạt thông tin và tài sản, Techcombank khuyến cáo quý khách:</p><figure class="image"><img style="aspect-ratio:880/761;" src="http://localhost:8080/Namcombank/assets/img/newsImage/Screenshot 2025-03-09 153522.png" width="880" height="761"></figure><figure class="image"><img style="aspect-ratio:877/591;" src="http://localhost:8080/Namcombank/assets/img/newsImage/Screenshot 2025-03-09 153644.png" width="877" height="591"></figure><p>&nbsp;</p><p><i><strong>Ghi nhớ:</strong></i><strong> </strong><i><strong>Ngân hàng không bao giờ yêu cầu khách hàng cung cấp thông tin tài khoản ngân hàng, thông tin thẻ (mã CVV, số thẻ), mã OTP, mật khẩu... qua điện thoại, tin nhắn hay website, mạng xã hội.</strong></i></p><p>&nbsp;</p><p>Kính mong quý khách nâng cao cảnh giác để bảo vệ thông tin, tài sản cá nhân.</p><p>Chân thành cảm ơn sự hợp tác và đồng hành của quý khách!</p><p>&nbsp;</p><p>Trân trọng,</p><p><strong>Techcombank</strong></p><p><strong>Ngân hàng Thương mại cổ phần Kỹ thương Việt Nam.</strong></p>', 1, CAST(N'2025-03-10T08:54:03.467' AS DateTime))
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
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 5)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 7)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 8)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 15)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 16)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 17)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (2, 21)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 1)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 2)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 3)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 4)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 5)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 15)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 16)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 17)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (3, 21)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 1)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 2)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 3)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 4)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 5)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 15)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 16)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 17)
INSERT [dbo].[RoleFeatures] ([role_id], [feature_id]) VALUES (4, 21)
GO
INSERT [dbo].[Roles] ([role_id], [role_name]) VALUES (1, N'Administrator')
INSERT [dbo].[Roles] ([role_id], [role_name]) VALUES (2, N'Staff')
INSERT [dbo].[Roles] ([role_id], [role_name]) VALUES (3, N'Head Of Staff')
INSERT [dbo].[Roles] ([role_id], [role_name]) VALUES (4, N'Accountant')
GO
SET IDENTITY_INSERT [dbo].[Staff] ON 

INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (1, 2, N'Nguyen Van Giang', N'giangnv', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 1, N'tqtolympia@gmail.com', CAST(N'2025-02-24' AS Date), 1, N'0123456789', N'042204001158', N'123 Updated Street', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (2, 2, N'Tran Thi Anh', N'anhtt', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 1, N'tqtolympia@gmail.com', CAST(N'1990-10-10' AS Date), 0, N'0987654322', N'556677889', N'123 Đường Mới, Hà Nội', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (3, 3, N'Nguyen Van Hoang', N'hoangnv', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 1, N'tqtolympia@gmail.com', CAST(N'1982-07-20' AS Date), 1, N'0987654328', N'042204007391', N'789 Street, Hanoi', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (26, 4, N'Doan Vinh', N'hungdoan', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 0, N'hungdv@gmail.com', CAST(N'2024-07-11' AS Date), 1, N'0816610259', N'042204001159', N'Ha Noi', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (33, 2, N'Doan Vinh', N'Hungdoan1308', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 0, N'giang__@gmail.com', CAST(N'2024-11-08' AS Date), 1, N'0913352377', N'042204001190', N'Ha Noi', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (39, 4, N'hungdv123', N'ABCabc123', N'OwWItAcFpjf4LE4wsJhZ2OR55AE=', 0, N'hungd@gmail.com', CAST(N'2025-02-13' AS Date), 1, N'0816610258', N'042204001158', N'vietnam', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (46, 1, N'Doan Vinh', N'bvcBVC123', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 1, N'tqtolympia@gmail.com', CAST(N'2025-02-13' AS Date), 1, N'0816610238', N'042204001100', N'vietnam', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (48, 2, N'Hưng Đoàn', N'Abc123456', N'tedO67WLRTVYGEWMVpY5dsr6ybo=', 0, N'hungdvd@gmail.com', CAST(N'2025-02-12' AS Date), 1, N'0816610243', N'042204001156', N'vietnam', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (54, 2, N'Hưng Đoàn', N'chieu123', N'LM0n4tvr/ab0/AOKQXneOgvVz3Q=', 0, N'huyenmyn2004@gmail.com', CAST(N'2025-02-14' AS Date), 1, N'0816610275', N'042204001174', N'Ha Noi', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (58, 4, N'Trần Đức Anh', N'anhtd', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 0, N'truongtqhe186765@gmail.com', CAST(N'2025-03-08' AS Date), 1, N'0159753684', N'012345678910', N'Vietnam', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (60, 1, N'Đinh Xuân Dương', N'duongdx', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 1, N'truongtqhe186765@gmail.com', CAST(N'2025-03-08' AS Date), 1, N'0159753685', N'012345678911', N'Vietnam', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (61, 1, N'Role Nhân Viên', N'rolenhanvien', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 1, N'truongtqhe186765@gmail.com', CAST(N'2025-03-08' AS Date), 1, N'0123654789', N'011546464640', N'Vietnam', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (62, 5, N'Role Trưởng Phòng', N'roletruongphong', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 1, N'truongtqhe186765@gmail.com', CAST(N'2025-03-08' AS Date), 1, N'0987654330', N'012345678912', N'Vietnam', NULL)
INSERT [dbo].[Staff] ([staff_id], [department_id], [fullname], [username], [password], [active], [email], [dob], [gender], [phonenumber], [citizen_identification_card], [address], [avatar]) VALUES (63, 3, N'Role Kế Toán', N'roleketoan', N'0AK22igU+8BSKRQwWDGb1Jwz3rQ=', 1, N'truongtqhe186765@gmail.com', CAST(N'2025-03-07' AS Date), 1, N'0987654329', N'012345678900', N'Vietnam', NULL)
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
