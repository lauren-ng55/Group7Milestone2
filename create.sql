PRAGMA foreign_keys = OFF;
 
DROP TABLE IF EXISTS event_room_assignment;
DROP TABLE IF EXISTS event;
DROP TABLE IF EXISTS host;
DROP TABLE IF EXISTS guest;
DROP TABLE IF EXISTS charge_allocation;
DROP TABLE IF EXISTS transaction_usage;
DROP TABLE IF EXISTS service_rate;
DROP TABLE IF EXISTS meeting_rate;
DROP TABLE IF EXISTS room_assignment;
DROP TABLE IF EXISTS reservation;
DROP TABLE IF EXISTS room_status;
DROP TABLE IF EXISTS card_swipe;
DROP TABLE IF EXISTS card_reader;
DROP TABLE IF EXISTS access_card;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS customer_message;
DROP TABLE IF EXISTS billing_party;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS room_bed;
DROP TABLE IF EXISTS bed_type;
DROP TABLE IF EXISTS room_adjacency;
DROP TABLE IF EXISTS adjacency;
DROP TABLE IF EXISTS room;
DROP TABLE IF EXISTS room_type;
DROP TABLE IF EXISTS floor;
DROP TABLE IF EXISTS wing;
DROP TABLE IF EXISTS building;
 
PRAGMA foreign_keys = ON;

-- Building
CREATE TABLE building (
    buildingId INTEGER PRIMARY KEY,
    buildingName TEXT NOT NULL
);

CREATE TABLE wing (
    wingId INTEGER PRIMARY KEY,
    buildingId INTEGER NOT NULL,
    wingName TEXT,
    poolProximity INTEGER, -- user types in 0 for no and 1 for yes
    parkingProximity INTEGER, -- user types in 0 for no and 1 for yes
    handicapAccessible INTEGER, -- user types in 0 for no and 1 for yes
    FOREIGN KEY (buildingId) REFERENCES building(buildingId)
);

CREATE TABLE floor (
    floorId INTEGER PRIMARY KEY,
    wingId INTEGER NOT NULL,
    floorNumber INTEGER NOT NULL,
    FOREIGN KEY (wingId) REFERENCES wing(wingId)
);

CREATE TABLE room_type (
    roomTypeId INTEGER PRIMARY KEY,
    typeName TEXT NOT NULL
);

CREATE TABLE room (
    roomId INTEGER PRIMARY KEY,
    roomName TEXT NOT NULL,
    roomTypeId INTEGER NOT NULL,
    floorId INTEGER,
    statusId INTEGER NOT NULL,
    smokingStatus INTEGER, -- user types in 0 for no and 1 for yes
    sleepingCapacity INTEGER, 
    seatingCapacity INTEGER, 
    hasToilet INTEGER, -- user types in 0 for no and 1 for yes
    extraSpace INTEGER, -- user types in 0 for no and 1 for yes
    sleepingRate REAL,
    FOREIGN KEY (statusId) REFERENCES room_status(statusId),
    FOREIGN KEY (roomTypeId) REFERENCES room_type(roomTypeId),
    FOREIGN KEY (floorId) REFERENCES floor(floorId)
);

CREATE TABLE adjacency (
    adjacencyId INTEGER PRIMARY KEY -- need help lol
);

CREATE TABLE room_adjacency (
    adjacencyId INTEGER NOT NULL,
    roomId INTEGER NOT NULL,
    PRIMARY KEY (adjacencyId, roomId),
    FOREIGN KEY (adjacencyId) REFERENCES adjacency(adjacencyId),
    FOREIGN KEY (roomId)      REFERENCES room(roomId)
);

CREATE TABLE bed_type (
    bedTypeId INTEGER PRIMARY KEY,
    typeName TEXT NOT NULL
);

CREATE TABLE room_bed (
    roomId INTEGER NOT NULL,
    bedTypeId INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    isTemporary INTEGER, -- user types in 0 for no and 1 for yes
    PRIMARY KEY (roomId, bedTypeId),
    FOREIGN KEY (roomId)    REFERENCES room(roomId),
    FOREIGN KEY (bedTypeId) REFERENCES bed_type(bedTypeId)
);

-- Customers, billing, staff and access cards
CREATE TABLE customer (
    customerId  INTEGER PRIMARY KEY,
    firstName TEXT NOT NULL,
    lastName TEXT NOT NULL,
    phone TEXT,
    email TEXT NOT NULL
);

CREATE TABLE billing_party (
    billingPartyId INTEGER PRIMARY KEY,
    customerId INTEGER, --do we need guestId here too?
    guestId INTEGER,
    authorizedRepresentative TEXT,
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
);

CREATE TABLE customer_message (
    messageId INTEGER PRIMARY KEY,
    customerId INTEGER NOT NULL,
    staffId INTEGER,
    messageText TEXT,
    messageDateTime DATETIME NOT NULL,
    isConfidential INTEGER,
    FOREIGN KEY (customerId) REFERENCES customer(customerId),
    FOREIGN KEY (staffId) REFERENCES staff(staffId)
);

