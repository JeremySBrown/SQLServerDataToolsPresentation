DELETE [dbo].[InternetAddressTypes] 

SET IDENTITY_INSERT [dbo].[InternetAddressTypes] ON
INSERT INTO [dbo].[InternetAddressTypes] ([Id], [Description]) VALUES (1, N'Email')
INSERT INTO [dbo].[InternetAddressTypes] ([Id], [Description]) VALUES (2, N'Website')
INSERT INTO [dbo].[InternetAddressTypes] ([Id], [Description]) VALUES (3, N'Blog')
INSERT INTO [dbo].[InternetAddressTypes] ([Id], [Description]) VALUES (4, N'Twitter')
INSERT INTO [dbo].[InternetAddressTypes] ([Id], [Description]) VALUES (5, N'Facebook')
INSERT INTO [dbo].[InternetAddressTypes] ([Id], [Description]) VALUES (6, N'LinkedIn')
SET IDENTITY_INSERT [dbo].[InternetAddressTypes] OFF