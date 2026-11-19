INSERT INTO building (buildingId, buildingName) VALUES 
(1, 'Astoria'),
(2, 'Valencia');

-- each building has 2 wings
INSERT INTO wing (wingId, buildingId, wingName, poolProximity, parkingProximity, handicapAccessible) VALUES
(1, 1, 'Astoria West', 0, 1, 1),
(2, 1, 'Astoria East', 1, 1, 0),
(3, 2, 'Valencia West', 1, 1, 1),
(4, 2, 'Valencia East', 1, 1, 1);

INSERT INTO floor (floorId, wingId, floorNumber) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 2, 1),
(5, 2, 2),
(6, 2, 3),
(7, 3, 1),
(8, 3, 2),
(9, 3, 3),
(10, 4, 1),
(11, 4, 2),
(12, 4, 3);

INSERT INTO room_type (roomTypeId, typeName) VALUES
(1, 'sleeping'),  
(2, 'meeting'),
(3, 'mixed'); 

INSERT INTO room_status(statusId, statusType) VALUES  
(1, 'vacant'),
(2, 'occupied'), 
(3, 'repair');

INSERT INTO bed_type (bedTypeId, typeName) VALUES
(1, 'single'),
(2, 'double'),
(3, 'roll-away'),
(4, 'queen'),
(5, 'king'),
(6, 'extra long');

INSERT INTO adjacency (adjacencyId) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);

INSERT INTO meeting_rate(meetingRateId, slot, slotRate) VALUES
(1, 'breakfast', 500), -- 8-11
(2, 'morning', 250), -- 8-11
(3, 'lunch', 500), -- 12-15 (12-3)
(4, 'afternoon', 250), -- 12-15 (12-3)
(5, 'supper', 500), -- 17-20 (5-8)
(6, 'evening', 250), -- 17-20 (5-8)
(7, 'night', 250); -- 21-24 (9pm-midnight)

INSERT INTO service_rate(serviceRateId, serviceName, unitPrice) VALUES
(1, 'telephone calls', 5.00),
(2, 'restaurant', NULL), --can be null, then specified in transaction_usage table
(3, 'time extension', 35.00),
(4,'photocopying', 20.00),
(5, 'equipment rental', 40.00),
(6, 'printing', 15.00),
(7, 'retail shops', NULL),
(8, 'masseuse', 75.00),
(9, 'racquetball', 100.00),
(10, 'room service', NULL);

INSERT INTO customer (customerId, firstName, lastName, phone, email) VALUES
(1, 'John', 'Doe', '222-367-8690', 'johndoe@gmail.com'),
(2, 'Amy', 'Yang', '367-212-5487', 'amyyang@gmail.com'),
(3, 'Grayson', 'Taylor', '212-555-0143', 'graysontaylor@gmail.com'),  
(4, 'Linda', 'Park', '646-555-1078', 'lindapark@yahoo.com'),
(5, 'Carlos', 'Mendes', '917-235-2312', 'carlosmendes@outlook.com'),
(6, 'Fatima', 'Ali', '718-525-4490', 'fatimaali@gmail.com'),
(7, 'Kevin', 'Brooks', '347-987-1034', 'kevinbrooks@gmail.com'),
(8, 'Natalie', 'Ford', '202-992-9867', 'natalieford@hotmail.com'),
(9, 'Hiroshi', 'Sato', '415-471-0121', 'hiroshisato@gmail.com'),
(10, 'Rachel', 'Cohen', '310-105-2985', 'rachelcohen@gmail.com'),
(11, 'Marcus', 'Green', '312-028-3756', 'marcusgreen@outlook.com'),
(12, 'Elena', 'Petrova', '617-338-7409', 'elenapetrova@gmail.com'),
(13, 'Samuel', 'Adeyemi', '305-234-2072', 'samueladeyemi@yahoo.com'),
(14, 'Julia', 'Fischer', '206-519-0138', 'juliafischer@gmail.com'),
(15, 'Benjamin', 'Lau', '852-089-7794', 'benjaminlau@gmail.com');

