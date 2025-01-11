# Summer 24

## Question 1
You are assigned a task to develop a News feed application. The application works as follows: The user initially sees a list of news items in a home page that acts as a navigator. When a PageRoute is pushed or popped with the Navigator, the entire screen's content is replaced. The old route of the news list disappears and a new route that has the news description appears.

### (a)
If this app is developed using Flutter, and it’s been requested to choose an animation widget that can "fly" in the Navigator's overlay during the transition between the two pages. Which animation widget would you choose?
- **`Hero` widget.** It is used to animate a widget _flying_ from one screen to another.

### (b)
While designing the news description page, you wanted to create an animation effect that makes an image follow the user tap gesture across the screen. You considered the AnimatedAlign widget and the AnimatedPositioned widget to complete this task. Explain the difference between these two widgets? which widget would you choose to complete this task and why?
- `AnimatedAlign` widget is used to animate the position of a child widget across different types of alignment (topLeft, topRight, bottomLeft, etc...). Parent widget is `Align` or `Stack`.
- `AnimatedPositioned` is used to animate the position of a child widget across different absolute positions (top, left, right, bottom). Parent widget is `Stack`.

_FULL ANSWER_
| Feature               | AnimatedAlign                               | AnimatedPositioned                                |
|-----------------------|---------------------------------------------|-------------------------------------------------|
| **Parent Widget**     | `Align`/`Stack`              | Inside a `Stack`                   |
| **Animation Type**    | Animates the alignment        | Animates position (top, left, right, bottom)|
| **Properties**        | `alignment` (alignment type)               | `top`, `left`, `right`, `bottom` (positioning)  |
| **Usage Context**     | Best for animating alignment changes        | Best for animating widget positions in a `Stack`|
| **Positioning Control** | Controls position via alignment within parent | Controls position using pixel offsets in `Stack` |

### (c)
During the user interaction with the app, you wanted to display a small confirmation page to make sure the user consents to collecting metadata. To do so, you need to use a widget that prevents the user from interacting with widgets behind itself, and can be configured with an animated color value to make sure the use will respond to the confirmation page before returning back to the app. Which animation widget would be the most suitable to implement this task?
- Use the `ModalBarrier` widget. It animates with a background color that covers the background preventing the user from accessing the background widgets.

## Question 2
You are assigned a task to develop a Fall-detection app for elderly people who live alone using Flutter. The application works as follows: The user keeps the smartphone attached to their waist while the app is running. If the user falls to the ground, the app will detect a fall-event and will trigger the text-to-speech and speech-to-text call back methods to communicate with the user. If the app fails to receive an acceptable response from the user within a specific time period, the app will contact the user’s family members and the registered doctor. The app will send a pre-configured message that has the user’s current location so that care givers can attend to the user’s location.

### (a)
Which sensor from the smartphone will you use in your design to detect the Fall event?
- I would use the `AccelerometerEvent` and detect when it reports 0 acceleration in $z$ axis.

### (b)
Explain your approach as a developer to set the threshold value of the sensor data that will decide whether the value returned from the sensor is false positive or represents a real fall event? Justify your approach.
- Calibrating the sensors on the user's end during the fall (i.e., by allowing the user to drop the phone 3 times and calculating the offset).
- Then, we can use the average of the 3 values as the threshold value, and then use a threshold value that is 1.5 times the average value to detect a fall event.
- Why choose 1.5 times the average value? Because it is more important for us to detect a fall even than to miss one. So, we would rather have a false positive than a false negative.

### (c)
You need to collect the location (Latitude and Longitude) of the user’s current location. Explain the different methods that could be used to implement this task. Which one would you choose and why?
- We can use `geolocation` or `google_maps_flutter` plugins. `geolocation` is better because it is more compact and to the point, it only does what we need and doesn't add extra irrelevant functions and classes to the codebase size.
- **EXTRA, Out-of-context.** Another approach is to perform an HTTP request with the user's IP address to a listening endpoint that sends a JSON associative array that contains the location information.
- The best approach is to use `geolocation` because it is the most compact.


