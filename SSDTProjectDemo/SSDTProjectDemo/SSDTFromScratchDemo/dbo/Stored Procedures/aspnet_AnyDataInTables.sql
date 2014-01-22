CREATE PROCEDURE [dbo].[aspnet_AnyDataInTables]
@TablesToCheck INT
AS
BEGIN
    IF ((@TablesToCheck & 1) <> 0
        AND (EXISTS (SELECT name
                     FROM   sysobjects
                     WHERE  (name = N'vw_aspnet_MembershipUsers')
                            AND (type = 'V'))))
        BEGIN
            IF (EXISTS (SELECT TOP 1 UserId
                        FROM   dbo.aspnet_Membership))
                BEGIN
                    SELECT N'aspnet_Membership';
                    RETURN;
                END
        END
    IF ((@TablesToCheck & 2) <> 0
        AND (EXISTS (SELECT name
                     FROM   sysobjects
                     WHERE  (name = N'vw_aspnet_Roles')
                            AND (type = 'V'))))
        BEGIN
            IF (EXISTS (SELECT TOP 1 RoleId
                        FROM   dbo.aspnet_Roles))
                BEGIN
                    SELECT N'aspnet_Roles';
                    RETURN;
                END
        END
    IF ((@TablesToCheck & 16) <> 0
        AND (EXISTS (SELECT name
                     FROM   sysobjects
                     WHERE  (name = N'aspnet_WebEvent_LogEvent')
                            AND (type = 'P'))))
        BEGIN
            IF (EXISTS (SELECT TOP 1 *
                        FROM   dbo.aspnet_WebEvent_Events))
                BEGIN
                    SELECT N'aspnet_WebEvent_Events';
                    RETURN;
                END
        END
    IF ((@TablesToCheck & 1) <> 0
        AND (@TablesToCheck & 2) <> 0
        AND (@TablesToCheck & 4) <> 0
        AND (@TablesToCheck & 8) <> 0
        AND (@TablesToCheck & 32) <> 0
        AND (@TablesToCheck & 128) <> 0
        AND (@TablesToCheck & 256) <> 0
        AND (@TablesToCheck & 512) <> 0
        AND (@TablesToCheck & 1024) <> 0)
        BEGIN
            IF (EXISTS (SELECT TOP 1 UserId
                        FROM   dbo.aspnet_Users))
                BEGIN
                    SELECT N'aspnet_Users';
                    RETURN;
                END
            IF (EXISTS (SELECT TOP 1 ApplicationId
                        FROM   dbo.aspnet_Applications))
                BEGIN
                    SELECT N'aspnet_Applications';
                    RETURN;
                END
        END
END