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
flutter run --dart-define=API_HOST=xxx.xxx.xxx.xxx
```
**Credentials**

Username: ```mobile```

Password: ```test```