INSERT INTO staff (staffId, firstName, lastName, job) VALUES
(1, 'Mary', 'Spitzer', 'receptionist'),
(2, 'Maria', 'Gomez', 'housekeeper'),
(3, 'Tom', 'Becker', 'housekeeper'),
(4, 'Aisha', 'Bello', 'housekeeper'),
(5, 'Frank', 'Russo', 'maintenance technician'),
(6, 'Derek', 'Owens', 'maintenance technician'),
(7, 'Sarah', 'Lindqvist','reservations agent'),
(8, 'Victor', 'Huang', 'event coordinator'),
(9, 'Nadia', 'Karim', 'concierge'),
(10, 'Paul', 'Whitman', 'front office manager');

INSERT INTO event(eventId, eventName, hostId, estimatedAttendanceTotal) VALUES
(1, 'Roberts 90th Birthday', 1, 100),
(2, 'Medical Professionals Conference 2025', 2, 750),
(3, 'Rossi Family Wellness Retreat', 3, 150), 
(4, 'NYU Alumni Christmas Party', 4, 400);

INSERT INTO guest (guestId, eventId, firstName, lastName) VALUES
(1, 1, 'Robert', 'Smith'), -- event 1 host
(2, 1, 'Karen', 'Lee'),
(3, 1, 'Michael', 'Chen'),
(4, 1, 'Priya', 'Patel'),
(5, 1, 'David', 'Johnson'),
(6, 1, 'Sofia', 'Martinez'),
(7, 2, 'James', 'Wong'),
(8, 2, 'Emily', 'Davis'),
(9, 2, 'Ahmed', 'Hassan'),
(10, 2, 'Olivia', 'Brown'),
(11, 2, 'Daniel', 'Kim'),
(12, 3, 'Grace', 'Rossi'),  -- event 3 billing party
(13, 3, 'Lucas', 'Rossi'),  -- event 3 host
(14, 3, 'Hannah', 'Müller'),
(15, 3, 'Ethan', 'Nguyen'),
(16, 4, 'Isabella', 'Garcia'), 
(17, 4, 'Ryan', 'Connor'),
(18, 4, 'Mei', 'Tanaka'),
(19, 4, 'Thomas', 'Anderson'),
(20, 4, 'Chloe', 'Dubois'); -- event 4 host

INSERT INTO billing_party (billingPartyId, customerId, guestId, authorizedRepresentative) VALUES 
(1, 8, NULL, NULL),
(2, 3, NULL, NULL),  
(3, NULL, 12, NULL),  
(4, NULL, 9, NULL),
(5, 1, NULL, NULL),
(6, NULL, 7, NULL),  
(7, 14, NULL, NULL),
(8, 5, NULL, NULL),
(9, 10, NULL, NULL),
(10, NULL, 1, NULL),   
(11, 2, NULL, NULL),
(12, 15, NULL, NULL),
(13, 6, NULL, NULL),
(14, NULL, 16, NULL),  
(15, 9, NULL, NULL),
(16, 4, NULL, NULL),
(17, 13, NULL, NULL),
(18, NULL, 20, NULL),  
(19, 7, NULL, NULL),
(20, 12, NULL, NULL);

INSERT INTO host (hostId, guestId, billingPartyId) VALUES 
(1, 1, 10), 
(2, NULL, 2),
(3, 13, NULL),
(4, 20, 18);

