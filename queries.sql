-- Query 1: For a user-supplied wing name, what is the average seating capacity of all rooms in that wing that can 
--accommodate meetings? [Resource Allocation]

-- Explanation: For the wing name the user enters, this query joins down through that wing's floors and rooms and keeps 
-- only rooms that seat more than zero people. It then returns the wing name, with how many meeting rooms 
-- the wing has and their average seating capacity.

SELECT w.wingName, COUNT(r.roomId) AS meetingRoomCount, AVG(r.seatingCapacity) AS avgSeatingCapacity
FROM wing w
JOIN floor f ON w.wingId = f.wingId
JOIN room r ON f.floorId = r.floorId
WHERE w.wingName = :wingName
AND r.seatingCapacity IS NOT NULL
AND r.seatingCapacity > 0
GROUP BY w.wingId, w.wingName;

-- Query 2: For a user-supplied date, which bedrooms are currently assigned to customers, what are the names of the customers 
-- associated with those reservations, and what is the total cost for their stay in their reserved rooms?

-- Explanation: For the date the user enters, this query joins down through the rooms and the ones that have assignments 
--from reservations, and the billing party paying for the reservation. We then join the billing party with the customer 
--to get the names of the customers paying, and it is possible there can be more than one person paying for the reservation.
--The query specifies that the room names displayed must those that are reserved within the date the user supplies, and the 
--room must be a sleeping room, or a mix-use room meaning it can be a sleeping room.

SELECT room.roomName, customer.firstName, customer.lastName, transaction_usage.transactionCharge
FROM room
JOIN room_assignment ON room.roomId = room_assignment.roomId
JOIN reservation ON room_assignment.reservationId = reservation.reservationId
JOIN billing_party ON reservation.billingPartyId = billing_party.billingPartyId
JOIN customer ON billing_party.customerId = customer.customerId
JOIN transaction_usage ON room_assignment.assignmentId = transaction_usage.assignmentId
WHERE DATE(room_assignment.startDateTime) <= :date
AND DATE(room_assignment.endDateTime) > :date
AND transaction_usage.serviceRateId IS NULL
AND room.roomTypeId IN (1, 3);

-- Query 3: Which building has the greatest number of rooms that are currently occupied or out of service for repairs? 
-- Display the building name and number of rooms.

-- Explanation: This query joins buildings with their wings, rooms, and floors, and joins the rooms with their current 
-- status to identify which rooms are occupied or under repair. The query counts the numer of these rooms in each building, 
-- and makes sure each rooms is only counted once. The subquery then calculates the number of occupied or under repair 
-- rooms in each building and finds the highest count. The HAVING statement compares each building's room count to this 
-- maximum, so only the building or buildings with the greatest number of occupied or under repair rooms are displayed.

SELECT building.buildingName, COUNT(DISTINCT roomId) as roomCount
FROM building
JOIN wing ON building.buildingId = wing.buildingId
JOIN floor ON wing.wingId = floor.wingId
JOIN room ON floor.floorId = room.floorId
JOIN room_status ON room.statusId = room_status.statusId
WHERE room_status.statusType IN ('occupied','repair')
GROUP BY building.buildingId
HAVING COUNT (DISTINCT room.roomId) = (
    SELECT MAX(roomCount)
    FROM (
        SELECT COUNT(DISTINCT room.roomId) AS roomCount
        FROM building
        JOIN wing ON building.buildingId = wing.buildingId
        JOIN floor ON wing.wingId = floor.wingId
        JOIN room ON floor.floorId = room.floorId
        JOIN room_status ON room.statusId = room_status.statusId
        WHERE room_status.statusType IN ('occupied','repair')
        GROUP BY building.buildingId
    ) AS buildingCounts

);


-- Query 4: For a user-supplied event, which rooms have been booked for the event, and what are their seating capacities?

-- Explanation: For the event the user supplies, this query joins the event with the meeting room assigned for it, and 
-- then joins those assignments with the rooms to determine which rooms have been booked for that event. The query displays 
-- the room ID, room name, and seating capacity of each room associated with the event. The WHERE statement makes sure only 
-- rooms booked for the event the user enters are displayed. Finally, the results are sorted from lowest to highest seating 
-- capacity.

