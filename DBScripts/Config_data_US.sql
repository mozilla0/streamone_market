GO
IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES
				 WHERE TABLE_SCHEMA = 'dbo'  
                 and TABLE_NAME = 'configs'))
		BEGIN
				
				 Declare @CountRows as int
				 select @CountRows =  count(*) from configs
				 if(@CountRows=0)
				    begin
						SET IDENTITY_INSERT [dbo].[Configs] ON 

						INSERT [dbo].[Configs] ([Id], [Key], [Value], [Type]) VALUES (7, N'client_secret', N'abcd', N'Auth')
						INSERT [dbo].[Configs] ([Id], [Key], [Value], [Type]) VALUES (8, N'TokenOAuth', N'https://sso.techdata.com/as/token.oauth2', N'Auth')
						INSERT [dbo].[Configs] ([Id], [Key], [Value], [Type]) VALUES (9, N'client_id', N'abcd', N'Auth')
						INSERT [dbo].[Configs] ([Id], [Key], [Value], [Type]) VALUES (10, N'SOIN', N'abcd', N'Auth')
						INSERT [dbo].[Configs] ([Id], [Key], [Value], [Type]) VALUES (11, N'grant_type', N'client_credentials', N'Auth')
						INSERT [dbo].[Configs] ([Id], [Key], [Value], [Type]) VALUES (12, N'CustomerSearchURL', N'https://partnerapi.tdstreamone.com/endCustomer/search', N'API URL')
						INSERT [dbo].[Configs] ([Id], [Key], [Value], [Type]) VALUES (13, N'OrderSearchUrl', N'https://partnerapi.tdstreamone.com/order/search', N'API URL')
						INSERT [dbo].[Configs] ([Id], [Key], [Value], [Type]) VALUES (14, N'OrderModifyUrl', N'https://partnerapi.tdstreamone.com/order/', N'API URL')
						INSERT [dbo].[Configs] ([Id], [Key], [Value], [Type]) VALUES (15, N'OrderDetailUrl', N'https://partnerapi.tdstreamone.com/order/details/', N'API URL')
						INSERT [dbo].[Configs] ([Id], [Key], [Value], [Type]) VALUES (16, N'ModifyAddOnUrl', N'https://partnerapi.tdstreamone.com/order/addOns', N'API URL')
						INSERT [dbo].[Configs] ([Id], [Key], [Value], [Type]) VALUES (17, N'ResellerId', N'abcd', N'Reseller Info')
						INSERT [dbo].[Configs] ([Id], [Key], [Value], [Type]) VALUES (18, N'VendorListUrl', N'https://partnerapi.tdstreamone.com/catalog/vendors', N'API URL')
						INSERT [dbo].[Configs] ([Id], [Key], [Value], [Type]) VALUES (19, N'VendorCatalogSearchUrl', N'https://partnerapi.tdstreamone.com/catalog/search', N'API URL')
						INSERT [dbo].[Configs] ([Id], [Key], [Value], [Type]) VALUES (21, N'ResellerName', N'Tech Data 2', N'Reseller Info')
						INSERT [dbo].[Configs] ([Id], [Key], [Value], [Type]) VALUES (22, N'ApplicationName', N'Customer Portal SDK - StreamOne', N'Reseller Info')
						INSERT [dbo].[Configs] ([Id], [Key], [Value], [Type]) VALUES (23, N'AllowedResellers', N'test@test.com', N'Reseller Info')
						INSERT [dbo].[Configs] ([Id], [Key], [Value], [Type]) VALUES (24, N'AppUrl', N'Your-Azure-Url', N'Reseller Info')
						INSERT [dbo].[Configs] ([Id], [Key], [Value], [Type]) VALUES (25, N'SubscriptionSearchUrl', N'https://partnerapi.tdstreamone.com/order/subscriptions/', N'API URL')
						
						update configs set type = 'Reseller Info'
						where id = '22'
						SET IDENTITY_INSERT [dbo].[Configs] OFF
				    end
					
				 else
					begin
						SET IDENTITY_INSERT [dbo].[Configs] ON 
						update configs set type = 'Reseller Info'
						where id = '22'
						SET IDENTITY_INSERT [dbo].[Configs] OFF
					end

		END