INSERT INTO room (roomId, roomName, roomTypeId, floorId, statusId, smokingStatus, sleepingCapacity, seatingCapacity, hasToilet, 
extraSpace, sleepingRate) VALUES  
(1, 'AW101', 1, 1, 2, 0, 2, 0, 1, 1, 269.00), -- roomName is alphanumeric (A for Astoria, W for West wing, 1 as in floor, and 01 as in room)
(2, 'AW102', 1, 1, 1, 1, 3, 0, 1, 0, 209.00),
(3, 'AW103', 1, 1, 2, 0, 3, 0, 1, 1, 279.00),
(4, 'AW104', 1, 1, 2, 1, 2, 0, 1, 1, 259.00),
(5, 'AW105', 3, 1, 1, 0, 2, 2, 1, 0, 269.00),
(6, 'AW201', 1, 2, 2, 0, 2, 0, 1, 0, 189.00),
(7, 'AW202', 1, 2, 1, 0, 2, 0, 1, 0, 189.00),
(8, 'AW203', 1, 2, 2, 0, 4, 0, 1, 1, 229.00),
(9, 'AW204', 3, 2, 1, 0, 4, 4, 1, 1, 289.00),
(10, 'AW205', 3, 2, 2, 0, 4, 2, 1, 0, 199.00),
(11, 'AW301', 1, 3, 1, 1, 2, 0, 1, 0, 179.00),
(12, 'AW302', 1, 3, 2, 1, 2, 0, 1, 0, 179.00),
(13, 'AW303', 1, 3, 2, 0, 3, 0, 1, 1, 219.00),
(14, 'AW304', 1, 3, 1, 0, 2, 0, 1, 0, 189.00),
(15, 'AW305', 1, 3, 2, 0, 4, 0, 1, 1, 319.00),
(16, 'AE101', 1, 4, 2, 0, 2, 0, 1, 0, 299.00),
(17, 'AE102', 1, 4, 2, 0, 3, 0, 1, 0, 259.00),
(18, 'AE103', 3, 4, 2, 0, 2, 2, 1, 0, 249.00),
(19, 'AE104', 3, 4, 1, 0, 2, 3, 1, 0, 249.00),
(20, 'AE105', 3, 4, 1, 0, 3, 3, 1, 0, 179.00),
(21, 'AE201', 1, 5, 3, 0, 2, 0, 1, 0, 209.00),
(22, 'AE202', 1, 5, 2, 1, 2, 0, 1, 0, 209.00),
(23, 'AE203', 1, 5, 1, 0, 3, 0, 1, 1, 239.00),
(24, 'AE204', 3, 5, 2, 1, 4, 4, 1, 1, 339.00),
(25, 'AE205', 1, 5, 2, 1, 2, 0, 1, 0, 209.00),
(26, 'AE301', 1, 6, 1, 1, 2, 0, 1, 0, 219.00),
(27, 'AE302', 1, 6, 1, 1, 2, 0, 1, 0, 219.00),
(28, 'AE303', 1, 6, 1, 1, 4, 0, 1, 1, 249.00),
(29, 'AE304', 1, 6, 2, 1, 3, 8, 1, 1, 349.00),
(30, 'AE305', 1, 6, 1, 1, 2, 0, 1, 0, 219.00),
(31, 'VW101', 1, 7, 1, 0, 2, 0, 1, 0, 199.00),
(32, 'VW102', 1, 7, 2, 1, 1, 0, 1, 0, 209.00),
(33, 'VW103', 3, 7, 1, 0, 4, 4, 1, 1, 269.00),
(34, 'VW104', 1, 7, 2, 0, 2, 0, 1, 0, 189.00),
(35, 'VW105', 1, 7, 3, 0, 2, 0, 1, 1, 239.00),
(36, 'VW201', 1, 8, 2, 0, 2, 0, 1, 0, 179.00),
(37, 'VW202', 3, 8, 1, 0, 2, 3, 1, 0, 249.00),
(38, 'VW203', 1, 8, 1, 1, 1, 0, 1, 0, 199.00),
(39, 'VW204', 1, 8, 2, 0, 3, 0, 1, 1, 229.00),
(40, 'VW205', 1, 8, 1, 0, 2, 0, 1, 0, 189.00),
(41, 'VW301', 1, 9, 2, 1, 2, 0, 1, 0, 219.00),
(42, 'VW302', 3, 9, 2, 0, 3, 5, 1, 1, 289.00),
(43, 'VW303', 1, 9, 1, 0, 4, 0, 1, 0, 209.00),
(44, 'VW304', 1, 9, 3, 0, 2, 0, 1, 1, 259.00),
(45, 'VW305', 1, 9, 1, 1, 2, 0, 1, 0, 199.00),
(46, 'VE101', 1, 10, 2, 0, 2, 0, 1, 0, 229.00),
(47, 'VE102', 3, 10, 1, 0, 3, 3, 1, 0, 259.00),
(48, 'VE103', 1, 10, 2, 0, 2, 0, 1, 1, 279.00),
(49, 'VE104', 1, 10, 1, 1, 1, 0, 1, 0, 189.00),
(50, 'VE105', 3, 10, 2, 0, 4, 2, 1, 1, 299.00),
(51, 'VE201', 1, 11, 1, 0, 2, 0, 1, 0, 209.00),
(52, 'VE202', 1, 11, 2, 1, 1, 0, 1, 0, 199.00),
(53, 'VE203', 1, 11, 3, 0, 1, 0, 1, 1, 249.00),
(54, 'VE204', 3, 11, 1, 0, 2, 4, 1, 0, 239.00),
(55, 'VE205', 1, 11, 2, 0, 2, 0, 1, 0, 189.00),
(56, 'VE301', 1, 12, 1, 0, 3, 0, 1, 1, 269.00),
(57, 'VE302', 1, 12, 2, 1, 2, 0, 1, 0, 219.00),
(58, 'VE303', 3, 12, 2, 0, 3, 8, 1, 0, 279.00),
(59, 'VE304', 1, 12, 1, 0, 3, 0, 1, 1, 319.00),
(60, 'VE305', 1, 12, 2, 0, 2, 0, 1, 0, 199.00),
(61, 'Outside Courtyard', 2, 1, 2, 1, 0, 100, 1, 0, NULL), 
(62, 'Pool Patio', 2, 4, 1, 1, 0, 50, 0, 0, NULL),
(63, 'Conference Room 1', 2, 3, 1, 1, 0, 25, 1, 1, NULL),
(64, 'Conference Room 2', 2, 6, 1, 1, 0, 40, 1, 1, NULL),
(65, 'Conference Room 3', 2, 5, 1, 1, 0, 15, 1, 1, NULL),
(66, 'Conference Room 4', 2, 9, 1, 1, 0, 30, 1, 1, NULL),
(67, 'Oasis Restaurant and Bar', 2, 1, 1, 0, 0, 125, 1, 0, NULL),
(68, 'Gym and Spa', 2, 7, 1, 0, 0, 60, 1, 0, NULL),
(69, 'Grand Ballroom', 2, 10, 1, 0, 0, 500, 1, 0, NULL),
(70, 'Racquetball Court', 2, 7, 1, 0, 0, 250, 1, 0, NULL);