SELECT room.roomId, room.roomName, room.seatingCapacity
FROM event
JOIN event_room_assignment ON event.eventId = event_room_assignment.eventId
JOIN room_assignment ON event_room_assignment.assignmentId = room_assignment.assignmentId
JOIN room ON room_assignment.roomId = room.roomId
WHERE event.eventId = :eventId
ORDER BY room.seatingCapacity ASC;

-- Query 5: Which customers have been charged more than the average total amount charged per customer? Display each 
--customer's first name, last name, and total amount charged, sorted from highest to lowest.

-- Explanation: The subquery first calculates the total charges for each customer, including those who have no charges 
-- (using the left join), and then finds the average of these totals. The HAVING statement compares each customer's total 
-- charges to this average so that only customers who have been charged more than the average are displayed. The outer query 
-- joins the customers with their billing parties and then joins the billing parties with their allocated charges to 
-- calculate the total amount charged to each customer. The query groups the charges by customer so that each customer's 
-- total can be calculated. The results disaplyed are the ones that meet the conditions from the subquery, and are then 
-- sorted from the highest to lowest total amount charged.

SELECT customer.firstName, customer.lastName, SUM(charge_allocation.allocatedCharge) AS totalCharged
FROM customer 
JOIN billing_party 
    ON customer.customerId = billing_party.customerId
JOIN charge_allocation 
    ON billing_party.billingPartyId = charge_allocation.billingPartyId
GROUP BY customer.customerId, customer.firstName, customer.lastName
HAVING totalCharged >
    (SELECT AVG(totalCharged)
    FROM
        (SELECT SUM(charge_allocation.allocatedCharge) AS totalCharged
    FROM customer 
    JOIN billing_party 
        ON customer.customerId = billing_party.customerId
    LEFT JOIN charge_allocation 
        ON billing_party.billingPartyId = charge_allocation.billingPartyId
        GROUP BY customer.customerId))
ORDER BY totalCharged DESC;

-- Query 6: For a user-supplied building, which rooms are nonsmoking, wheelchair accessible, and have a sleeping capacity 
-- of at least two guests? [Resource Allocation]

-- Explanation: For the building the user enters, this query joins down through its wings, floors and rooms and keeps only 
-- nonsmoking rooms that sleep at least two guests and sit in a wheelchair-accessible wing. It lists each matching room 
-- with its wing, floor number and sleeping capacity, sorted by wing, then floor, then room name.

SELECT b.buildingName, w.wingName, f.floorNumber, r.roomName, r.sleepingCapacity
FROM building b
JOIN wing w ON w.buildingId = b.buildingId
JOIN floor f ON f.wingId = w.wingId
JOIN room r ON r.floorId = f.floorId
WHERE b.buildingId = :buildingId
AND r.smokingStatus = 0
AND w.handicapAccessible = 1
AND r.sleepingCapacity >= 2
ORDER BY w.wingName, f.floorNumber, r.roomName;

-- Query 7: For a user-supplied reservation ID, how many rooms have been assigned to that reservation,
-- and what is their combined sleeping capacity?

-- Explanation: For the reservation ID the user enters, this query joins room assignments with room information. 
-- It counts the number of distinct rooms assigned to that reservation and calculates their combined sleeping capacity.

.parameter set :reservationId 1

SELECT
    room_assignment.reservationId,
    COUNT(DISTINCT room_assignment.roomId) AS totalRooms,
    SUM(room.sleepingCapacity) AS totalSleepingCapacity
FROM room_assignment
JOIN room
    ON room_assignment.roomId = room.roomId
WHERE room_assignment.reservationId = :reservationId
GROUP BY room_assignment.reservationId;

-- Query 8: For a start and end date supplied by the user, which room assignments overlap with that period?

-- Explanation: For the start and end dates the user enters, this query joins room assignments with reservations 
-- and identifies assignments that overlap with the specified period. It returns the room ID, reservation ID, 
-- assignment start and end dates, and reservation status, sorted by room ID.

.parameter set :startDate '2025-06-01 00:00:00'
.parameter set :endDate '2025-06-05 00:00:00'

SELECT
    room_assignment.roomId,
    room_assignment.reservationId,
    room_assignment.startDateTime,
    room_assignment.endDateTime,
    reservation.reservationStatus
FROM room_assignment
JOIN reservation
    ON room_assignment.reservationId = reservation.reservationId
WHERE room_assignment.startDateTime < :endDate
    AND room_assignment.endDateTime > :startDate
ORDER BY room_assignment.roomId;



