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
            HostName = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "rabbitMQ",
            Port = int.Parse(Environment.GetEnvironmentVariable("RABBITMQ_PORT") ?? "5672"),
            UserName = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "guest",
            Password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest",
        };
        using var connection = factory.CreateConnection();
        using var channel = connection.CreateModel();

        channel.QueueDeclare(queue: "emailQueue", durable: false, exclusive: false, autoDelete: false, arguments: null);

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
            string smtpServer = Environment.GetEnvironmentVariable("SMTP_SERVER") ?? "smtp.gmail.com";
            int smtpPort = int.Parse(Environment.GetEnvironmentVariable("SMTP_PORT") ?? "587");
            string email = Environment.GetEnvironmentVariable("SMTP_EMAIL") ?? "haj.usput@gmail.com";
            string password = Environment.GetEnvironmentVariable("SMTP_PASSWORD") ?? "grwc uivn hgtn azyx";

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