## Question 3
You are assigned a task to develop a weather forecast application using flutter. The application allows the user to choose a city name from a list. Once selected, the application uses REST API interface to send a request to the server to get the temperature forecast for the next 7 days. The server sends the data in JSON format. The user should be able to use the application even if they are disconnected temporarily from the internet. The user should be able to create a list of favorite cities and retrieve it back after shutting down the application.

### (a)
There are different ways to implement data persistence in flutter. Discuss these options and explain the differences between them.
- **Shared Preferences.** Stores data in key-value pairs. It is used for storing small data that is not sensitive.
- **Files.** Stores data in files. It is used for storing large data that is not sensitive.
- **SQLite.** Stores data in a relational database. It is used for storing large data that is sensitive.
- **Firestore.** Stores data in a cloud database. It is used for storing large data that is sensitive.

### (b)
Explain the advantage of using Real-Time database in Firebase. Do you think Firebase would be a valid option in this application? Why?
- **Advantages of Real-Time Database.** NoSQL, stores as JSON, schema-less, real-time updates, offline supports, cross-platform support, scalability, and security.

### (c)
Discuss the implementation of the app database: (how many tables? the table(s) structure? UI interface(s)? queries? , etc) and explain your plans to meet the app requirements.
-  DB implementation tables: `cities`, `favorites`
- `cities` SQL:
```sql
CREATE TABLE cities (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    forecast_date DATE NOT NULL,
    temperature REAL NOT NULL
    condition TEXT NOT NULL
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```
- `favorites` SQL:
```sql
CREATE TABLE favorites (
    id INTEGER PRIMARY KEY,
    city_id INTEGER NOT NULL,
    FOREIGN KEY (city_id) REFERENCES cities(id)
);
```
- UI Interface: 2 pages, one for selecting a city, and one for displaying the forecast.
- Queries: 
    - Insert weather into `cities` table: `INSERT INTO cities (name, forecast_date, temperature, condition) VALUES (?, ?, ?, ?);`
    - Get weather for a city: `SELECT forecast_date, temperature, condition FROM cities WHERE name = ? ORDER BY forecast_date ASC;`
    - Insert favorite city: `INSERT INTO favorites (city_id) VALUES (?);`
    - Get favorite cities: `SELECT name, forecast_date, temperature, condition FROM cities WHERE id IN (SELECT city_id FROM favorites);`
    ...
- Plans:
    - Offline support, REST API integration with weather endpoint, favorites management, UI designing, and error handling.


## Question 4
You are assigned a task to develop a To-do-List application using Flutter. The application has two pages. The first page contains the summary of the tasks and allows users to add/delete the task. The second page is used to edit/save the tasks.

### (a)
Draw a sketch for the UI of the first and second pages and explain all the widgets used in this application.
- ??? Just draw something you can with widgets you know!

### (b)
Discuss your plans for testing the application. Explain the difference between Unit tests, Widget tests, and Integration tests.
- **Unit Tests.** Tests a single function, method, or class. It is used to test the smallest unit of code
- **Widget Tests.** Tests a single widget. It is used to test the UI of the app
- **Integration Tests.** Tests the interaction between widgets. It is used to test the app as a whole or a large portion of it
- **Plans for Testing.**
    - `test` package for unit tests
    - `flutter_test` package for widget tests
    - `integration_test` package for integration tests
    - `mockito` package for mocking API requests to speed up tests and lower network usage for API testing
    - Write tests for each function, widget, and integration


### (c)
What are the advantages of using Continuous integration (CI) services in your test procedure?
- Automates testing, reduces error during small changes in large codebases, ensures RCA can be done easily, ensures that the code is always in a deployable state and is always tested. Catches errors early for fixing and allows for easier accountability.