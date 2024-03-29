USE [CINE]
GO
/****** Object:  Table [dbo].[BaseEntity]    Script Date: 5/2/2024 22:52:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BaseEntity](
	[Id] [int] NOT NULL,
	[Status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillboardEntity]    Script Date: 5/2/2024 22:52:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillboardEntity](
	[Id] [int] NOT NULL,
	[DateBillboard] [date] NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
	[MovieId] [int] NULL,
	[RoomId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookingEntity]    Script Date: 5/2/2024 22:52:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookingEntity](
	[Id] [int] NOT NULL,
	[DateBooking] [date] NOT NULL,
	[CustomerId] [int] NULL,
	[SeatId] [int] NULL,
	[BillboardId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerEntity]    Script Date: 5/2/2024 22:52:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerEntity](
	[Id] [int] NOT NULL,
	[DocumentNumber] [nvarchar](20) NOT NULL,
	[NameCustomer] [nvarchar](30) NOT NULL,
	[Lastname] [nvarchar](30) NOT NULL,
	[Age] [smallint] NOT NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[DocumentNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovieEntity]    Script Date: 5/2/2024 22:52:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieEntity](
	[Id] [int] NOT NULL,
	[NameMovie] [nvarchar](100) NOT NULL,
	[Genre] [int] NOT NULL,
	[AllowedAge] [smallint] NOT NULL,
	[LengthMinutes] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovieGenreEnum]    Script Date: 5/2/2024 22:52:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieGenreEnum](
	[Id] [int] NOT NULL,
	[GenreName] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoomEntity]    Script Date: 5/2/2024 22:52:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomEntity](
	[Id] [int] NOT NULL,
	[NameRoom] [nvarchar](50) NOT NULL,
	[Number] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SeatEntity]    Script Date: 5/2/2024 22:52:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SeatEntity](
	[Id] [int] NOT NULL,
	[Number] [smallint] NOT NULL,
	[RowNumber] [smallint] NOT NULL,
	[RoomId] [int] NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BaseEntity] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[SeatEntity] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[BillboardEntity]  WITH CHECK ADD  CONSTRAINT [FK_BillboardEntity_BaseEntity] FOREIGN KEY([Id])
REFERENCES [dbo].[BaseEntity] ([Id])
GO
ALTER TABLE [dbo].[BillboardEntity] CHECK CONSTRAINT [FK_BillboardEntity_BaseEntity]
GO
ALTER TABLE [dbo].[BillboardEntity]  WITH CHECK ADD  CONSTRAINT [FK_BillboardEntity_MovieEntity] FOREIGN KEY([MovieId])
REFERENCES [dbo].[MovieEntity] ([Id])
GO
ALTER TABLE [dbo].[BillboardEntity] CHECK CONSTRAINT [FK_BillboardEntity_MovieEntity]
GO
ALTER TABLE [dbo].[BillboardEntity]  WITH CHECK ADD  CONSTRAINT [FK_BillboardEntity_RoomEntity] FOREIGN KEY([RoomId])
REFERENCES [dbo].[RoomEntity] ([Id])
GO
ALTER TABLE [dbo].[BillboardEntity] CHECK CONSTRAINT [FK_BillboardEntity_RoomEntity]
GO
ALTER TABLE [dbo].[BookingEntity]  WITH CHECK ADD  CONSTRAINT [FK_BookingEntity_BaseEntity] FOREIGN KEY([Id])
REFERENCES [dbo].[BaseEntity] ([Id])
GO
ALTER TABLE [dbo].[BookingEntity] CHECK CONSTRAINT [FK_BookingEntity_BaseEntity]
GO
ALTER TABLE [dbo].[BookingEntity]  WITH CHECK ADD  CONSTRAINT [FK_BookingEntity_BillboardEntity] FOREIGN KEY([BillboardId])
REFERENCES [dbo].[BillboardEntity] ([Id])
GO
ALTER TABLE [dbo].[BookingEntity] CHECK CONSTRAINT [FK_BookingEntity_BillboardEntity]
GO
ALTER TABLE [dbo].[BookingEntity]  WITH CHECK ADD  CONSTRAINT [FK_BookingEntity_CustomerEntity] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[CustomerEntity] ([Id])
GO
ALTER TABLE [dbo].[BookingEntity] CHECK CONSTRAINT [FK_BookingEntity_CustomerEntity]
GO
ALTER TABLE [dbo].[BookingEntity]  WITH CHECK ADD  CONSTRAINT [FK_BookingEntity_SeatEntity] FOREIGN KEY([SeatId])
REFERENCES [dbo].[SeatEntity] ([Id])
GO
ALTER TABLE [dbo].[BookingEntity] CHECK CONSTRAINT [FK_BookingEntity_SeatEntity]
GO
ALTER TABLE [dbo].[CustomerEntity]  WITH CHECK ADD  CONSTRAINT [FK_CustomerEntity_BaseEntity] FOREIGN KEY([Id])
REFERENCES [dbo].[BaseEntity] ([Id])
GO
ALTER TABLE [dbo].[CustomerEntity] CHECK CONSTRAINT [FK_CustomerEntity_BaseEntity]
GO
ALTER TABLE [dbo].[MovieEntity]  WITH CHECK ADD  CONSTRAINT [FK_MovieEntity_BaseEntity] FOREIGN KEY([Id])
REFERENCES [dbo].[BaseEntity] ([Id])
GO
ALTER TABLE [dbo].[MovieEntity] CHECK CONSTRAINT [FK_MovieEntity_BaseEntity]
GO
ALTER TABLE [dbo].[RoomEntity]  WITH CHECK ADD  CONSTRAINT [FK_RoomEntity_BaseEntity] FOREIGN KEY([Id])
REFERENCES [dbo].[BaseEntity] ([Id])
GO
ALTER TABLE [dbo].[RoomEntity] CHECK CONSTRAINT [FK_RoomEntity_BaseEntity]
GO
ALTER TABLE [dbo].[SeatEntity]  WITH CHECK ADD  CONSTRAINT [FK_SeatEntity_BaseEntity] FOREIGN KEY([Id])
REFERENCES [dbo].[BaseEntity] ([Id])
GO
ALTER TABLE [dbo].[SeatEntity] CHECK CONSTRAINT [FK_SeatEntity_BaseEntity]
GO
ALTER TABLE [dbo].[SeatEntity]  WITH CHECK ADD  CONSTRAINT [FK_SeatEntity_RoomEntity] FOREIGN KEY([RoomId])
REFERENCES [dbo].[RoomEntity] ([Id])
GO
ALTER TABLE [dbo].[SeatEntity] CHECK CONSTRAINT [FK_SeatEntity_RoomEntity]
GO
/****** Object:  StoredProcedure [dbo].[InhabilitarButacaYCancelarReserva]    Script Date: 5/2/2024 22:52:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InhabilitarButacaYCancelarReserva]
    @IdButaca INT,
    @IdReserva INT
AS
BEGIN
    -- Iniciar la transacción
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Inhabilitar la butaca (actualizar el estado, por ejemplo)
        UPDATE SeatEntity
        SET IsActive = 0
        WHERE Id = @IdButaca;

        -- Cancelar la reserva (eliminar la reserva de la base de datos)
        DELETE FROM BookingEntity
        WHERE Id = @IdReserva;

        -- Confirmar la transacción si ambas operaciones son exitosas
        COMMIT;
    END TRY
    BEGIN CATCH
        -- Revertir la transacción en caso de error
        ROLLBACK;
        
        -- Puedes manejar el error de alguna manera (registro, lanzar una excepción, etc.)
        THROW;
    END CATCH;
END;
GO
