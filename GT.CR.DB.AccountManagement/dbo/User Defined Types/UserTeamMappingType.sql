CREATE TYPE [dbo].[UserTeamMappingType] AS TABLE (
    [LocationCode]   VARCHAR (MAX) NULL,
    [TeamCode]       VARCHAR (15)  NULL,
    [UUID]           VARCHAR (15)  NULL,
    [ParentUserUUID] VARCHAR (15)  NULL);