INSERT INTO room_adjacency (adjacencyId, roomId) VALUES
(1, 1),
(1, 2),
(2, 4),
(2, 5),
(3, 6),
(3, 7),
(4, 9),
(4, 10),
(5, 11),
(5, 12),
(6, 13),
(6, 14),
(7, 16),
(7, 17),
(8, 18),
(8, 19),
(9, 21),
(9, 22),
(10, 23),
(10, 24);

INSERT INTO room_bed (roomId, bedTypeId, quantity, isTemporary) VALUES 
(1, 2, 1, 0), -- the reason why we have multiple roomId (is because 1. bridging table 2. means the room has 2 beds that are different)
(2, 2, 1, 0),
(2, 1, 1, 0),
(3, 4, 1, 0),
(3, 3, 1, 1),
(4, 1, 2, 0),
(5, 2, 1, 1),
(6, 2, 1, 0),
(7, 1, 2, 0),
(8, 2, 2, 0),
(9, 2, 2, 1),
(10, 2, 2, 1),
(11, 1, 2, 0),
(12, 2, 1, 0),
(13, 2, 1, 0),
(13, 1, 1, 0),
(14, 5, 1, 0),
(15, 4, 2, 0),
(16, 2, 1, 0),
(17, 2, 1, 0),
(17, 3, 1, 1),
(18, 1, 2, 1),
(19, 2, 1, 1),
(20, 2, 1, 1),
(20, 1, 1, 1),
(21, 1, 2, 0),
(22, 2, 1, 0),
(23, 2, 1, 0),
(23, 1, 1, 0),
(24, 2, 2, 1),
(25, 6, 1, 0),
(26, 2, 1, 0),
(27, 1, 2, 0),
(28, 2, 2, 0),
(29, 2, 1, 0),
(29, 1, 1, 0),
(30, 2, 1, 0),
(31, 1, 2, 0),
(32, 1, 1, 0),
(33, 2, 2, 1),
(34, 2, 1, 0),
(35, 5, 1, 0),
(36, 1, 2, 0),
(37, 2, 1, 1),
(38, 1, 1, 0),
(39, 2, 1, 0),
(39, 1, 1, 0),
(40, 2, 1, 0),
(41, 1, 2, 0),
(42, 2, 1, 1),
(42, 1, 1, 1),
(43, 2, 2, 0),
(44, 4, 1, 0),
(45, 2, 1, 0),
(46, 1, 2, 0),
(47, 2, 1, 1),
(47, 1, 1, 1),
(48, 2, 1, 0),
(49, 1, 1, 0),
(50, 2, 2, 1),
(51, 2, 1, 0),
(52, 1, 1, 0),
(53, 1, 1, 0),
(54, 1, 2, 1),
(55, 2, 1, 0),
(56, 2, 1, 0),
(56, 3, 1, 1),
(57, 6, 1, 0),
(58, 2, 1, 1),
(58, 1, 1, 1),
(59, 5, 1, 0),
(59, 1, 1, 0),
(60, 1, 2, 0);

