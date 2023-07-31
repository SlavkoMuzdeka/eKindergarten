# eKindergarten

## Project Motivation

The "eKindergarten" project aims to create a modern and efficient system for managing kindergarten institutions. The project will utilize Java programming language and MySQL database to handle various aspects, such as kindergarten details, personnel records, child data, group allocation, daily activities, and financial transactions. By integrating a MySQL database, the project will ensure secure and reliable data storage and retrieval, providing a user-friendly interface for kindergarten administrators to manage and access information easily.

## Getting started

Follow these steps to set up and run the eKindergarten on your local machine:

1. Prerequisites:

   - Install JDK 11 or later: [Java SE Development Kit]('https://www.oracle.com/java/technologies/downloads/#java11')
   - Install Eclipse IDE: [Eclipse IDE for Java Developers]('https://www.eclipse.org/downloads/packages/')
   - Install JavaFX: [JavaFX SDK]('https://openjfx.io/')
   - Install Scene Builder: [Scene Builder Download]('https://gluonhq.com/products/scene-builder/')

2. Clone the repository:

```bash
    git clone https://github.com/SlavkoMuzdeka/eKindergarten.git
```

3. Open the project in Eclipse IDE:

   - Click `File > Open Projects from File System`... and select the cloned repository.

4. Configure JavaFX and Scene Builder in Eclipse:

   - Follow the instructions on [Eclipse and JavaFX]('https://openjfx.io/openjfx-docs/#eclipse') Setup to set up JavaFX and Scene Builder.

5. Set up the MySQL database:

   - Execute the provided SQL scripts to create the required database schema and tables.

6. Update the database configuration:

   - In the project source code, locate the database configuration file and provide the necessary credentials to connect to your MySQL database.

7. Run the application:

   - Right-click on the main class and select Run As > Java Application.

## Key Features

- `Kindergarten Information`: Keep track of different kindergartens with details like name, address, and contact number.

- `Personnel Management`: Manage personnel, including administrators and caregivers. Store their unique IDs, names, surnames, dates of birth, and addresses.

- `Administrator Details`: Admins are identified by unique login credentials, i.e., username and password, and their corresponding salary.

- `Caregiver Details`: Caregivers are assigned medical certificates and hygiene tests during hiring, with the ability to store multiple certificates over time.

- `Child Enrollment`: Record information about children enrolled in the kindergarten, including height, weight, and medical records. Capture entry and exit times.

- `Membership Fees`: Keep records of monthly membership fees for each child, including the type of service, the amount to be paid, and payment status.

- `Group Management`: Organize caregivers and children into groups within the kindergarten. Monitor the assignment of caregivers to specific groups and the duration of the assignments.

- `Activity Scheduling`: Plan and schedule daily activities for each group with a description, date, and duration. Assign activities to multiple groups as needed.

- `MySQL Database Integration`: Utilize MySQL as the back-end relational database for storing and retrieving information.
