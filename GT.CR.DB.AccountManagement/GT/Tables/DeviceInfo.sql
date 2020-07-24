CREATE TABLE [GT].[DeviceInfo] (
    [DeviceInfoID]  INT            IDENTITY (1, 1) NOT NULL,
    [UUID]          NVARCHAR (20)  NOT NULL,
    [DeviceDetails] NVARCHAR (150) NOT NULL,
    [LoginTime]     DATETIME       NOT NULL
);

