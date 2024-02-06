-- Crear la tabla BaseEntity
CREATE TABLE BaseEntity (
    Id INT PRIMARY KEY,
    StatusBase BIT NOT NULL DEFAULT 1
);

-- Crear la tabla MovieEntity
CREATE TABLE MovieEntity (
    Id INT PRIMARY KEY,
    NameMovie NVARCHAR(100) NOT NULL,
    Genre INT NOT NULL,
    AllowedAge SMALLINT NOT NULL,
    LengthMinutes SMALLINT NOT NULL,
    CONSTRAINT FK_MovieEntity_BaseEntity FOREIGN KEY (Id) REFERENCES BaseEntity(Id)
);

-- Crear la tabla RoomEntity
CREATE TABLE RoomEntity (
    Id INT PRIMARY KEY,
    NameRoom NVARCHAR(50) NOT NULL,
    Number SMALLINT NOT NULL,
    CONSTRAINT FK_RoomEntity_BaseEntity FOREIGN KEY (Id) REFERENCES BaseEntity(Id)
);

-- Crear la tabla SeatEntity
CREATE TABLE SeatEntity (
    Id INT PRIMARY KEY,
    Number SMALLINT NOT NULL,
    RowNumber SMALLINT NOT NULL,
    RoomId INT,
    IsActive BIT NOT NULL DEFAULT 1,  -- Columna para indicar si la butaca está activa (1) o no (0)
    CONSTRAINT FK_SeatEntity_RoomEntity FOREIGN KEY (RoomId) REFERENCES RoomEntity(Id),
    CONSTRAINT FK_SeatEntity_BaseEntity FOREIGN KEY (Id) REFERENCES BaseEntity(Id)
);

-- Agregar la columna IsActive a la tabla SeatEntity
ALTER TABLE SeatEntity
ADD IsActive BIT NOT NULL DEFAULT 1;

-- Crear la tabla CustomerEntity
CREATE TABLE CustomerEntity (
    Id INT PRIMARY KEY,
    DocumentNumber NVARCHAR(20) UNIQUE NOT NULL,
    NameCustomer NVARCHAR(30) NOT NULL,
    Lastname NVARCHAR(30) NOT NULL,
    Age SMALLINT NOT NULL,
    PhoneNumber NVARCHAR(20),
    Email NVARCHAR(100),
    CONSTRAINT FK_CustomerEntity_BaseEntity FOREIGN KEY (Id) REFERENCES BaseEntity(Id)
);

-- Crear la tabla MovieGenreEnum
CREATE TABLE MovieGenreEnum (
    Id INT PRIMARY KEY,
    GenreName NVARCHAR(20) NOT NULL
);

-- Insertar valores en la tabla MovieGenreEnum
INSERT INTO MovieGenreEnum (Id, GenreName) VALUES 
    (0, 'ACTION'),
    (1, 'ADVENTURE'),
    (2, 'COMEDY'),
    (3, 'DRAMA'),
    (4, 'FANTASY'),
    (5, 'HORROR'),
    (6, 'MUSICALS'),
    (7, 'MYSTERY'),
    (8, 'ROMANCE'),
    (9, 'SCIENCE_FICTION'),
    (10, 'SPORTS'),
    (11, 'THRILLER'),
    (12, 'WESTERN');

-- Crear la tabla BillboardEntity
CREATE TABLE BillboardEntity (
    Id INT PRIMARY KEY,
    DateBillboard DATE NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    MovieId INT,
    RoomId INT,
    CONSTRAINT FK_BillboardEntity_MovieEntity FOREIGN KEY (MovieId) REFERENCES MovieEntity(Id),
    CONSTRAINT FK_BillboardEntity_RoomEntity FOREIGN KEY (RoomId) REFERENCES RoomEntity(Id),
    CONSTRAINT FK_BillboardEntity_BaseEntity FOREIGN KEY (Id) REFERENCES BaseEntity(Id)
);

-- Crear la tabla BookingEntity
CREATE TABLE BookingEntity (
    Id INT PRIMARY KEY,
    DateBooking DATE NOT NULL,
    CustomerId INT,
    SeatId INT,
    BillboardId INT,
    CONSTRAINT FK_BookingEntity_CustomerEntity FOREIGN KEY (CustomerId) REFERENCES CustomerEntity(Id),
    CONSTRAINT FK_BookingEntity_SeatEntity FOREIGN KEY (SeatId) REFERENCES SeatEntity(Id),
    CONSTRAINT FK_BookingEntity_BillboardEntity FOREIGN KEY (BillboardId) REFERENCES BillboardEntity(Id),
    CONSTRAINT FK_BookingEntity_BaseEntity FOREIGN KEY (Id) REFERENCES BaseEntity(Id)
);
-- Repositorio(respositorio base de todas las entidades proporciona chapter)
--A))
-- Definir las fechas de inicio y fin del rango
DECLARE @StartDate DATE = '2024-01-01';
DECLARE @EndDate DATE = '2024-12-31';

-- Consulta para obtener las reservas de películas de terror en el rango de fechas
SELECT 
    BookingEntity.Id AS ReservationId,
    CustomerEntity.NameCustomer AS CustomerName,
    CustomerEntity.Lastname AS CustomerLastname,
    MovieEntity.NameMovie AS MovieName,
    BillboardEntity.DateBillboard AS ProjectionDate,
    BillboardEntity.StartTime AS StartTime,
    BillboardEntity.EndTime AS EndTime
FROM 
    BookingEntity
JOIN 
    CustomerEntity ON BookingEntity.CustomerId = CustomerEntity.Id
JOIN 
    SeatEntity ON BookingEntity.SeatId = SeatEntity.Id
JOIN 
    BillboardEntity ON BookingEntity.BillboardId = BillboardEntity.Id
JOIN 
    MovieEntity ON BillboardEntity.MovieId = MovieEntity.Id
WHERE 
    MovieEntity.Genre = (SELECT Id FROM MovieGenreEnum WHERE GenreName = 'HORROR')
    AND BillboardEntity.DateBillboard BETWEEN @StartDate AND @EndDate;

--B))
	-- Obtener el número de butacas disponibles y ocupadas por sala en la cartelera del día actual
DECLARE @CurrentDate DATE = GETDATE();

SELECT
    RoomEntity.NameRoom AS RoomName,
    COUNT(SeatEntity.Id) AS TotalSeats,
    COUNT(CASE WHEN BookingEntity.Id IS NOT NULL THEN 1 END) AS OccupiedSeats,
    COUNT(CASE WHEN BookingEntity.Id IS NULL THEN 1 END) AS AvailableSeats
FROM
    RoomEntity
LEFT JOIN
    SeatEntity ON RoomEntity.Id = SeatEntity.RoomId
LEFT JOIN
    BookingEntity ON SeatEntity.Id = BookingEntity.SeatId
LEFT JOIN
    BillboardEntity ON BookingEntity.BillboardId = BillboardEntity.Id
WHERE
    BillboardEntity.DateBillboard = @CurrentDate
GROUP BY
    RoomEntity.Id, RoomEntity.NameRoom;

--3))
-- Definir el procedimiento almacenado para inhabilitar butaca y cancelar reserva
CREATE PROCEDURE InhabilitarButacaYCancelarReserva
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