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

# LICENSE
Licensed under [MIT license](LICENSE)

