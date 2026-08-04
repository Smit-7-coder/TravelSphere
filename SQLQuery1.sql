CREATE DATABASE TravelSphereDB;
GO

USE TravelSphereDB;
GO

CREATE TABLE Users
(
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Phone VARCHAR(15) NULL,
    Address VARCHAR(300) NULL,
    ProfileImage VARCHAR(255) NULL,
    Role VARCHAR(20) NOT NULL DEFAULT 'Traveller',
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE Destinations
(
    DestinationId INT IDENTITY(1,1) PRIMARY KEY,
    DestinationName VARCHAR(100) NOT NULL,
    State VARCHAR(100) NOT NULL,
    Description VARCHAR(1000) NULL,
    DestinationType VARCHAR(50) NULL,
    Image VARCHAR(255) NULL,
    IsPopular BIT NOT NULL DEFAULT 0,
    IsActive BIT NOT NULL DEFAULT 1
);

CREATE TABLE Packages
(
    PackageId INT IDENTITY(1,1) PRIMARY KEY,

    DestinationId INT NOT NULL,

    PackageName VARCHAR(150) NOT NULL,
    Description VARCHAR(1500) NULL,

    DurationDays INT NOT NULL,

    AdultPrice DECIMAL(10,2) NOT NULL,
    ChildPrice DECIMAL(10,2) NULL,

    HotelName VARCHAR(150) NULL,
    RoomType VARCHAR(100) NULL,

    TransportType VARCHAR(50) NULL,
    MealsIncluded VARCHAR(200) NULL,
    BestSeason VARCHAR(100) NULL,

    PackageImage VARCHAR(255) NULL,

    IsPopular BIT NOT NULL DEFAULT 0,
    IsActive BIT NOT NULL DEFAULT 1,

    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),

    FOREIGN KEY (DestinationId)
        REFERENCES Destinations(DestinationId)
);

CREATE TABLE PackageItinerary
(
    ItineraryId INT IDENTITY(1,1) PRIMARY KEY,

    PackageId INT NOT NULL,

    DayNumber INT NOT NULL,
    Title VARCHAR(200) NOT NULL,
    Description VARCHAR(1000) NULL,

    FOREIGN KEY (PackageId)
        REFERENCES Packages(PackageId)
        ON DELETE CASCADE
);

CREATE TABLE Bookings
(
    BookingId INT IDENTITY(1,1) PRIMARY KEY,

    UserId INT NOT NULL,
    PackageId INT NOT NULL,

    BookingDate DATETIME NOT NULL DEFAULT GETDATE(),
    TravelDate DATE NOT NULL,

    NumberOfPersons INT NOT NULL,

    SpecialRequest VARCHAR(500) NULL,

    PackageAmount DECIMAL(10,2) NOT NULL,
    TaxAmount DECIMAL(10,2) NOT NULL DEFAULT 0,
    TotalAmount DECIMAL(10,2) NOT NULL,

    BookingStatus VARCHAR(30) NOT NULL DEFAULT 'Pending',
    PaymentStatus VARCHAR(30) NOT NULL DEFAULT 'Pending',

    FOREIGN KEY (UserId)
        REFERENCES Users(UserId),

    FOREIGN KEY (PackageId)
        REFERENCES Packages(PackageId)
);

CREATE TABLE BookingTravellers
(
    TravellerId INT IDENTITY(1,1) PRIMARY KEY,

    BookingId INT NOT NULL,

    TravellerName VARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    Gender VARCHAR(20) NULL,

    FOREIGN KEY (BookingId)
        REFERENCES Bookings(BookingId)
        ON DELETE CASCADE
);

CREATE TABLE BudgetPlans
(
    BudgetPlanId INT IDENTITY(1,1) PRIMARY KEY,

    UserId INT NOT NULL,

    NumberOfDays INT NOT NULL,
    NumberOfPeople INT NOT NULL,

    TravelType VARCHAR(30) NOT NULL,
    HotelType VARCHAR(50) NOT NULL,

    NumberOfRooms INT NOT NULL,

    PaidActivities BIT NOT NULL DEFAULT 0,

    MinDistance DECIMAL(10,2) NOT NULL,
    MaxDistance DECIMAL(10,2) NOT NULL,

    AccommodationCost DECIMAL(10,2) NULL,
    TravelCost DECIMAL(10,2) NULL,
    DiningCost DECIMAL(10,2) NULL,
    ActivitiesCost DECIMAL(10,2) NULL,

    EstimatedAmount DECIMAL(10,2) NULL,

    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),

    FOREIGN KEY (UserId)
        REFERENCES Users(UserId)
);

CREATE TABLE TravelCosts
(
    CostId INT IDENTITY(1,1) PRIMARY KEY,

    CostType VARCHAR(50) NOT NULL,
    OptionName VARCHAR(100) NOT NULL,

    Rate DECIMAL(10,2) NOT NULL,

    IsActive BIT NOT NULL DEFAULT 1
);