INSERT INTO customer_message (messageId, customerId, staffId, messageDateTime, messageText, isConfidential) VALUES
(1, 1, NULL, '2026-11-12 17:17:30', 'Need help unlocking gym door', 0),
(2, 4, 3, '2026-11-14 08:19:30', 'Faucet water is brown', 1),
(3, 2, NULL, '2026-11-14 09:05:00', 'In the Astoria ballroom conference until 5 PM', 0),
(4, 5, 1, '2026-11-14 11:42:15', 'Call from office: please call back about contract', 0),
(5, 6, NULL, '2026-11-14 13:30:00', 'Do not disclose my location to callers', 1),
(6, 3, 9, '2026-11-15 10:12:45', 'Dinner reservation confirmed for 7 PM', 0),
(7, 8, 1, '2026-11-15 14:55:20', 'Caller asked for room number; not given', 1),
(8,  7,  NULL, '2026-11-15 16:00:00', 'At the health club, back by 6 PM', 0),
(9,  10, 9, '2026-11-16 08:47:10', 'Airport shuttle booked for 6 AM tomorrow', 0),
(10, 12, NULL, '2026-11-16 19:20:35', 'Unavailable until morning, leave a message', 1);

INSERT INTO access_card (cardId, pin, issueDate, customerId, staffId) VALUES
(1, '256769', '2026-10-12', 1, NULL),
(2, '340645', '2026-09-14', 2, NULL),
(3, '918273', '2026-10-03', 3, NULL),
(4, '472910', '2026-10-05', 4, NULL),
(5, '603158', '2026-10-08', 5, NULL),
(6, '815402', '2026-10-15', 6, NULL),
(7, '129384', '2026-10-18', 7, NULL),
(8, '764521', '2026-10-21', 8, NULL),
(9, '381947', '2026-10-25', 9, NULL),
(10, '590286', '2026-11-01', 10, NULL),
(11, '247163', '2026-11-04', 11, NULL),
(12, '836015', '2026-11-10', 12, NULL),
(13, '104857', '2025-03-01', NULL, 1),
(14, '662039', '2025-06-15', NULL, 2),
(15, '453812', '2025-08-20', NULL, 3),
(16, '978104', '2026-01-10', NULL, 4),
(17, '210497', '2024-11-05', NULL, 5),
(18, '735620', '2026-02-18', NULL, 6),
(19, '389571', '2025-09-12', NULL, 8),
(20, '517246', '2024-07-22', NULL, 10);

INSERT INTO card_reader (cardReaderId, roomId) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20),
(21, 21),
(22, 22),
(23, 23),
(24, 24),
(25, 25),
(26, 26),
(27, 27),
(28, 28),
(29, 29),
(30, 30),
(31, 31),
(32, 32),
(33, 33),
(34, 34),
(35, 35),
(36, 36),
(37, 37),
(38, 38),
(39, 39),
(40, 40),
(41, 41),
(42, 42),
(43, 43),
(44, 44),
(45, 45),
(46, 46),
(47, 47),
(48, 48),
(49, 49),
(50, 50),
(51, 51),
(52, 52),
(53, 53),
(54, 54),
(55, 55),
(56, 56),
(57, 57),
(58, 58),
(59, 59),
(60, 60),
(61, 61),
(62, 62),
(63, 63),
(64, 64),
(65, 65),
(66, 66),
(67, 67),
(68, 68),
(69, 69),
(70, 70);
 
INSERT INTO card_swipe (swipeId, swipeDateTime, direction, cardId, cardReaderId) VALUES
(1, '2025-06-01 15:10:00', 'Entry', 1, 1),
(2, '2025-06-01 18:30:00', 'Exit', 1, 1),
(3, '2025-06-03 15:20:00', 'Entry', 2, 2),
(4, '2025-06-03 19:45:00', 'Exit', 2, 2),
(5, '2025-06-10 15:15:00', 'Entry', 3, 3),
(6, '2025-06-10 17:30:00', 'Exit', 3, 3),
(7, '2025-07-15 15:05:00', 'Entry', 4, 4),
(8, '2025-07-15 20:00:00', 'Exit', 4, 4),
(9, '2025-07-16 09:00:00', 'Entry', 4, 6),
(10, '2025-07-16 10:30:00', 'Exit', 4, 6);

