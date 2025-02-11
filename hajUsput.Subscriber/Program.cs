using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using System;
using System.Net.Mail;
using System.Net;
using System.Text;

class Program
{
    static void Main(string[] args)
    {
        Console.WriteLine("Starting RabbitMQ Subscriber...");

        
        var factory = new ConnectionFactory() {
            HostName = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "",
            Port = int.Parse(Environment.GetEnvironmentVariable("RABBITMQ_PORT") ?? ""),
            UserName = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "",
            Password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "",
            RequestedConnectionTimeout = TimeSpan.FromSeconds(30),
            RequestedHeartbeat = TimeSpan.FromSeconds(60),
            AutomaticRecoveryEnabled = true,
            NetworkRecoveryInterval = TimeSpan.FromSeconds(10),
        };
        Console.WriteLine($"Connecting to RabbitMQ at {factory.HostName}:{factory.Port} with user {factory.UserName}");

        using var connection = factory.CreateConnection();
        using var channel = connection.CreateModel();

        channel.QueueDeclare(queue: "emailQueue", durable: true, exclusive: false, autoDelete: false, arguments: null);

        var consumer = new EventingBasicConsumer(channel);
        consumer.Received += (model, ea) =>
        {
            var body = ea.Body.ToArray();
            var message = Encoding.UTF8.GetString(body);
            Console.WriteLine(" [x] Received {0}", message);

           
            ProcessMessage(message);
        };

        channel.BasicConsume(queue: "emailQueue", autoAck: true, consumer: consumer);

        Console.WriteLine(" Press [enter] to exit.");

        Console.ReadLine();
        Thread.Sleep(Timeout.Infinite);
        channel.Close();
        connection.Close();
    }

    static void ProcessMessage(string message)
    {
        var parts = message.Split('|');
        if (parts.Length != 2)
        {
            Console.WriteLine("Invalid message format.");
            return;
        }

        var toEmail = parts[0];
        var emailBody = parts[1];

        
        Console.WriteLine($"Processing message for {toEmail}: {emailBody}");

        
        SendEmail(toEmail, "Welcome to HajUsput", emailBody);
    }
    static void SendEmail(string toEmail, string subject, string body)
    {
        try
        {
            string smtpServer = Environment.GetEnvironmentVariable("SMTP_SERVER") ?? "";
            int smtpPort = int.Parse(Environment.GetEnvironmentVariable("SMTP_PORT") ?? "");
            string email = Environment.GetEnvironmentVariable("SMTP_EMAIL") ?? "";
            string password = Environment.GetEnvironmentVariable("SMTP_PASSWORD") ?? "";

            var smtpClient = new SmtpClient()
            {
                Host = smtpServer,
                Port = smtpPort,
                Credentials = new NetworkCredential(email, password),
                EnableSsl = true
            };

            var mailMessage = new MailMessage
            {
                From = new MailAddress(email),
                Subject = subject,
                Body = body,
                IsBodyHtml = false,
            };

            mailMessage.To.Add(toEmail);

            smtpClient.Send(mailMessage);
            Console.WriteLine("Email sent successfully.");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Failed to send email: {ex.Message}");
        }
    }
}
