# HajUsput
Everything about the project is going to be underneath the instructions.
## Instructions to get started
Clone the project
```
git clone https://github.com/karicamar/HajUsput
```
Open a terminal in the root folder
```
set STRIPE_SECRET_KEY=YourSecretKey
```
Run the backend API
```
docker-compose up --build
```
### Desktop App for the Admin
Located at ```/HajUsputUI/hajusput_desktop```

To run
```
flutter pub get
```
```
flutter run -d windows
```
**Credentials**

Username: ```desktop```

Password: ```test```

### Mobile App for the User
Located at ```/HajUsputUI/hajusput_mobile```

To run
```
flutter pub get
```
```
flutter run --dart-define=STRIPE_PUBLISHABLE_KEY=YourStripePublishableKey
```
```
flutter run --dart-define=baseUrl=https://xxx.xxx.x.x:xxxx/
```
**Credentials**

Username: ```mobile```

Password: ```test```

# About
HajUsput connects drivers with passengers to share rides, making travel more affordable, eco-friendly, and social. Whether you’re looking to save on travel costs or reduce your carbon footprint, HajUsput makes it easy for you to find a ride or offer a seat on your journey.
### Key Features:
- Affordable Travel: Split the cost of fuel and tolls with fellow passengers, saving money on your trips.
- Easy to Use: Just enter your destination, choose your ride, and you're good to go. Booking is simple, quick, and secure.
- Flexible Options: Whether you're a driver looking to share a ride or a passenger searching for one, we have options for everyone.
- Trusted Community: With a built-in rating system, you can choose who you travel with based on their past reviews, ensuring a safe and friendly experience.
- Eco-Friendly Rides: Reduce your carbon footprint by sharing rides with others and making travel more sustainable.
# Technologies Used
I tried to follow SOLID principles, align it with clean architecture(clean code practices, design patterns, generic programming and inheritance), enabling easier updates, better testing, and more maintainable code in the long run.

Some of the technologies and packages used: 
- **C#**: ASP.NET Core Web API
- **Flutter**: Cross-platform UI development
- **RabbitMQ + Google SMTP**:
  - Producer: Publishes email tasks (e.g., user registration) to a RabbitMQ queue.
  - Consumer: Listens to the queue, processes tasks, and sends emails via Google SMTP.
- **Microsoft SQL Server**: for Database Management and storing application data
- **Entity Framework**: for Data Management
- **Hangfire**: for Background Jobs
- **Google Maps Platform**: Maps SDK, Routes API & Directions API
- **Basic Authentication & Authorization**: the backend uses C# for handling auth.
- **AutoMapper & Autofac Integration**: for Object Mapping & DI Management
- **ML.NET Price Prediction**: a machine learning model for price prediction
- **Stripe**: for the Mobile Payment system
- **Docker**: for containerization of the API, SQL database, and RabbitMQ
- **iTextSharp**: for generating PDF reports (financial, payment summaries, etc.)
- **Stateless (NuGet Package)**: for implementing state machine logic

## Flutter Mobile App Screenshots

<table>
  <tr>
    <td><img src="screenshots/Screenshot_2025-02-11-13-56-32-867_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-13-57-34-586_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-13-57-52-543_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-13-58-08-714_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-13-59-03-831_com.example.hajusput_mobile.jpg" width=200></td>
  </tr>
  <tr>
    <td><img src="screenshots/Screenshot_2025-02-11-14-05-08-850_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-14-05-44-006_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-14-05-58-798_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-14-06-08-585_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-14-06-33-806_com.example.hajusput_mobile.jpg" width=200></td>
  </tr>
  <tr>
    <td><img src="screenshots/Screenshot_2025-02-11-14-06-37-364_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-14-06-42-367_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-14-06-50-219_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-16-36-36-938_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-16-36-48-419_com.example.hajusput_mobile.jpg" width=200></td>
  </tr>
  <tr>
    <td><img src="screenshots/Screenshot_2025-02-11-16-36-52-181_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-16-36-57-507_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-16-37-13-335_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-16-37-17-444_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-16-37-21-777_com.example.hajusput_mobile.jpg" width=200></td>
  </tr>
  <tr>
    <td><img src="screenshots/Screenshot_2025-02-11-16-37-39-380_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-16-37-43-138_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-16-37-56-572_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-16-38-08-297_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-16-38-12-136_com.example.hajusput_mobile.jpg" width=200></td>
  </tr>
  <tr>
    <td><img src="screenshots/Screenshot_2025-02-11-16-38-18-781_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-16-38-28-099_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-16-38-33-120_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-16-38-43-973_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-16-38-50-499_com.example.hajusput_mobile.jpg" width=200></td>
  </tr>
  <tr>
    <td><img src="screenshots/Screenshot_2025-02-11-16-44-31-036_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-16-46-15-352_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-16-46-47-177_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-16-46-53-316_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-17-38-40-433_com.example.hajusput_mobile.jpg" width=200></td>
  </tr>
  <tr>
    <td><img src="screenshots/Screenshot_2025-02-11-17-38-48-073_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-17-39-28-053_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-17-39-42-125_com.example.hajusput_mobile.jpg" width=200></td>
    <td><img src="screenshots/Screenshot_2025-02-11-14-04-45-303_com.example.hajusput_mobile.jpg" width=200></td>
  </tr>
</table>

## Flutter Desktop App Screenshots
<table>
  <tr>
    <td><img src="screenshots/2025-02-13 14_22_29-hajusput_desktop.png" width=600></td>
    <td><img src="screenshots/2025-02-13 14_14_41-hajusput_desktop.png" width=600></td>
  </tr>
  <tr>
    <td><img src="screenshots/2025-02-13 14_15_40-hajusput_desktop.png" width=600></td>
    <td><img src="screenshots/2025-02-13 14_16_09-hajusput_desktop.png" width=600></td>
  </tr>
  <tr>
    <td><img src="screenshots/2025-02-13 14_18_08-hajusput_desktop.png" width=600></td>
    <td><img src="screenshots/2025-02-13 14_18_28-hajusput_desktop.png" width=600></td>
  </tr>
  <tr>
    <td><img src="screenshots/2025-02-13 14_19_04-hajusput_desktop.png" width=600></td>
    <td><img src="screenshots/2025-02-13 14_19_17-hajusput_desktop.png" width=600></td>
  </tr>
</table>




# License
Licensed under [MIT license](LICENSE)