INSERT INTO reservation(reservationId, billingPartyId, date, reservationStatus, requestedStartDateTime, requestedEndDateTime, smokingPreference, requestedBedType, requestedLocation, requestedProximities) VALUES
(1, 5, '2025-02-01', 'Confirmed', '2025-03-14', '2025-03-17', 0, NULL, 'Astoria West', 'Poolside view please!'),
(2, 11, '2025-06-03', 'Confirmed', '2025-06-09', '2025-06-13', 0, 'king', 'Valencia West', NULL),  
(3, 2, '2025-07-10', 'Confirmed', '2025-09-21', '2025-09-23', 0, NULL, NULL, NULL), 
(4, 8, '2025-12-15', 'Confirmed', '2026-01-10', '2026-01-15', 1, 'king', 'Astoria East', 'N/A'),
(5, 13, '2026-04-20', 'Confirmed', '2026-07-20', '2026-07-23', 0, 'extra long', NULL, 'I prefer a room on the first floor if possible!'),
(6, 1, '2026-08-08', 'Confirmed', '2026-12-02', '2026-12-07', 0, 'king', NULL, 'Nonsmoking room.'),
(7, 9, '2026-09-28', 'Confirmed', '2026-12-18', '2026-12-23', 0, 'queen', 'Astoria West', 'Would love a view of the courtyard'),
(8, 15, '2026-11-17', 'Confirmed', '2027-01-12', '2027-01-17', 0, 'queen', NULL, NULL),
(9, 10, '2025-07-25', 'Confirmed', '2025-08-25 5:00:00', '2025-08-25 8:00:00', NULL, NULL, 'One of the conference rooms', NULL),   
(10, 2, '2026-03-03', 'Confirmed', '2026-06-10 12:00:00', '2026-06-10 15:00:00', NULL, NULL, 'Conference room.', NULL),   
(11, 2, '2026-03-03', 'Confirmed', '2026-06-11 12:00:00', '2026-06-11 15:00:00', NULL, NULL, 'Conference room.', NULL),   
(12, 3, '2026-09-12', 'Confirmed', '2026-11-07 12:00:00', '2026-11-07 15:00:00', NULL, NULL, 'Spa!!', NULL),
(13, 18, '2026-11-26', 'Pending', '2026-12-23 17:00:00', '2026-12-23 20:00:00', NULL, NULL, 'Ballroom, thanks!', NULL);   

-- meetingRateId can be NULL if the reservation is for a sleeping room and not a meeting room
INSERT INTO room_assignment(assignmentId, reservationId, roomId, meetingRateId, startDateTime, endDateTime, assignmentStatus, numberNights) VALUES
(1, 1, 1, NULL, '2025-03-14 15:00:00', '2025-03-17 11:00:00', 'Completed', 3), -- our standard checkin time is 3 pm, standard checkout time is 11 am
(2, 2, 39, NULL, '2025-06-08 15:00:00', '2025-06-12 11:00:00', 'Completed', 4),
(3, 3, 48, NULL, '2025-09-21 15:00:00', '2025-09-23 11:00:00', 'Completed', 2),
(4, 4, 29, NULL, '2026-01-10 15:00:00', '2026-01-15 11:00:00', 'Completed', 5),
(5, 5, 6, NULL, '2026-07-19 15:00:00', '2026-07-22 11:00:00', 'Completed', 3),
(6, 6, 35, NULL, '2026-12-02 15:00:00', '2026-12-07 11:00:00', 'In Progress', 5), -- the statuses are assuming Dec. 2026 is the present
(7, 7, 15, NULL, '2026-12-18 15:00:00', '2026-12-23 11:00:00', 'Scheduled', 5),
(8, 8, 22, NULL, '2027-01-12 15:00:00', '2027-01-17 11:00:00', 'Scheduled', 5),
(9, 9, 61, 5, '2025-08-25 17:00:00', '2025-08-25 20:00:00', 'Completed', NULL),
(10, 10, 66, 3, '2026-06-10 12:00:00', '2026-06-10 15:00:00', 'Completed', NULL),
(11, 10, 64, 3, '2026-06-11 12:00:00', '2026-06-11 15:00:00', 'Completed', NULL),
(12, 11, 68, 4, '2026-11-07 12:00:00', '2026-11-07 15:00:00', 'Completed', NULL),
(13, 12, 69, 6, '2026-12-22 17:00:00', '2026-12-22 20:00:00', 'Scheduled', NULL);
 