CREATE TABLE staff (
    staffId INTEGER PRIMARY KEY,
    firstName TEXT NOT NULL,
    lastName TEXT NOT NULL,
    job TEXT
);

CREATE TABLE access_card (
    cardId INTEGER PRIMARY KEY,
    pin TEXT,
    issueDate DATE,
    customerId INTEGER,
    staffId INTEGER,
    FOREIGN KEY (customerId) REFERENCES customer(customerId),
    FOREIGN KEY (staffId) REFERENCES staff(staffId)
);

CREATE TABLE card_reader (
    cardReaderId INTEGER PRIMARY KEY,
    roomId INTEGER,
    FOREIGN KEY (roomId) REFERENCES room(roomId)
);

CREATE TABLE card_swipe (
    swipeId INTEGER PRIMARY KEY,
    swipeDateTime DATETIME NOT NULL,
    direction TEXT,
    cardId INTEGER NOT NULL,
    cardReaderId INTEGER NOT NULL,
    FOREIGN KEY (cardId) REFERENCES access_card(cardId),
    FOREIGN KEY (cardReaderId) REFERENCES card_reader(cardReaderId)
);

CREATE TABLE room_status (
    statusId INTEGER PRIMARY KEY,
    statusType TEXT NOT NULL);

CREATE TABLE reservation (
    reservationId INTEGER PRIMARY KEY,
    billingPartyId INTEGER NOT NULL,
    date DATE,
    reservationStatus TEXT,
    requestedStartDateTime DATETIME,
    requestedEndDateTime DATETIME,
    smokingPreference INTEGER,
    requestedBedType TEXT,
    requestedLocation TEXT,
    requestedProximities TEXT,
    FOREIGN KEY (billingPartyId) REFERENCES billing_party(billingPartyId)
);

CREATE TABLE room_assignment (
    assignmentId INTEGER PRIMARY KEY,
    reservationId INTEGER NOT NULL,
    roomId INTEGER NOT NULL,
    meetingRateId INTEGER,
    startDateTime DATETIME,
    endDateTime DATETIME,
    assignmentStatus TEXT, -- possibilities: Completed, In Progress, Scheduled
    numberNights INTEGER,
    FOREIGN KEY (reservationId) REFERENCES reservation(reservationId),
    FOREIGN KEY (roomId) REFERENCES room(roomId),
    FOREIGN KEY (meetingRateId) REFERENCES meeting_rate(meetingRateId)
);

CREATE TABLE meeting_rate (
    meetingRateId  INTEGER PRIMARY KEY,
    slot, TEXT UNIQUE,
    slotRate, REAL
);

CREATE TABLE service_rate (
    serviceRateId INTEGER PRIMARY KEY,
    serviceName TEXT NOT NULL,
    unitPrice REAL
);

CREATE TABLE transaction_usage (
    transactionId INTEGER PRIMARY KEY,
    serviceRateId INTEGER,
    quantity INTEGER,
    transactionCharge REAL NOT NULL,
    transactionDateTime TEXT NOT NULL,
    assignmentId INTEGER,
    FOREIGN KEY (serviceRateId)
        REFERENCES service_rate(serviceRateId),
    FOREIGN KEY (assignmentId)
        REFERENCES room_assignment(assignmentId)
);

CREATE TABLE charge_allocation (
    transactionId INTEGER NOT NULL,
    billingPartyId INTEGER NOT NULL,
    allocatedCharge REAL NOT NULL,
    PRIMARY KEY (transactionId, billingPartyId),
    FOREIGN KEY (transactionId) REFERENCES transaction_usage(transactionId),
    FOREIGN KEY (billingPartyId) REFERENCES billing_party(billingPartyId)
);

CREATE TABLE event (
    eventId INTEGER PRIMARY KEY,
    eventName TEXT NOT NULL,
    hostId INTEGER,
    estimatedAttendanceTotal INTEGER,
    estimatedGuestCount INTEGER,
    FOREIGN KEY (hostId) REFERENCES host(hostId)
);

CREATE TABLE guest (
    guestId INTEGER NOT NULL,
    eventId INTEGER NOT NULL,
    firstName TEXT NOT NULL,
    lastName TEXT NOT NULL,
    PRIMARY KEY (guestId),
    FOREIGN KEY (eventId) REFERENCES event(eventId)
);

CREATE TABLE host (
    hostId INTEGER PRIMARY KEY,
    guestId INTEGER,
    billingPartyId INTEGER,
    FOREIGN KEY (guestId) REFERENCES guest(guestId), 
    FOREIGN KEY (billingPartyId) REFERENCES billing_party(billingPartyId)
);

CREATE TABLE event_room_assignment (
    eventId INTEGER NOT NULL,
    assignmentId INTEGER NOT NULL,
    PRIMARY KEY (eventId, assignmentId),
    FOREIGN KEY (eventId) REFERENCES event(eventId),
    FOREIGN KEY (assignmentId)  REFERENCES room_assignment(assignmentId)
);