INSERT INTO transaction_usage (transactionId, serviceRateId, quantity, transactionCharge, transactionDateTime, assignmentId) VALUES  
-- Room AW101: $269 x 3 nights
(1, NULL, NULL, 807.00, '2025-02-01 15:00:00', 1),
-- Room VW204: $229 x 4 nights
(2, NULL, NULL, 916.00, '2025-06-03 15:00:00', 2),
-- Room VE103: $279 x 2 nights
(3, NULL, NULL, 558.00, '2025-07-10 15:00:00', 3),
-- Room AE304: $349 x 5 nights
(4, NULL, NULL, 1745.00, '2025-12-15 15:00:00', 4),
-- Room AW201: $189 x 3 nights
(5, NULL, NULL, 567.00, '2026-04-20 15:00:00', 5),
-- Room VW105: $239 x 5 nights
(6, NULL, NULL, 1195.00, '2026-08-08 15:00:00', 6),
-- Room AW305: $319 x 5 nights
(7, NULL, NULL, 1595.00, '2026-9-28 15:00:00', 7),
-- Room AE202: $209 x 5 nights
(8, NULL, NULL, 1045.00, '2026-11-17 15:00:00', 8),
-- supper slot: $500
(9, NULL, NULL, 500.00, '2025-07-25', 9),
-- lunch slot: $500
(10, NULL, NULL, 500.00, '2026-03-03', 10),
-- lunch slot: $500
(11, NULL, NULL, 500.00, '2026-03-03', 11),
-- afternoon slot: $250
(12, NULL, NULL, 250.00, '2026-09-12', 12),
-- evening slot: $250
(13, NULL, NULL, 250.00, '2026-11-26', 13),
-- 3 telephone calls at $5 each
(14, 1, 3, 15.00, '2025-06-02 10:15:00', 1),
-- Restaurant purchase: variable price
(15, 2, NULL, 86.50, '2025-06-04 12:45:00', NULL),
-- 2 photocopying units at $20 each
(16, 4, 2, 40.00, '2025-06-11 09:20:00', 3),
-- 2 massages at $75 each
(17, 8, 2, 150.00, '2025-07-16 14:30:00', 4),
-- Retail shop purchase: variable price
(18, 7, NULL, 125.75, '2025-07-17 16:10:00', NULL),
-- 1 racquetball session at $100
(19, 9, 1, 100.00, '2025-09-16 11:00:00', 5),
-- 3 equipment rentals at $40 each
(20, 5, 3, 120.00, '2025-11-16 08:45:00', 6),
-- Room service: variable price
(21, 10, NULL, 42.50, '2026-01-16 19:15:00', 7);

INSERT INTO charge_allocation (transactionId, billingPartyId, allocatedCharge) VALUES 
(1, 5, 807.00),
(2, 11, 458.00),
(2, 16, 458.00),
(3, 2, 558.00),
(4, 8, 872.50),
(4, 19, 872.50),
(5, 13, 567.00),
(6, 1, 597.50),
(6, 12, 597.50),
(7, 9, 1595.00),
(8, 15, 522.50),
(8, 20, 522.50),
(9, 10, 500.00),
(10, 2, 500.00),
(11, 2, 500.00),
(12, 3, 250.00),
(13, 18, 250.00),
(14, 5, 15.00),
(15, 4, 43.25),
(15, 17, 43.25),
(16, 2, 40.00),
(17, 8, 75.00),
(17, 19, 75.00),
(18, 6, 125.75),
(19, 13, 100.00),
(20, 1, 60.00),
(20, 7, 60.00),
(21, 9, 42.50);

INSERT INTO event_room_assignment (eventId, assignmentId) VALUES
(1, 9), 
(2, 10), 
(2, 11),
(3, 12),
(4, 13);  

